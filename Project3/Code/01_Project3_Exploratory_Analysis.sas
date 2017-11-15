************************************************************************
*Class: BIOS 6623-Advanced Data Analysis                               *
*                                                                      *
*Subject: Project 3 - Memory & other congitive loss                    *
*                                                                      *
*Dataset: Project3Data.csv                                             *
*                                                                      *
*Purpose: Exploratory analysis                                         *
*                                                                      *
*Contributors: Michael Cuffney                                         *
*                                                                      *
*Date Created: 11/12/2017                                              *
*                                                                      *
*Last Edit: 11/15/2017                                                 *
************************************************************************;
RUN;
LIBNAME memraw "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_3\Raw_Data";
LIBNAME memclean "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_3\Clean_Data";

* Generate Table one descriptive statistics for the Baseline data;
PROC MEANS DATA = memclean.Baseline N MIN MEAN MAX STD NMISS;
VAR SES age blockR animals logmemI logmemII ageonset;
RUN;
PROC FREQ DATA = memclean.Baseline;
TABLE gender demind;
RUN;

* Generate Descriptive statistics for baseline per group;
PROC SORT DATA = memclean.Baseline;
By demind;
RUN;
PROC MEANS DATA = memclean.Baseline N MIN MEAN MAX STD NMISS;
BY demind;
VAR SES age blockR animals logmemI logmemII ageonset;
RUN;
PROC FREQ DATA = memclean.Baseline;
TABLE demind*gender;
RUN;

* Spagetti graph of subjects for each outcome [Subjects with MCI/Demintia];
PROC SGPLOT DATA=memclean.MCI;
	SERIES x=age y=logmemI / group=id;
RUN;
PROC SGPLOT DATA=memclean.MCI;
	SERIES x=age y=logmemII / group=id;
RUN;
PROC SGPLOT DATA=memclean.MCI;
	SERIES x=age y=Animals / group=id;
RUN;
PROC SGPLOT DATA=memclean.MCI;
	SERIES x=age y=BlockR / group=id;
RUN;

* Spagetti graph of subjects for each outcome [Subjects without MCI/Demintia];
PROC SGPLOT DATA=memclean.NOMCI;
	SERIES x=age y=logmemI / group=id;
RUN;
PROC SGPLOT DATA=memclean.NOMCI;
	SERIES x=age y=logmemII / group=id;
RUN;
PROC SGPLOT DATA=memclean.NOMCI;
	SERIES x=age y=Animals / group=id;
RUN;
PROC SGPLOT DATA=memclean.NOMCI;
	SERIES x=age y=BlockR / group=id;
RUN;

