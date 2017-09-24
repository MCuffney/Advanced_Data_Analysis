************************************************************************
*Class: BIOS 6623-Advanced Data Analysis                               *
*                                                                      *
*Subject: Project 1 - HIV                                           *
*                                                                      *
*Contributors: Michael Cuffney                                         *
*                                                                      *
*Date Created: 09/19/2017                                              *
*                                                                      *
*Last Edit: 09/24/2017                                                 *
************************************************************************;
RUN;

*Reading in the HIV data;
LIBNAME HIV "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_1";
LIBNAME Results "C:\Repositories\bios6623-MCuffney\Project1\Docs";

*******BEGIN DATA CREATION**********;
PROC IMPORT 
		DATAFILE= "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_1\hiv_6623_final.csv"
		OUT=HIV.Raw
		DBMS= CSV
		REPLACE;
	GETNAMES=YES;
RUN;

*Creates a dataset for the baseline (year 0) values;
DATA HIV.BL;
SET HIV.Raw;
IF Years > 0 THEN DELETE;
RUN;

*Creates a dataset for the varaibles values at two years, keeping only the response variables and renaming them;
*Investigators believe that only variables at two years that is necessary is the repsonse variables;
DATA HIV.year2;
SET HIV.Raw;
IF Years > 2 OR Years <2 THEN DELETE;
AGG_MENT_2 = AGG_MENT;
AGG_PHYS_2 = AGG_PHYS;
VLOAD_2 = VLOAD;
LEU3N_2 = LEU3N;
ART_2 = ART;
everArt_2= everArt;
ADH_2 = ADH;
KEEP newid AGG_MENT_2 AGG_PHYS_2 VLOAD_2 LEU3N_2 ART_2 everArt_2 ADH_2;
RUN;

*Merging the BL and year 2 datasets and creating the primary outcomes of differences between year 2 and baseline response variabels;
DATA HIV.BLandTwo;
MERGE HIV.BL HIV.year2;
BY newid;
AGG_MENT_DIFF = AGG_MENT_2 - AGG_MENT; *Postive values are good;
AGG_PHYS_DIFF = AGG_PHYS_2 - AGG_PHYS; *postive values are good;
VLOAD_DIFF = VLOAD_2 - VLOAD; *Negative values are good;
LEU3N_DIFF = LEU3N_2 - LEU3N; *Postive values are good;
RUN;
*******END DATA Creation***************;

********BEGIN DESCRIPTIVE STATISTICS*********;
PROC SORT DATA=HIV.BLandTWO;
BY hard_drugs;
RUN;
*Genral statitics;
PROC MEANS DATA=HIV.BLandTwo MIN MEAN MAX STD NMISS N;
BY hard_drugs;
VAR AGG_MENT AGG_MENT_2 AGG_MENT_DIFF AGG_PHYS AGG_PHYS_2 AGG_PHYS_DIFF BMI TCHOL TRIG LDL LEU3N LEU3N_2 LEU3N_DIFF VLOAD VLOAD_2 VLOAD_DIFF AGE;
RUN;

PROC FREQ DATA=HIV.BLandTwo ;
TABLE ADH_2 HASHV HASHF income HBP DIAB LIV34 KID FRP FP DYSLIP CESD SMOKE DKGRP HEROPIATE IDU ADH RACE EDUCBAS hivpos ART everART ART_2 everART_2 hard_drugs / MISSPRINT;
RUN;

