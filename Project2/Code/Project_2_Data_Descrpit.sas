************************************************************************
*Class: BIOS 6623-Advanced Data Analysis                               *
*                                                                      *
*Subject: Project 2 - VA and Heart surgery                             *
*                                                                      *
*Dataset: vadat2                                                       *
*                                                                      *
*Purpose: Descriptive statistics & exploratory analysis                *
*                                                                      *
*Contributors: Michael Cuffney                                         *
*                                                                      *
*Date Created: 10/23/2017                                              *
*                                                                      *
*Last Edit: 10/23/2017                                                 *
************************************************************************;
RUN;

LIBNAME vadata "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_2";
LIBNAME varesult "C:\Repositories\bios6623-MCuffney\Project2\Docs";

* Creating data for table one;
PROC SORT DATA = vadata.vafinal;
	BY hospcode;
RUN;
PROC MEANS DATA = vadata.vafinal MEAN STD NMISS NOPRINT;
	BY hospcode;
	VAR BMI albumin;
	OUTPUT OUT = varesult.means;
RUN;

PROC FREQ DATA = vadata.vafinal NOPRINT;
	TABLE hospcode*asa hospcode*proced hospcode*death30;
	OUTPUT OUT = varesult.freq;
RUN;


