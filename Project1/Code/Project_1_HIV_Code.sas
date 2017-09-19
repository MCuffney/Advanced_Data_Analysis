************************************************************************
*Class: BIOS 6623-Advanced Data Analysis                               *
*                                                                      *
*Subject: Project 1 - HIV                                           *
*                                                                      *
*Contributors: Michael Cuffney                                         *
*                                                                      *
*Date Created: 09/19/2017                                              *
*                                                                      *
*Last Edit: 09/19/2017                                                 *
************************************************************************;
RUN;

*Reading in the HIV data;
LIBNAME HIV "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_1";
LIBNAME Results "C:\Repositories\bios6623-MCuffney\Project1\Docs";

PROC IMPORT 
		DATAFILE= "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_1\hiv_6623_final.csv"
		OUT=HIV.Raw
		DBMS= CSV
		REPLACE;
	GETNAMES=YES;
RUN;
