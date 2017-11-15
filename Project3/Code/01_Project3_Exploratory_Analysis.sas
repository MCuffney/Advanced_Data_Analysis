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
*Last Edit: 11/12/2017                                                 *
************************************************************************;
RUN;

* Spagetti graph of subjects for each outcome [all data combined];
PROC SGPLOT DATA=memraw.raw;
	SERIES x=age y=logmemI / group=id;
RUN;
PROC SGPLOT DATA=memraw.raw;
	SERIES x=age y=logmemII / group=id;
RUN;
PROC SGPLOT DATA=memraw.raw;
	SERIES x=age y=Animals / group=id;
RUN;
PROC SGPLOT DATA=memraw.raw;
	SERIES x=age y=BlockR / group=id;
RUN;
