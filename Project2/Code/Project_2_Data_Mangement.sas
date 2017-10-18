************************************************************************
*Class: BIOS 6623-Advanced Data Analysis                               *
*                                                                      *
*Subject: Project 2 - VA and Heart surgery                             *  
*                                                                      *
*Purpose: Data mangement & Cleaning                                    *
*                                                                      *
*Contributors: Michael Cuffney                                         *
*                                                                      *
*Date Created: 10/11/2017                                              *
*                                                                      *
*Last Edit: 10/11/2017                                                 *
************************************************************************;
RUN;

LIBNAME vadata "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_2";
LIBNAME varesult "C:\Repositories\bios6623-MCuffney\Project2\Docs";

********Begin Data cleaning**********;
PROC MEANS DATA = vadata.vadata2  N NMISS;
RUN; 
PROC MEANS DATA = vadata.vadata2  MIN MEAN MEDIAN MAX;
VAR weight height BMI;
RUN;

* Removing subjects with Procedure code = 2;
DATA vadata.vaclean1;
	SET vadata.vadata2;
	IF proced = 2 THEN delete;
RUN;
PROC MEANS DATA = vadata.vaclean1 MIN MAX N NMISS;
RUN;

* Checking BMI values;
DATA vadata.bmicheck;
	LENGTH bmi chckbmi 8.;
	SET vadata.vaclean1;
	chckbmi = weight / height**2 * 703;
	bmi = bmi, 0.001;
	IF bmi = chckbmi THEN wrong = 0;
		ELSE IF bmi NE chckbmi THEN wrong = 1;
RUN;
PROC SORT DATA=vadata.bmicheck;
BY hospcode;
RUN;
PROC MEANS DATA = vadata.bmicheck MIN MAX N;
BY hospcode;
VAR bmi chckbmi;
RUN;
