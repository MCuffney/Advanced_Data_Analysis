************************************************************************
*Class: BIOS 6623-Advanced Data Analysis                               *
*                                                                      *
*Subject: Project 1 - HIV                                              *  
*                                                                      *
*Purpose: Descriptive statistics & Expolratory analysis                *
*                                                                      *
*Contributors: Michael Cuffney                                         *
*                                                                      *
*Date Created: 10/3/2017                                               *
*                                                                      *
*Last Edit: 10/3/2017                                                  *
************************************************************************;

****** Begin Descriptive Statistics ******;
* Descriptives for Outcomes;
PROC UNIVARIATE DATA = HIV.BLandtwo;
VAR AGG_MENT_DIFF AGG_PHYS_DIFF VLOAD_DIFF LEU3N_DIFF;
HISTOGRAM;
QQPLOT;
RUN;
* AGG_MENT_DIFF, AGG_PHYS_DIFF, and LEU3N_DIFF look find (meet the assumptions) | VLOAD_DIFF needs to be transformed (Q-Q plot and Histgram are off;

* Descriptives for continous independent variables;
PROC MEANS DATA=HIV.BLandTwo MIN MEAN MAX STD NMISS N;
VAR AGG_MENT AGG_MENT_2 AGG_PHYS AGG_PHYS_2 BMI TCHOL TRIG LDL LEU3N LEU3N_2 VLOAD VLOAD_2 AGE;
RUN;
* BMI has out of range value > 70 (Remove this value by setting it to missing), LDL has out of range value > 300 (Remove by setting it to missing);

* Descriptives for categorical independent variables;
PROC FREQ DATA=HIV.BLandTwo ;
TABLE ADH_2 HASHV HASHF income HBP DIAB LIV34 KID FRP FP DYSLIP CESD SMOKE DKGRP HEROPIATE IDU ADH RACE EDUCBAS hivpos ART everART ART_2 everART_2 hard_drugs / MISSPRINT;
RUN; 

*Things to be done in the data set
	1)transform VLOAD and VLOAD_2 to create new VLOAD_DIFF outcome, 
	2)Need to remove out of range values,
	3)Create new categorical variables based on Race, BL Alchol use, BL Smoking status, BL Income, Education, and Art Adherence,
	4) Finalize clean data set;

* Descriptive Statistics for Outcomes [Cleaned dataset];


*Descriptives for continous independent variables [Cleaned Dataset];

*Descriptives for categorical independent variables [Cleaned Dataset]; 
