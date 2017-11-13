************************************************************************
*Class: BIOS 6623-Advanced Data Analysis                               *
*                                                                      *
*Subject: Project 3 - Memory & other congitive loss                    *
*                                                                      *
*Dataset: Project3Data.csv                                             *
*                                                                      *
*Purpose: Data mangement & Cleaning                                    *
*                                                                      *
*Contributors: Michael Cuffney                                         *
*                                                                      *
*Date Created: 11/06/2017                                              *
*                                                                      *
*Last Edit: 11/12/2017                                                 *
************************************************************************;
RUN;

LIBNAME memraw "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_3\Raw_Data";
LIBNAME memclean "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_3\Clean_Data";

* Reading in raw datafile;
DATA memraw.raw;
INFILE "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_3\Raw_Data\Project3Data.csv" DSD FIRSTOBS = 2;
INPUT  id gender SES age cdr blockR animals logmemI logmemII ageonset demind;
RUN;
* Outcomes: 1)logmemI: logical memory I Story A score, 2)logmemII: logical memory II Story A score, 
	3)Animals: The category fluency for animals score, 4)BlockR: The block design test score
* Covariates: 1)Gender [1=Male, 2=Female], 2)SES, 3)Age: Age at visit in years, 4)CDR: Clinical Dementia Rating Scale,
	5)Age at onset, 6)Demind: subject gets a MCI/dementia diagnosis [1 = yes two CDR>=0.5 occur during the study, 0 = no, no consecutive CDR’s >=0.5.];
	
* Checking age ranges match with the study timeline;
PROC MEANS DATA=memraw.raw MIN MAX;
BY id;
VAR age;
RUN;
* Ages mathc with study timeline;

* Summary Statistics: Table One;
PROC MEANS DATA=memraw.raw MIN MEAN MEDIAN MAX STD N NMISS;
VAR SES age blockR animals logmemI logmemII ageonset;
RUN; 
PROC FREQ DATA=memraw.raw;
TABLE gender cdr demind;
RUN; 













