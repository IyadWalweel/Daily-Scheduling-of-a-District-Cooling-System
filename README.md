# Daily Scheduling of a District Cooling System
#### Supervised by: Mrs. Céline Gicquel.
#### Course: Introduction to Operational Research and Combinatorics.
#### Software: CPLEX Studio IDE 12.8.0

This project is based on the ongoing work of Bingqian Liu, Ph.D. student at EDF R&D China.

## Introduction 
A district cooling system (DCS) is a centralized cooling supply system. Its main function is to cool down water and to distribute it through an underground pipe network to the buildings in the district to provide them with air conditioning. DCSs usually are much more energy-efficient than individual traditional air-cooled air-conditioning systems: using a DCS is thus a means of reducing the energy consumption, and as a consequence the environmental impact, of air conditioning.

#### Resources 
A DCS consists of a set of chillers and an ice storage tank. 

A chiller is a machine that removes heat from a liquid by using a variety of techniques such as vapor-compression. We consider here electric-powered chillers which are used to cool water. These chillers can be classified into two main categories depending on their functionality. Standard chillers (denoted by STDC) only produce cooling power to satisfy the instantaneous demand of the customers. Ice chillers (denoted by ICEC) have two distinct operating modes: they either produce cooling power, but usually with a lower efficiency than the one of an STDC, or they produce ice. This ice can be stored for a few hours in an ice storage tank and be melted afterward to provide cooling power.

Within each category of chillers (STDC or ICEC), there are chillers with different production capacity levels. Each level corresponds to a predefined production range, i.e. to a minimum and maximum cooling power (or ice) it can provide per hour when turned on, and to a performance curve. A performance curve gives, for each chiller, the electric power consumed as a function of the produced cooling power or of the produced ice.

Another key resource in the system is the ice storage tank. This tank is linked to all the ice chillers of the system, can store the produced ice for a few hours, and release it afterward to produce cooling power. It has a maximal storage capacity.

#### Demand
The demand for cooling power to be satisfied by the DCS is highly variable. First, the demand for cooling power varies throughout the day and is usually much higher in the daytime than at night. There are also weekly and yearly variations: the demand pattern of a weekday thus significantly differs from the one observed during the weekend and the total daily demand varies during the year, in particular with the summer and winter seasons.

#### Electricity supply
The chillers are powered by electricity bought from an external utility provider. The electricity price displays daily, but no weekly nor yearly variations. Thus, within a day, three types of periods, termed peak,  at and valley periods can be distinguished. They correspond respectively to the highest, intermediate, or lowest prices. Peak periods are usually at noon and in the evening, the valley periods at night and early in the morning, and the rest of the day corresponds to at periods. These price variations can be exploited to reduce the total energy cost, e.g. by producing ice at night when the demand for cooling power is low and the electricity rather cheap, storing it for a few hours, and releasing ice to produce cooling power in the daytime when the demand is high and the electricity more expensive.

#### Daily scheduling of a DCS
The short-term daily scheduling of a DCS relies on an hourly time discretization: the day is divided into 24 one-hour time periods. Scheduling the DCS consists in determining for each hour of the day the number of chillers that will be turned on, the amount of cooling power produced by each chiller, and the amount of stored and released ice. The objective is to ensure that the demand for cooling power is satisfied at all times while minimizing the total electricity costs. In what follows, we will consider two cases:

1. ***Scheduling for a winter day***

	The first (simple) case will consider a winter day in which the demand for cooling power is low. We will consider a DCS in which there are only standard chillers. The possibility to produce ice with ice chillers and store it in a storage tank will thus not be taken into account.
				
2. ***Scheduling for a summer day***

	The second (more complicated) case will consider a summer day in which the demand for cooling power is much higher. We will consider a DCS in which there are standard chillers but also several ice chillers and one ice storage tank.
	
	
***For more information about the two cases: please feel free to check the attached, "IORCProject", file.***




