************************************************************************
*Class: BIOS 6623-Advanced Data Analysis                               *
*                                                                      *
*Subject: Project 0 - Dental                                           *
*                                                                      *
*Contributors: Michael Cuffney                                         *
*                                                                      *
*Date Created: 09/02/2017                                              *
*                                                                      *
*Last Edit: 09/13/2017                                                 *
************************************************************************;
RUN;

/* Variabel Coding;
	Trtgroup: 1 = Placebo gel, 2 = Control (no treatment/gel), 3 = Low Concentration, 4 = Medium Concentration, 5 = High Concentration
	Sex: 0 = Male, 1 = Female
	Race: 1 = Native American, 2 = African American, 4 = Asian, 5 = White
	Smoker: 1 = Yes, 0 = No */ 

*Creating a LIBNAME for were data and output will go;
LIBNAME Dental "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_0";
LIBNAME Results "C:\Repositories\bios6623-MCuffney\Project0\Docs";

*Reading in Project 0 data;
PROC IMPORT 
		DATAFILE= "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_0\Project0.csv"
		OUT=Dental.get
		DBMS= CSV
		REPLACE;
	GETNAMES=YES;
RUN;

*Create new varaibles for difference between base and 1 year outcomes;
DATA Dental.Change;
	SET Dental.get;
	attachdiff = attach1year - attachbase;
	pddiff = pd1year - pdbase;
	sex = sex - 1;
RUN;

*Check that the above data step worked;
PROC PRINT DATA=Dental.Change;
RUN;

*Checking the contents of the dataset;
PROC CONTENTS DATA=Dental.Change;
RUN;

*Looking at distribution of the various categorical variables;
*Check the balance of the data among the categorical variables;
PROC FREQ DATA=Dental.Change;
	TABLE trtgroup sex race smoker sites;
RUN;

PROC FREQ DATA=Dental.Change;
	TABLE trtgroup*sex trtgroup*race trtgroup*smoker; /*Crosstabulations to see the distributions of race, sex and smoking status amoung treatment groups*/
RUN;

*Descriptive statistics for contiuos variables;
PROC MEANS DATA=Dental.Change MIN MAX MEAN STD NMISS;
VAR age attachbase attach1year attachdiff pdbase pd1year pddiff;
RUN;

*Descriptive statistics for contiunos variables, by trtgroup;
PROC SORT DATA=Dental.Change;
BY trtgroup;
RUN;

ODS HTML FILE='C:\Repositories\bios6623-MCuffney\Project0\Docs\Descript.xls';
PROC MEANS DATA=Dental.Change MIN MAX MEAN STD;
VAR age attachbase attach1year attachdiff pdbase pd1year pddiff;
BY trtgroup;
RUN;
ODS HTML CLOSE;
ODS HTML;

PROC UNIVARIATE DATA=Dental.Change PLOTS;
RUN;
*Graphs of Contiuos variables;
PROC SGPLOT DATA=Dental.Change;
	SCATTER X=attachbase Y=attach1year / GROUP=trtgroup;
RUN;
PROC SGPLOT DATA=Dental.Change;
	SCATTER X=pdbase Y=pd1year / GROUP=trtgroup;
RUN;

PROC BOXPLOT DATA=Dental.Change;
	PLOT attachdiff*trtgroup;
	PLOT pddiff*trtgroup;
RUN;

*Start of regression section;
*Checking correlation to help in choosing covariates to include in model;
/*PROC CORR DATA=Dental.Change PLOTS=matrix(histogram);
RUN; */ *Used incorrectly, not relevant to the final analysis;

*Crude models using Attachdiff as outcome;
PROC REG DATA=Dental.Change;
MODEL attachdiff = sex;
RUN;
PROC REG DATA=Dental.Change;
MODEL attachdiff = age;
RUN;
PROC REG DATA=Dental.Change;
MODEL attachdiff = smoker;
RUN;
PROC REG DATA=Dental.Change;
MODEL attachdiff = attachbase;
RUN;

*Crude models using pddiff as outcome;
PROC REG DATA=Dental.Change;
MODEL pddiff = sex;
RUN;
PROC REG DATA=Dental.Change;
MODEL pddiff = age;
RUN;
PROC REG DATA=Dental.Change;
MODEL pddiff = smoker;
RUN;
PROC REG DATA=Dental.Change;
MODEL pddiff = pdbase;
RUN;


*Model 1: Outcome = Attachdiff;
PROC GLM DATA=Dental.Change;
CLASS trtgroup;
MODEL attachdiff = trtgroup attachbase / NOINT SOLUTION;
CONTRAST 'Trtgroup 1 vs. Trtgroup 2' trtgroup  1 -1  0  0  0;
CONTRAST 'Trtgroup 1 vs. trtgroup 3' trtgroup  1  0 -1  0  0;
CONTRAST 'Trtgroup 1 vs. Trtgroup 4' trtgroup  1  0  0 -1  0;
CONTRAST 'Trtgroup 1 vs. Trtgroup 5' trtgroup  1  0  0  0 -1;
CONTRAST 'Trtgroup 2 vs. Trtgroup 3' trtgroup  0  1 -1  0  0;
CONTRAST 'Trtgroup 2 vs. Trtgroup 4' trtgroup  0  1  0 -1  0;
CONTRAST 'Trtgroup 2 vs. Trtgroup 5' trtgroup  0  1  0  0 -1;
CONTRAST 'Trtgroup 3 vs. Trtgroup 4' trtgroup  0  0  1 -1  0;
CONTRAST 'Trtgroup 3 vs. Trtgroup 5' trtgroup  0  1  1  0 -1;
CONTRAST 'Trtgroup 4 vs. Trtgroup 5' trtgroup  0  0  0  1 -1;
RUN;

*Model 2: Outcome = Pddiff;
PROC GLM DATA=Dental.Change;
CLASS trtgroup;
MODEL pddiff = trtgroup pdbase /*sex*/ / NOINT SOLUTION;
CONTRAST 'Trtgroup 1 vs. Trtgroup 2' trtgroup  1 -1  0  0  0;
CONTRAST 'Trtgroup 1 vs. trtgroup 3' trtgroup  1  0 -1  0  0;
CONTRAST 'Trtgroup 1 vs. Trtgroup 4' trtgroup  1  0  0 -1  0;
CONTRAST 'Trtgroup 1 vs. Trtgroup 5' trtgroup  1  0  0  0 -1;
CONTRAST 'Trtgroup 2 vs. Trtgroup 3' trtgroup  0  1 -1  0  0;
CONTRAST 'Trtgroup 2 vs. Trtgroup 4' trtgroup  0  1  0 -1  0;
CONTRAST 'Trtgroup 2 vs. Trtgroup 5' trtgroup  0  1  0  0 -1;
CONTRAST 'Trtgroup 3 vs. Trtgroup 4' trtgroup  0  0  1 -1  0;
CONTRAST 'Trtgroup 3 vs. Trtgroup 5' trtgroup  0  1  1  0 -1;
CONTRAST 'Trtgroup 4 vs. Trtgroup 5' trtgroup  0  0  0  1 -1;
RUN;
