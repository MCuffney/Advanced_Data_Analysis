************************************************************************
*Class: BIOS 6623-Advanced Data Analysis                               *
*                                                                      *
*Subject: Project 3 - Memory & other congitive loss                    *
*                                                                      *
*Dataset: Project3Data.csv                                             *
*                                                                      *
*Purpose: Final Anlaysis                                               *
*                                                                      *
*Contributors: Michael Cuffney                                         *
*                                                                      *
*Date Created: 11/15/2017                                              *
*                                                                      *
*Last Edit: 11/15/2017                                                 *
************************************************************************;
RUN;

* Analysis of logmemI outcome;
* Look into the Type option;
PROC MIXED DATA = memclean.logmemI;
	CLASS id gender;
	MODEL logmemI = age gender SES demind / SOLUTION;
	RANDOM intercept age / subject=ID type= g gcorr v vcorr;
RUN;
