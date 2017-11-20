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
*Last Edit: 11/15/2017                                                 *
************************************************************************;
RUN;

LIBNAME memraw "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_3\Raw_Data";
LIBNAME memclean "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_3\Clean_Data";

* Reading in raw datafile;
DATA memraw.raw;
INFILE "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_3\Raw_Data\Project3Data.csv" DSD FIRSTOBS = 2;
INPUT  id gender SES age cdr blockR animals logmemI logmemII ageonset demind;
time = age - ageonset;
tao = (age - ageonset + 4);
spline = max(0,(age - ageonset + 4));
RUN;

PROC CONTENTS DATA = memraw.raw varnum;
RUN;
* 11 variables, 3,385 observations;
* Outcomes: 1)logmemI: logical memory I Story A score, 2)logmemII: logical memory II Story A score, 
	3)Animals: The category fluency for animals score, 4)BlockR: The block design test score
* Covariates: 1)Gender [1=Male, 2=Female], 2)SES, 3)Age: Age at visit in years, 4)CDR: Clinical Dementia Rating Scale,
	5)Age at onset, 6)Demind: subject gets a MCI/dementia diagnosis [1 = yes two CDR>=0.5 occur during the study, 0 = no, no consecutive CDR’s >=0.5.];

********** Begin Data Cleaning **********;	
* Checking age ranges match with the study timeline;
PROC MEANS DATA=memraw.raw MIN MAX;
BY id;
VAR age;
RUN;
* Ages mathc with study timeline;

* Checking for issues in the raw data;
PROC MEANS DATA=memraw.raw MIN MEAN MEDIAN MAX STD N NMISS;
VAR SES age blockR animals logmemI logmemII ageonset;
RUN; 
PROC FREQ DATA=memraw.raw;
TABLE gender cdr demind;
RUN; 
* Everything appears to be in order: No out of range values or incorrectly inputted data;
********** End Data Cleaning **********;

********** Begin creating datasets for analysis *********;
* Create baseline dataset: Used for table one statistics;
DATA memclean.Baseline;
	SET memraw.raw;
	BY ID;
	IF FIRST.ID = 1;
RUN;

* Split the raw data into two dataset: Subjects with MCI/Demitia and Subjects without MCI/Demitia;
DATA memclean.MCI memclean.NOMCI;
	SET memraw.raw;
	IF demind = 1 THEN OUTPUT memclean.MCI;
	IF demind = 0 THEN OUTPUT memclean.NOMCI;
RUN;

* Create the four outcome varaible datasets: Will only contain subjects that have at least three measurements on the outcome;
* LogmemI dataset;
DATA memraw.logmemI; * determine the subjects with < 3 measures of the outcome;
	SET memraw.raw;
	BY ID;
	IF FIRST.ID = 1 THEN DO;
		count = 0;
		END;
	IF logmemI ^= . THEN count + 1;
	IF LAST.ID = 1;
	IF count >= 3 THEN DELETE; 
	RUN;
* 23 to be removed. ID with less than 3 measurements: 106, 138, 147, 149, 159, 167, 189, 236, 245, 320, 332, 337, 345, 371 - 389;
DATA memclean.logmemI;
	SET memraw.raw;
	IF ID IN(106, 138, 147, 149, 159, 167, 189, 236, 320, 337) THEN DELETE;
	IF ID >= 371 THEN DELETE;
	RUN;
PROC CONTENTS DATA = memclean.logmemI varnum;
RUN;
* 11 variables, 3,306 observations: 79 observations removed;

* logmemII dataset;
DATA memraw.logmemII; * determine the subjects with < 3 measures of the outcome;
	SET memraw.raw;
	BY ID;
	IF FIRST.ID = 1 THEN DO;
		count = 0;
		END;
	IF logmemII ^= . THEN count + 1;
	IF LAST.ID = 1;
	IF count >= 3 THEN DELETE; 
	RUN;
* 23 subjects to be removed. ID with < 3 measurements: 106, 138, 147, 149, 159, 167, 189, 236, 245, 299, 320, 332, 337, 345, 371, 374, 375, 376
	378, 380, 386, 388, 389;
DATA memclean.logmemII;
	SET memraw.raw;
	IF ID IN(106, 138, 147, 149, 159, 167, 189, 236, 245, 299, 320, 332, 337, 345, 371, 374, 375, 376
	378, 380, 386, 388, 389) THEN DELETE;
RUN;
PROC CONTENTS DATA = memclean.logmemII varnum;
RUN;
* 11 variables, 3,289: 96 observations removed;

* Animal dataset;
DATA memraw.animal; * determine the subjects with < 3 measures of the outcome;
	SET memraw.raw;
	BY ID;
	IF FIRST.ID = 1 THEN DO;
		count = 0;
		END;
	IF animals ^= . THEN count + 1;
	IF LAST.ID = 1;
	IF count >= 3 THEN DELETE; 
	RUN;
* 29 subjects to be remove. ID's with < 3 measurements: 106, 108, 112, 113, 117, 118, 133, 138, 147, 149, 159, 167, 189, 236, 245, 299, 320,
	332, 337, 345, 371, 374, 375, 376, 378, 380, 386, 388, 389;
DATA memclean.animals;
	SET memraw.raw;
	IF ID IN(106, 108, 112, 113, 117, 118, 133, 138, 147, 149, 159, 167, 189, 236, 245, 299, 320,
	332, 337, 345, 371, 374, 375, 376, 378, 380, 386, 388, 389) THEN DELETE;
RUN;
PROC CONTENTS DATA = memclean.animals varnum;
RUN;
* 11 variables, 3,270: 115 observations removed;

* BlockR dataset;
DATA memraw.BlockR; * determine the subjects with < 3 measures of the outcome;
	SET memraw.raw;
	BY ID;
	IF FIRST.ID = 1 THEN DO;
		count = 0;
		END;
	IF animals ^= . THEN count + 1;
	IF LAST.ID = 1;
	IF count >= 3 THEN DELETE;
RUN; 
* 29 subjects to be removed. ID's with < 3 measurements: 106, 108, 112, 113, 117, 118, 133, 138, 147, 149, 159, 167, 189, 236, 245, 299,
	320, 332, 337, 345, 371, 374, 375, 376, 378, 380, 386, 388, 389;
DATA memclean.animals;
	SET memraw.raw;
	IF ID IN(106, 108, 112, 113, 117, 118, 133, 138, 147, 149, 159, 167, 189, 236, 245, 299,
	320, 332, 337, 345, 371, 374, 375, 376, 378, 380, 386, 388, 389) THEN DELETE;
RUN;
PROC CONTENTS DATA = memclean.animals varnum;
RUN;
* 11 variables, 3,270: 115 observations removed;











