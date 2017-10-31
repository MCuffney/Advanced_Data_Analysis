************************************************************************
*Class: BIOS 6623-Advanced Data Analysis                               *
*                                                                      *
*Subject: Project 2 - VA and Heart surgery                             *
*                                                                      *
*Dataset: vadata2                                                      *
*                                                                      *
*Purpose: Logistic                                                     *
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

* Logistic regression: used to produce adjusted expected death rate for each hospital;
PROC LOGISTIC DATA = vaclean.final;
CLASS asa_cat proced;
MODEL death30 (event = LAST) = bmi asa_cat proced;
OUTPUT OUT = varaw.expdeath P=death;
RUN;

PROC SORT DATA = varaw.expdeath;
BY hospcode;
RUN; 

PROC MEANS DATA = varaw.expdeath NOPRINT;
BY hospcode;
WHERE sixmonth = 39;
VAR death;
OUTPUT OUT = varaw.deathexp (DROP= _TYPE_ _FREQ_) MEAN = expdeath ;
RUN;

DATA vaclean.deathtable;
	MERGE varaw.Obsdeath varaw.deathexp;
	BY hospcode;
	Ratio = deathObs / expdeath;
RUN;


