************************************************************************
*Class: BIOS 6623-Advanced Data Analysis                               *
*                                                                      *
*Subject: Project 1 - HIV                                              *  
*                                                                      *
*Purpose: Model analysis                                               *
*                                                                      *
*Contributors: Michael Cuffney                                         *
*                                                                      *
*Date Created: 10/5/2017                                               *
*                                                                      *
*Last Edit: 10/6/2017                                                  *
************************************************************************;
LIBNAME HIV "C:\Users\micha\Desktop\BIOS_6623-Advanced_Data_Analysis\Project_1";
LIBNAME Results "C:\Repositories\bios6623-MCuffney\Project1\Docs";

******* BEGIN MODEL CREATION FOR AGG_MENT_DIFF OUTCOME *******;
* Crude models;
PROC GLM DATA = HIV.AGGMENT;
	MODEL AGG_MENT_DIFF = AGG_MENT / SOLUTION CLPARM;
QUIT; * AGG_MENT is associated with AGG_MENT_DIFF;

PROC GLM DATA = HIV.AGGMENT;
	MODEL AGG_MENT_DIFF = BMI / SOLUTION CLPARM;
QUIT; * BMI not associated with AGG_MENT_DIFF;

PROC GLM DATA = HIV.AGGMENT;
	MODEL AGG_MENT_DIFF = AGE / SOLUTION CLPARM;
QUIT; * AGE not associated with AGG_MENT_DIFF;

PROC GLM DATA = HIV.AGGMENT;
	CLASS RaceCd;
	MODEL AGG_MENT_DIFF = RaceCd / SOLUTION CLPARM;
QUIT; * RaceCd is assoicated with AGG_MENT_DIFF;

PROC GLM DATA = HIV.AGGMENT;
	CLASS HASHV;
	MODEL AGG_MENT_DIFF = HASHV / SOLUTION CLPARM;
QUIT; * HASHV not assoicated with AGG_MENT_DIFF;

PROC GLM DATA = HIV.AGGMENT;
	CLASS Alchol;
	MODEL AGG_MENT_DIFF = Alchol / SOLUTION CLPARM;
QUIT; * Alchol not assoicated with AGG_MENT_DIFF;

PROC GLM DATA = HIV.AGGMENT;
	CLASS CURSmoke;
	MODEL AGG_MENT_DIFF = CURSmoke / SOLUTION CLPARM;
QUIT; * CURSmoke not assoicated with AGG_MENT_DIFF;

PROC GLM DATA = HIV.AGGMENT;
	CLASS incomelev;
	MODEL AGG_MENT_DIFF = incomelev / SOLUTION CLPARM;
QUIT; * incomelev not assoicated with AGG_MENT_DIFF;

PROC GLM DATA = HIV.AGGMENT;
	CLASS edulev;
	MODEL AGG_MENT_DIFF = edulev / SOLUTION CLPARM;
QUIT; * edulev not assoicated with AGG_MENT_DIFF;

PROC GLM DATA = HIV.AGGMENT;
	CLASS artadh;
	MODEL AGG_MENT_DIFF = artadh / SOLUTION CLPARM;
QUIT; * artadh not assoicated with AGG_MENT_DIFF;

PROC SORT DATA = HIV.AGGMENT;
	BY DESCENDING hard_drugs;
RUN;
PROC GLM DATA = HIV.AGGMENT ORDER=DATA;
	CLASS hard_drugs;
	MODEL AGG_MENT_DIFF = hard_drugs / SOLUTION CLPARM;
QUIT; * hard_drugs not associated with AGG_MENT_DIFF;

* FULL MODEL;
PROC GLM DATA = HIV.AGGMENT;
	CLASS  hard_drugs CURSmoke incomelev edulev;
	MODEL AGG_MENT_DIFF = AGG_MENT hard_drugs CURSmoke incomelev edulev  / SOLUTION CLPARM;
QUIT; 

******* END MODEL CREATION FOR AGG_MENT_DIFF OUTCOME *******;

******* BEGIN MODEL CREATION FOR AGG_PHYS_DIFF OUTCOME *******;
* Crude models;
PROC GLM DATA = HIV.AGGPHYS;
	MODEL AGG_PHYS_DIFF = AGG_PHYS / SOLUTION CLPARM;
QUIT; * AGG_PHYS is associated with AGG_PHYS_DIFF;

PROC GLM DATA = HIV.AGGPHYS;
	MODEL AGG_PHYS_DIFF = BMI / SOLUTION CLPARM;
QUIT; * BMI not associated with AGG_PHYS_DIFF;

PROC GLM DATA = HIV.AGGPHYS;
	MODEL AGG_PHYS_DIFF = AGE / SOLUTION CLPARM;
QUIT; * AGE not associated with AGG_PHYS_DIFF;

PROC GLM DATA = HIV.AGGPHYS;
	CLASS RaceCd;
	MODEL AGG_PHYS_DIFF = RaceCd / SOLUTION CLPARM;
QUIT; * RaceCd not assoicated with AGG_PHYS_DIFF;

PROC GLM DATA = HIV.AGGPHYS;
	CLASS HASHV;
	MODEL AGG_PHYS_DIFF = HASHV / SOLUTION CLPARM;
QUIT; * HASHV not assoicated with AGG_PHYS_DIFF;

PROC GLM DATA = HIV.AGGPHYS;
	CLASS Alchol;
	MODEL AGG_PHYS_DIFF = Alchol / SOLUTION CLPARM;
QUIT; * Alchol not assoicated with AGG_PHYS_DIFF;

PROC GLM DATA = HIV.AGGPHYS;
	CLASS CURSmoke;
	MODEL AGG_PHYS_DIFF = CURSmoke / SOLUTION CLPARM;
QUIT; * CURSmoke not assoicated with AGG_PHYS_DIFF;

PROC GLM DATA = HIV.AGGPHYS;
	CLASS incomelev;
	MODEL AGG_PHYS_DIFF = incomelev / SOLUTION CLPARM;
QUIT; * incomelev not assoicated with AGG_PHYS_DIFF;

PROC GLM DATA = HIV.AGGPHYS;
	CLASS edulev;
	MODEL AGG_PHYS_DIFF = edulev / SOLUTION CLPARM;
QUIT; * edulev not assoicated with AGG_MENT_DIFF;

PROC GLM DATA = HIV.AGGPHYS;
	CLASS artadh;
	MODEL AGG_PHYS_DIFF = artadh / SOLUTION CLPARM;
QUIT; * artadh not assoicated with AGG_PHYS_DIFF;

PROC SORT DATA = HIV.AGGPHYS;
	BY hard_drugs;
RUN;
PROC GLM DATA = HIV.AGGPHYS ORDER=DATA;
	CLASS hard_drugs;
	MODEL AGG_PHYS_DIFF = hard_drugs / SOLUTION CLPARM;
QUIT; * hard_drugs is associated with AGG_PHYS_DIFF;

* FULL MODEL;
PROC SORT DATA = HIV.AGGPHYS;
	BY DESCENDING hard_drugs;
RUN;
PROC GLM DATA = HIV.AGGPHYS ORDER=DATA;
	CLASS hard_drugs CURSmoke incomelev edulev;
	MODEL AGG_PHYS_DIFF = AGG_PHYS hard_drugs CURSmoke incomelev edulev   / SOLUTION CLPARM;
QUIT; 
******* END MODEL CREATION FOR AGG_PHYS_DIFF OUTCOME *******;

******* BEGIN MODEL CREATION FOR LEU3N_DIFF OUTCOME *******;
* Crude models;
PROC GLM DATA = HIV.LEU3N;
	MODEL LEU3N_DIFF = LEU3N / SOLUTION CLPARM;
QUIT; * LEU3N is not associated with LEU3N_DIFF;

PROC GLM DATA = HIV.LEU3N;
	MODEL LEU3N_DIFF = BMI / SOLUTION CLPARM;
QUIT; * BMI is associated with LEU3N_DIFF;

PROC GLM DATA = HIV.LEU3N;
	MODEL LEU3N_DIFF = AGE / SOLUTION CLPARM;
QUIT; * AGE not associated with LEU3N_DIFF;

PROC GLM DATA = HIV.LEU3N;
	CLASS RaceCd;
	MODEL LEU3N_DIFF = RaceCd / SOLUTION CLPARM;
QUIT; * RaceCd not assoicated with LEU3N_DIFF;

PROC GLM DATA = HIV.LEU3N;
	CLASS HASHV;
	MODEL LEU3N_DIFF = HASHV / SOLUTION CLPARM;
QUIT; * HASHV is assoicated with LEU3N_DIFF;

PROC GLM DATA = HIV.LEU3N;
	CLASS Alchol;
	MODEL LEU3N_DIFF = Alchol / SOLUTION CLPARM;
QUIT; * Alchol not assoicated with LEU3N_DIFF;

PROC GLM DATA = HIV.LEU3N;
	CLASS CURSmoke;
	MODEL LEU3N_DIFF = CURSmoke / SOLUTION CLPARM;
QUIT; * CURSmoke not assoicated with LEU3N_DIFF;

PROC GLM DATA = HIV.LEU3N;
	CLASS incomelev;
	MODEL LEU3N_DIFF = incomelev / SOLUTION CLPARM;
QUIT; * incomelev not assoicated with LEU3N_DIFF;

PROC GLM DATA = HIV.LEU3N;
	CLASS edulev;
	MODEL LEU3N_DIFF = edulev / SOLUTION CLPARM;
QUIT; * edulev not assoicated with LEU3N_DIFF;

PROC GLM DATA = HIV.LEU3N;
	CLASS artadh;
	MODEL LEU3N_DIFF = artadh / SOLUTION CLPARM;
QUIT; * artadh is assoicated with LEU3N_DIFF;

PROC GLM DATA = HIV.LEU3N;
	CLASS hard_drugs;
	MODEL LEU3N_DIFF = hard_drugs / SOLUTION CLPARM;
QUIT; * hard_drugs is associated with LEU3N_DIFF;

* FULL MODEL;
PROC SORT DATA = HIV.LEU3N;
	BY DESCENDING hard_drugs;
RUN;
PROC GLM DATA = HIV.LEU3N ORDER=DATA;
	CLASS HASHV artadh hard_drugs CURSmoke incomelev edulev;
	MODEL LEU3N_DIFF = LEU3N hard_drugs BMI HASHV  artadh  CURSmoke incomelev edulev / SOLUTION CLPARM;
QUIT; 
PROC GLM DATA = HIV.LEU3N ORDER=DATA;
	CLASS HASHV artadh hard_drugs CURSmoke incomelev edulev;
	MODEL LEU3N_DIFF = hard_drugs HASHV  artadh  CURSmoke incomelev edulev / SOLUTION CLPARM;
QUIT; 

PROC GLM DATA = HIV.LEU3N ORDER = DATA;
	CLASS HASHV artadh hard_drugs;
	MODEL LEU3N_DIFF = LEU3N hard_drugs HASHV artadh / SOLUTION CLPARM;
QUIT;
******* END MODEL CREATION FOR LEU3N_DIFF OUTCOME *******;

******* BEGIN MODEL CREATION FOR LVLOAD_DIFF OUTCOME *******;
* Crude models;
PROC GLM DATA = HIV.LVLOAD;
	MODEL LVLOAD_DIFF = LVLOAD / SOLUTION CLPARM;
QUIT; * LVLOAD is associated with LVLOAD_DIFF;

PROC GLM DATA = HIV.LVLOAD;
	MODEL LVLOAD_DIFF = BMI / SOLUTION CLPARM;
QUIT; * BMI not associated with LVLOAD_DIFF;

PROC GLM DATA = HIV.LVLOAD;
	MODEL LVLOAD_DIFF = AGE / SOLUTION CLPARM;
QUIT; * AGE not associated with LVLOAD_DIFF;

PROC GLM DATA = HIV.LVLOAD;
	CLASS RaceCd;
	MODEL LVLOAD_DIFF = RaceCd / SOLUTION CLPARM;
QUIT; * RaceCd is assoicated with LVLOAD_DIFF;

PROC GLM DATA = HIV.LVLOAD;
	CLASS HASHV;
	MODEL LVLOAD_DIFF = HASHV / SOLUTION CLPARM;
QUIT; * HASHV not assoicated with LVLOAD_DIFF;

PROC GLM DATA = HIV.LVLOAD;
	CLASS Alchol;
	MODEL LVLOAD_DIFF = Alchol / SOLUTION CLPARM;
QUIT; * Alchol not assoicated with LVLOAD_DIFF;

PROC GLM DATA = HIV.LVLOAD;
	CLASS CURSmoke;
	MODEL LVLOAD_DIFF = CURSmoke / SOLUTION CLPARM;
QUIT; * CURSmoke not assoicated with LVLOAD_DIFF;

PROC GLM DATA = HIV.LVLOAD;
	CLASS incomelev;
	MODEL LVLOAD_DIFF = incomelev / SOLUTION CLPARM;
QUIT; * incomelev not assoicated with LVLOAD_DIFF;

PROC GLM DATA = HIV.LVLOAD;
	CLASS edulev;
	MODEL LVLOAD_DIFF = edulev / SOLUTION CLPARM;
QUIT; * edulev is assoicated with LVLOAD_DIFF;

PROC GLM DATA = HIV.LVLOAD;
	CLASS artadh;
	MODEL LVLOAD_DIFF = artadh / SOLUTION CLPARM;
QUIT; * artadh is assoicated with LVLOAD_DIFF;

PROC GLM DATA = HIV.LVLOAD;
	CLASS hard_drugs;
	MODEL LVLOAD_DIFF = hard_drugs / SOLUTION CLPARM;
QUIT; * hard_drugs not associated with LVLOAD_DIFF;

* FULL MODEL;
PROC SORT DATA = HIV.LVLOAD;
	BY DESCENDING hard_drugs;
RUN;
PROC GLM DATA = HIV.LVLOAD ORDER = DATA;
	CLASS RaceCD CURSmoke incomelev edulev artadh hard_drugs;
	MODEL LVLOAD_DIFF = LVLOAD hard_drugs RaceCD edulev artadh / SOLUTION CLPARM;
QUIT; 

PROC GLM DATA = HIV.LVLOAD;
	CLASS RaceCD  HASHV Alchol CURSmoke incomelev edulev artadh hard_drugs;
	MODEL LVLOAD_DIFF = LVLOAD hard_drugs RaceCD artadh / SOLUTION CLPARM;
QUIT;
******* END MODEL CREATION FOR LVLOAD_DIFF OUTCOME *******;
