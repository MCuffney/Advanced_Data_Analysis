************************************************************************
*Class: BIOS 6623-Advanced Data Analysis                               *
*                                                                      *
*Subject: Project 3 - Memory & other congitive loss                    *
*                                                                      *
*Dataset: Project3Data.csv                                             *
*                                                                      *
*Purpose: Final Anlaysis                                               *
*                                                                      *
*Contributors: Michael Cuffney                                         *
*                                                                      *
*Date Created: 11/15/2017                                              *
*                                                                      *
*Last Edit: 11/22/2017                                                 *
************************************************************************;
RUN;
LIBNAME memraw "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_3\Raw_Data";
LIBNAME memclean "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_3\Clean_Data";
* Analysis of logmemI outcome;
* Look into the Type option;
PROC MIXED DATA = memclean.animals;
	CLASS id gender;
	MODEL animals = age demind age*demind spline gender SES / SOLUTION CL;
	RANDOM intercept age / subject=ID type=UN g gcorr v vcorr;
	ESTIMATE "Demintia Effect"
				age 1
				age*demind 1 / CL; * Tells how different the change is;
	ESTIMATE "Rate of change at CHGPT"
				age 1
				age*demind 1
				spline 1 / CL; * Tells the actually rate of change after the chgpt;
RUN;
* Question 1: Look at Beta associated with age;
* Question 2: Look at first estimate statememt, secound estimate tells that actual rate of change after the chgpt;
* Question 3: Look at the Beta associated with spline;
