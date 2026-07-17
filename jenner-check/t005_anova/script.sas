/* Adapted from Group_FinalReport_Code_14.sas (Chenchenyi's question: which
   age group has a higher chance of engaging in smoking?). Original
   LIBNAME/PROC IMPORT pointed at a classroom shared drive (~/STAT5740HW/...)
   and a CSV downloaded from Kaggle (waqi786/youth-smoking-and-drug-dataset)
   not included in the repo; here mylib is WORK and the same-shaped sample
   rows are supplied inline via DATALINES. The two PROC ANOVA calls (age
   group, then socioeconomic status) with their CLASS/MODEL/MEANS SCHEFFE
   and LABEL statements are unchanged from the author's script (ODS
   GRAPHICS / GPATH removed since this run captures the log + listing). */

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

/* Question 1: (Chenchenyi Zhu) which age group has a higher chance in engaging in smoking? */
TITLE "ANOVA Test for Smoking Prevalence between Age Groups";
PROC ANOVA DATA=mylib.youth_smoking_drug_data_copy;
    CLASS Age_Group; /*grouping variable*/
    MODEL Smoking_Prevalence = Age_Group;
    MEANS Age_Group / SCHEFFE;
    LABEL Age_Group = "Age groups";
    LABEL Smoking_prevalence = "Smoking Prevalence %";
RUN;

/* Question 2: (Abby Kovach) Does socioeconomic status affect the likelihood of
an individual smoking or using drugs? */
TITLE "Smoking Prevalence by Socioeconomic Status ANOVA";
PROC ANOVA DATA=mylib.youth_smoking_drug_data_copy;
    CLASS Socioeconomic_status;
    MODEL Smoking_Prevalence = Socioeconomic_status;
    MEANS Socioeconomic_status / SCHEFFE;
    LABEL Socioeconomic_status = "Socioeconomic Status (Level)";
    LABEL Smoking_prevalence = "Smoking Prevalence %";
RUN;

TITLE "Drug Experimentation by Socioeconomic Status ANOVA";
PROC ANOVA DATA=mylib.youth_smoking_drug_data_copy;
    CLASS Socioeconomic_status;
    MODEL Drug_Experimentation = Socioeconomic_status;
    MEANS Socioeconomic_status / SCHEFFE;
    LABEL Socioeconomic_status = "Socioeconomic Status (Level)";
    LABEL Drug_experimentation = "Drug Experimentation %";
RUN;
