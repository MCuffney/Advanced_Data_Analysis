************************************************************************
*Class: BIOS 6623-Advanced Data Analysis                               *
*                                                                      *
*Subject: Project 2 - VA and Heart surgery                             *
*                                                                      *
*Dataset: vadat2                                                       *
*                                                                      *
*Purpose: Data mangement & Cleaning                                    *
*                                                                      *
*Contributors: Michael Cuffney                                         *
*                                                                      *
*Date Created: 10/11/2017                                              *
*                                                                      *
*Last Edit: 10/23/2017                                                 *
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
DATA vadata.vabmi;
	SET vadata.vaclean1 (RENAME = (bmi = orgibmi));
	bmi = weight /height**2 * 703; 
RUN;

PROC SORT DATA = vadata.vabmi;
	BY sixmonth hospcode;
RUN;

PROC MEANS DATA = vadata.vabmi MIN MEAN MEDIAN MAX;
	BY sixmonth hospcode;
	VAR weight orgibmi bmi;
RUN;
* Hospital 30 is missing all weight and bmi measures for the most recent six mounth interval (39);
* Hospital 20 had miss calucated bmi measures for the most recent six mounth interval (39;
* Hospital 1 - 16 had weight inputed in kg not lbs for the most recent six month interval;

DATA vadata.vaclean2;
	SET vadata.vaclean1 (RENAME = (bmi = orgibmi));
	IF hospcode < 17 AND sixmonth = 39 THEN weight = weight * 2.2;
	bmi = weight / height**2 * 703; 
RUN;

PROC SORT DATA = vadata.vaclean2;
	BY sixmonth hospcode;
RUN;

PROC MEANS DATA = vadata.vaclean2 MIN MEAN MEDIAN MAX;
	BY sixmonth hospcode;
	VAR weight orgibmi bmi;
RUN;
* BMI issue for Hospital 20 [39th sixmonth] fixed by recalcuting bmi variable using formula provided;
* converted the weights for Hospitals 1 to 16 from kg to lbs in the most recent sixmonth period [39];

* Final data cleaning check and creation of final dataset for analysis;
PROC SORT DATA = vadata.vaclean2;
	BY sixmonth hospcode;
RUN;

PROC MEANS DATA = vadata.vaclean2 MIN MEAN MEDIAN MAX;
	BY sixmonth hospcode;
	VAR height weight bmi albumin;
RUN;

PROC FREQ DATA = vadata.vaclean2;
	TABLE death30 proced asa;
RUN;

DATA vadata.vafinal;
	SET vadata.vaclean2;
	DROP orgibmi;
RUN;
