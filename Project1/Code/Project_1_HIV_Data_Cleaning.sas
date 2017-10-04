************************************************************************
*Class: BIOS 6623-Advanced Data Analysis                               *
*                                                                      *
*Subject: Project 1 - HIV                                              *  
*                                                                      *
*Purpose: Data mangement & Cleaning                                                                      *
*                                                                      *
*Contributors: Michael Cuffney                                         *
*                                                                      *
*Date Created: 09/19/2017                                              *
*                                                                      *
*Last Edit: 10/3/2017                                                  *
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

* Standerdize missing values ((.) for numeric and ( ) for character;
DATA HIV.Raw2;
	SET HIV.Raw;
	IF BMI = 999 THEN BMI = .;
	IF Income = 9 THEN Income = .;
	IF CESD = -1 THEN CESD = .;
RUN;

*Creates a dataset for the baseline (year 0) values;
DATA HIV.BL;
SET HIV.Raw2;
IF Years > 0 THEN DELETE;
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


