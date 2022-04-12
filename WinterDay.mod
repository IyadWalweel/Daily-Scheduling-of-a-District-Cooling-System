/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Iyad WALWIL 
 * Creation Date: 14þ/10þ/2021 at 7:31:15 ã
 *********************************************/
 
 int h = 23;             // Number of periods for one day 
 
/****************************************************************************/

 // IMPORTING THE DATA FILE VARIABLES         "DATA FILE NAME: DailySchedulingWinter"
 int LS=...;
 float Cmin[1..LS]=...;
 float Cmax[1..LS]=...;
 float a[1..LS]=...;
 float b[1..LS]=...;
 float NS[1..LS]=...;
 float D[0..h]=...;
 float EP[0..h]=...;
 
/****************************************************************************/

/**  DECISION VARIABLES  **/
 dvar float+ C[1..LS][0..h];
 dvar boolean Y[1..LS][0..h];
 
/**  OBJECTIVE FUNCTION  **/
 minimize sum(i in 1..LS, j in 0..h) (a[i]*C[i][j] + b[i]*Y[i][j])*EP[j];
 
/**  CONSTRAINTS  **/
 subject to{
 
/* Standard Chillers Production Range and determining the active chillers */
 forall(j in 0..h, i in 1..LS) C[i][j] <= Cmax[i]*Y[i][j];
 forall(j in 0..h, i in 1..LS) C[i][j] >= Cmin[i]*Y[i][j];

 /* Demand Satisfaction */
 forall(j in 0..h) sum(i in 1..LS) C[i][j] >= D[j];
  
 }
 