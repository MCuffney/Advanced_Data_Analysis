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
*Last Edit: 11/20/2017                                                 *
************************************************************************;
RUN;
LIBNAME memraw "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_3\Raw_Data";
LIBNAME memclean "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_3\Clean_Data";

********** Begin Descriptive Statistics **********;
* Generate Table one descriptive statistics for the Baseline animals data [total];
PROC MEANS DATA = memclean.Baseline N MIN MEAN MAX STD NMISS;
	VAR SES age blockR animals logmemI logmemII ageonset;
RUN;
PROC FREQ DATA = memclean.Baseline;
	TABLE gender demind;
RUN;

* Generate Table one descriptive statistics for the Baseline animals data [by MCI/NOMCI];
PROC SORT DATA=memclean.Baseline;
	BY demind;
RUN;
PROC MEANS DATA = memclean.Baseline N MIN MEAN MAX STD NMISS;
	BY demind;
	VAR SES age animals;
RUN;
PROC FREQ DATA = memclean.Baseline;
	BY demind;
	TABLE gender;
RUN;

* Spagetti graph of subjects for each outcome [Subjects with MCI/Demintia vs. Subject w/o MCI/Demintia];
*Use SGPANEL to put multiple graphs in one plot;
/*PROC SGPANEL DATA = memclean.animals;
	PANELBY demind;
	SERIES x=age y=logmemI / group=id;
RUN;
PROC SGPANEL DATA = memclean.animals;
	PANELBY demind;
	SERIES x=age y=logmemII / group=id;
RUN;*/
PROC SGPANEL DATA = memclean.animals;
	PANELBY demind;
	SERIES x=age y=Animals / group=id;
RUN;
/*PROC SGPANEL DATA = memraw.raw;
	PANELBY demind;
	SERIES x=age y=BlockR / group=id;
RUN;*/

* grpahs looking at slopes between start of study and onset of MCI; 
/*PROC SGPLOT DATA= memclean.MCI;
	SERIES x=time y=logmemI /group=id;
	LINEPARM x=-4 Y=0 SLOPE=.; *vertical line indicates four years prior to onset;
	XAXIS MIN=-16 MAX=0;
RUN;

PROC SGPLOT DATA= memclean.MCI;
	SERIES x=time y=logmemII /group=id;
	LINEPARM x=-4 Y=0 SLOPE=.;
	XAXIS MIN=-16 MAX=0;
RUN;*/
PROC SGPLOT DATA= memclean.animals;
	SERIES x=time y=Animals /group=id;
	LINEPARM x=-4 Y=0 SLOPE=.; *vertical line indicates four years prior to onset;
	XAXIS MIN=-13 MAX=0; 
RUN;
/*PROC SGPLOT DATA= memclean.MCI;
	SERIES x=time y=BlockR /group=id;
	LINEPARM x=-4 Y=0 SLOPE=.;
	XAXIS MIN=-16 MAX=0;
RUN;*/
********** END DESCRIPTIVE STATISTICS **********;

********* BEGIN EXPOLARTORY ANALYSIS ***********;
PROC UNIVARIATE DATA = memclean.animals PLOT;
VAR age ses animals spline time ageonset;
RUN;
* Outcome meets model assumptions for normality;

* Box plots looking at categorical variables spread of animals;
PROC SGPANEL DATA=memclean.animals;
	PANELBY demind;
	VBOX animals;
RUN;
PROC SGPANEL DATA=memclean.animals;
	PANELBY gender;
	VBOX animals;
RUN;

* explore correlation between the contious variable;
PROC CORR DATA=memclean.animals;
	VAR animals ses age spline time ageonset;
RUN;
