************************************************************************
*Class: BIOS 6623-Advanced Data Analysis                               *
*                                                                      *
*Subject: Project 2 - VA and Heart surgery                             *
*                                                                      *
*Dataset: vadata2                                                       *
*                                                                      *
*Purpose: Data mangement & Cleaning                                    *
*                                                                      *
*Contributors: Michael Cuffney                                         *
*                                                                      *
*Date Created: 10/11/2017                                              *
*                                                                      *
*Last Edit: 10/30/2017                                                 *
************************************************************************;
RUN;

LIBNAME varaw "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_2\Datasets\Raw&Unclean";
LIBNAME vaclean "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_2\Datasets\Cleaned";

********Begin Data cleaning**********;
PROC MEANS DATA = varaw.vadata2  N NMISS;
RUN; 
PROC MEANS DATA = varaw.vadata2  MIN MEAN MEDIAN MAX;
VAR weight height BMI;
RUN;

* Removing subjects with Procedure code = 2;
DATA varaw.vaclean1;
	SET varaw.vadata2;
	IF proced = 2 THEN delete;
RUN;
PROC MEANS DATA = varaw.vaclean1 MIN MAX N NMISS;
RUN;

* Checking BMI values;
DATA varaw.vabmi;
	SET varaw.vaclean1 (RENAME = (bmi = orgibmi));
	bmi = weight /height**2 * 703; 
RUN;

PROC SORT DATA = varaw.vabmi;
	BY sixmonth hospcode;
RUN;

PROC MEANS DATA = varaw.vabmi MIN MEAN MEDIAN MAX;
	BY sixmonth hospcode;
	VAR weight orgibmi bmi;
RUN;
* Hospital 30 is missing all weight and bmi measures for the most recent six mounth interval (39);
* Hospital 20 had miss calucated bmi measures for the most recent six mounth interval (39);
* Hospital 1 - 16 had weight inputed in kg not lbs for the most recent six month interval;

DATA varaw.vaclean2;
	SET varaw.vaclean1 (RENAME = (bmi = orgibmi));
	IF hospcode < 17 AND sixmonth = 39 THEN weight = weight * 2.2;
	bmi = weight / height**2 * 703; 
RUN;

PROC SORT DATA = varaw.vaclean2;
	BY sixmonth hospcode;
RUN;

PROC MEANS DATA = varaw.vaclean2 MIN MEAN MEDIAN MAX;
	BY sixmonth hospcode;
	VAR weight orgibmi bmi;
RUN;
* BMI issue for Hospital 20 [39th sixmonth] fixed by recalcuting bmi variable using formula provided;
* converted the weights for Hospitals 1 to 16 from kg to lbs in the most recent sixmonth period [39];

* Final data cleaning check and creation of final dataset for analysis;
PROC SORT DATA = varaw.vaclean2;
	BY sixmonth hospcode;
RUN;

PROC MEANS DATA = varaw.vaclean2 MIN MEAN MEDIAN MAX;
	BY sixmonth hospcode;
	VAR height weight bmi albumin;
RUN;

PROC FREQ DATA = varaw.vaclean2;
	TABLE death30 proced asa*hospcode;
RUN;
* Not all hospitals have all values of asa;
* Dichotomize ASA: 0: <= 3, 1 = 4/5;
DATA varaw.vaasa;
	SET varaw.vaclean2;
	IF asa = . THEN asa_cat = .;
	ELSE IF asa <= 3 THEN asa_cat = 0;
	ELSE asa_cat = 1;
	DROP orgibmi;
RUN;
PROC SORT DATA = varaw.vaasa;
BY asa;
RUN;
PROC PRINT DATA=varaw.vaasa;
VAR asa asa_cat;
RUN;

* Create finalized dataset for analysis;
DATA vaclean.final;
	SET varaw.vaasa;
RUN;
