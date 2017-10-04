************************************************************************
*Class: BIOS 6623-Advanced Data Analysis                               *
*                                                                      *
*Subject: Project 1 - HIV                                              *  
*                                                                      *
*Purpose: Data mangement & Cleaning                                    *
*                                                                      *
*Contributors: Michael Cuffney                                         *
*                                                                      *
*Date Created: 09/19/2017                                              *
*                                                                      *
*Last Edit: 10/4/2017                                                  *
************************************************************************;
RUN;

****** Begin Prelimary Data cleaning ******;
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

* Standerdize missing values ((.) for numeric and ( ) for character;
DATA HIV.Raw2;
	SET HIV.Raw;
	IF BMI = 999 THEN BMI = .;
	IF Income = 9 THEN Income = .;
	IF CESD = -1 THEN CESD = .;
	IF HBP = 9 THEN HBP = .;
	IF DIAB = 9 THEN DIAB = .;
	IF LIV34 = 9 THEN LIV34 = .;
	IF KID = 9 THEN KID = .;
	IF FRP = 9 THEN KID = .;
	IF DYSLIP = 9 THEN DYSLIP = .;
	IF HEROPIATE = -9 THEN HEROPIATE = .;
RUN;

*Creates a dataset for the baseline (year 0) values;
DATA HIV.BL;
SET HIV.Raw2;
IF Years > 0 THEN DELETE;
DROP ADH ART EVERART;
RUN;

*Creates a dataset for the varaibles values at two years, keeping only the response variables and renaming them;
*Investigators believe that only variables at two years that is necessary is the repsonse variables;
DATA HIV.year2;
SET HIV.Raw2;
IF Years > 2 OR Years <2 THEN DELETE;
AGG_MENT_2 = AGG_MENT;
AGG_PHYS_2 = AGG_PHYS;
VLOAD_2 = VLOAD;
LEU3N_2 = LEU3N;
KEEP newid AGG_MENT_2 AGG_PHYS_2 VLOAD_2 LEU3N_2 ART everArt ADH;
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
*******END Prelimnary DATA Cleaning *************;

****** Begin Secoundary DATA Cleaning ******;
DATA HIV.Clean1;
	SET HIV.Blandtwo;
	LVLOAD = log10(VLOAD);
	LVLOAD_2 = log10(VLOAD_2);
	LVLOAD_DIFF = LVLOAD_2-LVLOAD;
	DROP VLOAD VLOAD_2 VLOAD_DIFF;
	IF BMI > 70.1 THEN BMI = .;
	IF RACE = 1 THEN RACECD = 1; * NHW: RACECD = 1, OTHER: RACECD = 0;
	ELSE RACECD = 0;
	IF DKGRP = 3 THEN Alchol = 1; * >13 Drinks: Alchol = 1, <= 13 Drinks: Alchol = 0;
	IF DKGRP < 3 THEN Alchol = 0;
	IF SMOKE = 3 THEN CURSmoke = 1; * Current smoker: CURSmoke = 1, Former/Never smoke: CURSmoke = 0;
	ELSE CURSmoke = 0;
	IF income = . THEN incomelev = .; * <$10,000: incomelev = 1, $10,000-$40,000: incomelev = 2, >$40,000: incomelev = 3;
	IF income = 1 THEN incomelev = 1;
	IF income in (2, 3, 4) THEN incomelev = 2;
	IF income > 4 THEN incomelev = 3; 
	IF EDUCBAS <= 3 THEN edulev = 0; * <= HS: edulev = 0, >HS: edulev = 1;
	IF EDUCBAS > 3 THEN edulev = 0;
	IF ADH = . THEN artadh = .; * ADH >95%: artadh = 1, ADH <=95%: artadh = 0;
	IF ADH in (1,2) THEN artadh = 1; 
	IF ADH in (3,4) THEN artadh = 0;
RUN;

* Create Seprate datasets for each outcome, removing observations missing data for outcome or independent variables;