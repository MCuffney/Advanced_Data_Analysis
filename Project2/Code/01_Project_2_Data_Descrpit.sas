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
*Last Edit: 10/24/2017                                                 *
************************************************************************;
RUN;

LIBNAME vadata "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_2";

* Creating data for table one for the most recent sixmonth period;
DATA vadata.sixmonth;
	SET vadata.vafinal;
	IF sixmonth = 39;
RUN;
PROC SORT DATA = vadata.sixmonth;
	BY hospcode;
RUN;
PROC MEANS DATA = vadata.sixmonth NOPRINT  ;
	VAR BMI albumin;
	OUTPUT OUT = vadata.means Q1(BMI) = BMI_Lower_Quartlie MEAN(BMI) = BMI_Average MEDIAN(BMI) = BMI_Median  
							  Q3(BMI) = BMI_Upper_Quartile  STD(BMI) = BMI_STD_Deviation 
							  Q1(albumin) = albumin_Lower_Quartlie MEAN(albumin) = albumin_Average MEDIAN(albumin) = albumin_Median  
							  Q3(albumin) = albumin_Upper_Quartile  STD(albumin) = albumin_STD_Deviation;
RUN;
DATA vadata.meanTable;
	SET vadata.means (DROP = _TYPE_ _FREQ_);
	FORMAT _ALL_ 6.3;
RUN;
DATA vadata.tableMean;
	SET vadata.meanTable;
BMI_Mean_SD = CATX(' ', ROUND(BMI_Average, 0.001), CATX(' ','(',ROUND(BMI_STD_Deviation, 0.001), ')'));
	BMI_25_50_75 = CAT('(', CATX(', ',ROUND(BMI_Lower_Quartlie, 0.001), ROUND(BMI_Median, 0.001), ROUND(BMI_Upper_Quartile, 0.001)), ')');
	albumin_Mean_SD = CATX(' ', ROUND(albumin_Average, 0.001), CATX(' ','(',ROUND(albumin_STD_Deviation, 0.001), ')'));
	albumin_25_50_75 = CAT('(', CATX(', ',ROUND(albumin_Lower_Quartlie, 0.001), ROUND(albumin_Median, 0.001), ROUND(albumin_Upper_Quartile, 0.001)), ')');
	KEEP BMI_Mean_SD BMI_25_50_75 albumin_Mean_SD albumin_25_50_75;
RUN;

PROC PRINT DATA = vadata.tableMean LABEL;
LABEL BMI_Mean_SD = 'BMI: Mean (STD)'
	  BMI_25_50_75 = 'BMI: 25th, 50th, & 75th Percentile'
	  albumin_Mean_SD = 'Albumin: Mean (STD)'
	  albumin_25_50_75 = 'Albumin: 25th, 50th, & 75th Percentile'
	  ;
RUN;


PROC FREQ DATA = vadata.sixmonth;
	TABLE asa proced death30;
RUN;

* Creating the death rate for each hospital in the most recent sixmonth period;
PROC FREQ DATA = vadata.sixmonth;
TABLE hospcode*death30;
RUN;

DATA vadata.patient;
	SET vadata.sixmonth (KEEP = hospcode death30);
	BY hospcode;
	IF	FIRST.hospcode	= 1	THEN DO;
		paticnt	= 0;
		deathcnt = 0;
	END;	
		paticnt + 1;
		deathcnt + death30;
		deathpct = (deathcnt/paticnt)*100;

	IF	LAST.hospcode	= 1;
RUN;
