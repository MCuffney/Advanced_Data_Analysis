************************************************************************
*Class: BIOS 6623-Advanced Data Analysis                               *
*                                                                      *
*Subject: Project 0 - Dental                                                    *
*                                                                      *
*Contributors: Michael Cuffney                                         *
*                                                                      *
*Date Created: 09/02/2017                                              *
*                                                                      *
*Last Edit: 09/02/2017                                                 *
************************************************************************;
RUN;

/* Variabel Coding;
	Trtgroup: 1 = Placebo gel, 2 = Control (no treatment/gel), 3 = Low Concentration, 4 = Medium Concentration, 5 = High Concentration
	Sex: 1 = Male, 2 = Female
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

*Looking at distribution of the various categorical variables;
*Check the balance of the data among the categorical variables;
PROC FREQ DATA=Dental.Get;
	TABLE trtgroup sex race smoker sites;
RUN;

PROC FREQ DATA=Dental.Get;
	TABLE trtgroup*sex trtgroup*race trtgroup*smoker; /*Crosstabulations to see the distributions of race, sex and smoking status amoung treatment groups*/
RUN;


