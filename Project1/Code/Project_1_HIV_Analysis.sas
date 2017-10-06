************************************************************************
*Class: BIOS 6623-Advanced Data Analysis                               *
*                                                                      *
*Subject: Project 1 - HIV                                              *  
*                                                                      *
*Purpose: Model analysis                *
*                                                                      *
*Contributors: Michael Cuffney                                         *
*                                                                      *
*Date Created: 10/5/2017                                               *
*                                                                      *
*Last Edit: 10/5/2017                                                  *
************************************************************************;
LIBNAME HIV "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_1";
LIBNAME Results "C:\Repositories\bios6623-MCuffney\Project1\Docs";

******* BEGIN MODEL CREATION FOR AGG_MENT_DIFF OUTCOME *******;
* Crude models;
PROC GLM DATA = HIV.AGGMENT;
MODEL AGG_MENT_DIFF = AGG_MENT / SOLUTION CLPARM;
QUIT;

PROC GLM DATA = HIV.AGGMENT;
MODEL AGG_MENT_DIFF = BMI / SOLUTION CLPARM;
QUIT;

PROC GLM DATA = HIV.AGGMENT;
MODEL AGG_MENT_DIFF = AGE / SOLUTION CLPARM;
QUIT;

PROC GLM DATA = HIV.AGGMENT;
MODEL AGG_MENT_DIFF = AGE / SOLUTION CLPARM;
QUIT;



