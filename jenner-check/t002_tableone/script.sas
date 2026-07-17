/* Adapted from Group_TableOne_code_14.sas. The original LIBNAME/PROC IMPORT
   pointed at a classroom shared drive (~/STAT5740HW/...) and a CSV not
   included in the repo; here mylib is WORK and the same-shaped sample rows
   are supplied inline via DATALINES. The KEEP list, PROC CONTENTS, and the
   PROC TABULATE "Table One" call (same CLASS/VAR/TABLE statement) are
   unchanged from the author's script. */

LIBNAME mylib "%sysfunc(pathname(work))";

DATA mylib.youth_smoking_drug_data;
	INFILE DATALINES DSD DLM=',' MISSOVER;
	INPUT Age_Group :$8. Smoking_Prevalence Peer_Influence Family_Background
	      Parental_Supervision Socioeconomic_status :$8. Mental_Health Drug_Experimentation;
	DATALINES;
10-12,12.4,3,2,8,Low,4,6.1
10-12,18.7,5,4,6,Middle,5,9.4
10-12,9.2,2,1,9,High,3,4.0
13-15,22.5,6,5,5,Low,6,14.2
13-15,27.8,7,6,4,Middle,6,17.9
13-15,31.4,8,7,3,High,7,20.5
13-15,25.1,6,4,5,Low,5,15.8
16-18,35.6,8,6,3,Middle,7,24.3
16-18,41.2,9,7,2,Low,8,28.9
16-18,38.9,8,8,3,High,7,26.4
16-18,44.0,9,6,2,Middle,8,30.1
19-21,47.3,9,7,2,Low,8,33.5
19-21,52.1,10,8,1,Middle,9,37.2
19-21,49.8,9,7,2,High,8,35.0
19-21,55.4,10,9,1,Low,9,39.8
10-12,15.0,4,3,7,High,4,7.5
13-15,29.0,7,5,4,High,6,18.6
16-18,40.5,8,7,3,Low,7,27.7
19-21,50.2,9,8,2,Middle,8,34.9
10-12,11.1,3,2,8,Middle,4,5.5
;
RUN;

DATA mylib.youth_smoking_drug_data_copy;
	SET mylib.youth_smoking_drug_data;
	KEEP Age_Group Smoking_Prevalence Peer_Influence Family_Background Parental_Supervision
        Socioeconomic_status Mental_Health Drug_Experimentation;
RUN;

TITLE "Contents of Complete Data Set Ready For Analysis";
TITLE2 "Group 14: Abby K., Chenchenyi Z., Yulai Z., and Xinrui W.";
PROC CONTENTS DATA=mylib.youth_smoking_drug_data_copy;
RUN;

/* Table one */
PROC TABULATE DATA = mylib.youth_smoking_drug_data_copy;
	TITLE "Table One";
	TITLE2 "Group 14: Abby K., Chenchenyi Z., Yulai Z., and Xinrui W.";
	CLASS Age_Group Socioeconomic_status;
	VAR Smoking_Prevalence Peer_Influence Family_Background Parental_Supervision Mental_Health Drug_Experimentation;
	TABLE Smoking_Prevalence*(MEAN STD) Peer_Influence*(MEAN STD) Family_Background*(MEAN STD)
	Parental_Supervision*(MEAN STD) Mental_Health*(MEAN STD) Drug_Experimentation*(MEAN STD) Socioeconomic_status*(N ColPctN),
	Age_group ALL;
RUN;
