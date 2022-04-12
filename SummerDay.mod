/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Iyad WALWIL
 * Creation Date: 26þ/10þ/2021 at 4:14:41 ã
 *********************************************/
 
 int h = 23;             // Number of periods for one day 
 
/****************************************************************************/

 // IMPORTING THE DATA FILE VARIABLES         "DATA FILE NAME: DailySchedulingSummer"
 int LS=...;
 float Cmin[1..LS]=...;
 float Cmax[1..LS]=...;
 float a[1..LS]=...;
 float b[1..LS]=...;
 int NS[1..LS]=...;
 int LI=...;
 int Gammamin_cold[1..LI]=...;
 int Gammamax_cold[1..LI]=...;
 int Gammamin_ice[1..LI]=...;
 int Gammamax_ice[1..LI]=...;
 float alpha_cold[1..LI]=...;
 float beta_cold[1..LI]=...;
 float alpha_ice[1..LI]=...;
 float beta_ice[1..LI]=...;
 int NI[1..LI]=...;
 int IceStoCap=...;
 float D[0..h]=...;
 float EP[0..h]=...;
 
/****************************************************************************/

/**  DECISION VARIABLES  **/
/* (1) Standard Chillers Decision Variables */
 dvar float+ c[1..LS][0..h];    
 dvar int+ n[1..LS][0..h];
 
/* (2) Ice Chillers Decision Variables */ 
 dvar float+ Gamma_Cold[0..h];
 dvar float+ Gamma_Ice[0..h];
 dvar int+ n_Cold[0..h];
 dvar int+ n_Ice[0..h];
 dvar float+ Gamma_Melted[0..h];
 dvar float+ Gamma_Rest[0..h];
 
/**  OBJECTIVE FUNCTION  **/
 minimize sum(i in 1..LS, k in 0..h) (a[i]*c[i][k] + b[i]*n[i][k])*EP[k]
 			+ sum(i in 1..LI, k in 0..h) (alpha_cold[i]*Gamma_Cold[k] + beta_cold[i]*n_Cold[k])*EP[k]
 			+ sum(i in 1..LI, k in 0..h) (alpha_ice[i]*Gamma_Ice[k] + beta_ice[i]*n_Ice[k])*EP[k];
 
/**  CONSTRAINTS  **/
subject to{
 
/* Standard Chillers Production Range */
 forall(k in 0..h, i in 1..LS) c[i][k] <= Cmax[i]*n[i][k];
 forall(k in 0..h, i in 1..LS) c[i][k] >= Cmin[i]*n[i][k];
 
/* For each period, the number of ACTIVE Standard Chillers of level i should be less than or equal
                  to the number of all chillers for this level */ 
 forall(i in 1..LS, k in 0..h) n[i][k] <= NS[i]; 
 
/* Ice Chillers Production Range */
 forall(k in 0..h) Gamma_Cold[k] <= Gammamax_cold[1]*n_Cold[k];
 forall(k in 0..h) Gamma_Cold[k] >= Gammamin_cold[1]*n_Cold[k];
 forall(k in 0..h) Gamma_Ice[k] <= Gammamax_ice[1]*n_Ice[k];
 forall(k in 0..h) Gamma_Ice[k] >= Gammamin_ice[1]*n_Ice[k];
 
/* For each period, either the ice chillers are off or on and they produce ICE or COOLING POWER but NOT both */
 forall(k in 0..h) n_Cold[k] + n_Ice[k] <= NI[LI];
 
/* The ice inventory at the beginning of the day is assumed to be equal to 0. 
 		Thus, there is no ice to melt   */
 Gamma_Melted[0] == 0;
 
/* At the end of h = 0, the inventory will either contain the produced ice during h = 0 or nothing */ 
 Gamma_Rest[0] == Gamma_Ice[0];
 
/* For each period, we can melt at most the amount of ice in the inventory */
 forall(k in 1..h) Gamma_Melted[k] <= Gamma_Rest[k-1];
 
/* At the end of each period, the ice amount is computed recursively as follows */ 
 forall(k in 1..h) Gamma_Rest[k] == Gamma_Ice[k] + Gamma_Rest[k-1] - Gamma_Melted[k] ;
 
 /* For each period, the ice amount in the inverntory shouldn't exceeds the inventory capacity */ 
 forall(k in 0..h) Gamma_Rest[k] <= IceStoCap;
 
 /* Demand Satisfaction */
 forall(k in 0..h) (sum(i in 1..LS) c[i][k]) + Gamma_Cold[k] + Gamma_Melted[k]  >= D[k];
 
} 
 
 
