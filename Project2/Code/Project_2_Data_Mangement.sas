************************************************************************
*Class: BIOS 6623-Advanced Data Analysis                               *
*                                                                      *
*Subject: Project 2 - VA and Heart surgery                             *  
*                                                                      *
*Purpose: Data mangement & Cleaning                                    *
*                                                                      *
*Contributors: Michael Cuffney                                         *
*                                                                      *
*Date Created: 10/11/2017                                              *
*                                                                      *
*Last Edit: 10/11/2017                                                 *
************************************************************************;
RUN;

LIBNAME vadata "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_2";
LIBNAME varesults "C:\Repositories\bios6623-MCuffney\Project2\Docs";

********Begin Data cleaning**********;
PROC MEANS DATA = vadata.vadata2 MIN MEAN MEDIAN MAX N NMISS;
RUN; 
