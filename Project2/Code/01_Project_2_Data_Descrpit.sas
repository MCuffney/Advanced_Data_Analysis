************************************************************************
*Class: BIOS 6623-Advanced Data Analysis                               *
*                                                                      *
*Subject: Project 2 - VA and Heart surgery                             *
*                                                                      *
*Dataset: vadata2                                                      *
*                                                                      *
*Purpose: Descriptive statistics and exploratory Analysis              *
*                                                                      *
*Contributors: Michael Cuffney                                         *
*                                                                      *
*Date Created: 10/23/2017                                              *
*                                                                      *
*Last Edit: 10/30/2017                                                 *
************************************************************************;
RUN;

LIBNAME varaw "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_2\Datasets\Raw&Unclean";
LIBNAME vaclean "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_2\Datasets\Cleaned";

* Creating data for table one for the most recent sixmonth period;
DATA vaclean.sixmonth;
	SET vaclean.final;
	IF sixmonth = 39;
RUN;

PROC MEANS DATA = vaclean.sixmonth Q1 MEAN MEDIAN Q3 STD  ;
	VAR BMI albumin;
RUN;

PROC FREQ DATA = vaclean.sixmonth;
	TABLE asa proced death30;
RUN;

* Creating the death rate for each hospital in the most recent sixmonth period;
PROC FREQ DATA = vaclean.sixmonth;
TABLE hospcode*death30;
RUN;

PROC SORT DATA = vaclean.sixmonth;
BY hospcode;
RUN;

PROC MEANS DATA = vaclean.sixmonth N MEAN NOPRINT;
BY hospcode;
VAR death30;
OUTPUT OUT = varaw.Obsdeath (DROP = _TYPE_ _FREQ_) N = NumberPatient MEAN = DeathObs;
RUN;


* Missing data exploration;
* Looking at pattern of missing data via time;
PROC SORT DATA = vaclean.final;
BY sixmonth Hospcode;
RUN;

PROC MEANS DATA = vaclean.final N NMISS;
BY sixmonth hospcode;
VAR weight height BMI albumin proced asa;
RUN;

* Looking at pattern of missing data via hospital;
PROC SORT DATA = vaclean.final;
BY hospcode;
RUN;

PROC MEANS DATA = vaclean.final N NMISS;
BY hospcode;
VAR weight height BMI albumin proced asa;
RUN;

* Look at possible associations between death and albumin levels;
PROC SGPLOT DATA = vaclean.final;
	HBOX albumin / CATEGORY = death30;
RUN;

PROC TTEST DATA = vaclean.final;
	CLASS death30;
	VAR albumin;
RUN;
