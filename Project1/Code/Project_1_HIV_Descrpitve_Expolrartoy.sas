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
*Last Edit: 10/4/2017                                                  *
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
TABLE ADH HASHV HASHF income HBP DIAB LIV34 KID FRP FP DYSLIP CESD SMOKE DKGRP HEROPIATE IDU RACE EDUCBAS hivpos ART everART hard_drugs / MISSPRINT;
RUN; 

*Things to be done in the data set
	1)transform VLOAD and VLOAD_2 to create new VLOAD_DIFF outcome, 
	2)Need to remove out of range values,
	3)Create new categorical variables based on Race, BL Alchol use, BL Smoking status, BL Income, Education, and Art Adherence,
	4) Finalize clean data set;

*Descriptive Statistics for Outcomes [Cleaned dataset];
PROC UNIVARIATE DATA = HIV.Clean1;
VAR AGG_MENT_DIFF AGG_PHYS_DIFF LVLOAD_DIFF LEU3N_DIFF;
HISTOGRAM;
QQPLOT;
RUN;
*LVLOAD looks a lot better in terms of the histogram and Q-Q plot;
*Missing Data: LEU3N_DIFF [228, 31.89%], LVLOAD_DIFF [228, 31.89%], AGG_PHYS_DIFF [216, 30.21%], AGG_MENT_DIFF [216, 30.21%];

*Descriptives for continous independent variables [Cleaned Dataset];
PROC MEANS DATA=HIV.Clean1 MIN MEAN MAX STD NMISS N;
VAR AGG_MENT AGG_MENT_2 AGG_PHYS AGG_PHYS_2 BMI TCHOL TRIG LDL LEU3N LEU3N_2 LVLOAD LVLOAD_2 AGE;
RUN;
*Missing Data: AGG_MENT [2, 0.28%], AGG_MENT_2 [215, 30.07%], AGG_PHYS [2, 0.28%], AGG_PHYS_2 [215, 30.07%], BMI [35, 4.90%], TCHOL [242, 33.86%]
	TRIG [388, 54.27%], LDL [374, 52.31%], LEU3N [24, 3.36%], LEU3N_2 [228, 31.89%], LVLOAD [42, 5.87], LVLOAD_2 [228, 31.89%]

*Descriptives for categorical independent variables [Cleaned Dataset]; 
PROC FREQ DATA=HIV.Clean1 ;
TABLE ADH HASHV HASHF income HBP DIAB LIV34 KID FRP FP DYSLIP CESD SMOKE DKGRP HEROPIATE IDU RACE EDUCBAS hivpos ART everART hard_drugs / MISSPRINT;
RUN;
*Missing DATA: ADH [209, 29.23%], HASHF [49, 6.85%], income [34, 4.76%], HBP [68, 9.51%], DIAB [405, 56.64%], LIV34 [245, 34.27%], KID [508, 71.05%]
	DYSLIP [312, 43.64%], CESD [21, 2.94%], HEROPIATE [38, 5.31%], ART [209, 29.23%], everArt [209, 29.23%];

* TRIG, LDL, KID, DIAB, and DYSLIP are missing too much data to be used;
****** END Descriptive Statistics ******;

****** BEGIN Exploratory Analysis ******;