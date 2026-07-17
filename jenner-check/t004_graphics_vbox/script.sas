/* Adapted from Group_Graphics_Code_14.sas (Abby's question: does
   socioeconomic status affect the likelihood of smoking/drug use, and
   Chenchenyi's question on age groups). Original LIBNAME/PROC IMPORT
   pointed at a classroom shared drive (~/STAT5740HW/...) and a CSV not
   included in the repo; here mylib is WORK and the same-shaped sample
   rows are supplied inline via DATALINES. The three PROC SGPLOT VBOX
   calls (by Socioeconomic_status, twice, and by Age_Group) are unchanged
   from the author's script (ODS LISTING GPATH removed since this run
   captures the log + listing, not files written to a shared drive). */

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

/* Abby Kovach: Does socioeconomic status affect the likelihood of
an individual smoking or using drugs? */
TITLE "Distribution of Smoking Prevalence by Socioeconomic Status";
PROC SGPLOT DATA=mylib.youth_smoking_drug_data_copy;
	VBOX Smoking_Prevalence / CATEGORY=Socioeconomic_Status;
RUN;

TITLE "Distribution of Drug Experimentation by Socioeconomic Status";
PROC SGPLOT DATA=mylib.youth_smoking_drug_data_copy;
	VBOX Drug_experimentation / CATEGORY=Socioeconomic_Status;
RUN;


/* Chenchenyi Zhu: Which age group has a higher chance in engaging in smoking? */
PROC SORT DATA=mylib.youth_smoking_drug_data_copy;
	BY Age_Group;
RUN;
TITLE "Distribution of Smoking Prevalence by Age Groups";
PROC SGPLOT DATA=mylib.youth_smoking_drug_data_copy;
	VBOX Smoking_Prevalence / GROUP=Age_Group;
RUN;
