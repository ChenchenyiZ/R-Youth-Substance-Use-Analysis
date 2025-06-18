LIBNAME classlib "~/my_shared_file_links/kelbick10/Datasets";
LIBNAME myfmts "~/STAT5740HW/MyFormats";
options fmtsearch = (myfmts);
LIBNAME mylib "~/STAT5740HW";
ODS LISTING GPATH="~/STAT5740HW/MyResults";



PROC IMPORT DATAFILE='~/STAT5740HW/youth_smoking_drug_data_10000_rows_expanded.csv'
	DBMS=CSV
	OUT=mylib.youth_smoking_drug_data
	REPLACE;
	*GUESSINGROWS=5000;
RUN;

DATA mylib.youth_smoking_drug_data_copy;
	SET mylib.youth_smoking_drug_data;
	KEEP Age_Group Smoking_Prevalence Peer_Influence Family_Background Parental_Supervision 
        Socioeconomic_status Mental_Health Drug_Experimentation;
RUN;

/* Abby Kovach: Does socioeconomic status affect the likelihood of
an individual smoking or using drugs? */
ODS LISTING GPATH="~/STAT5740HW" IMAGE_DPI=300;
TITLE "Distribution of Smoking Prevalence by Socioeconomic Status";
PROC SGPLOT DATA=mylib.youth_smoking_drug_data_copy;
	VBOX Smoking_Prevalence / CATEGORY=Socioeconomic_Status;
RUN;
ODS LISTING CLOSE;

ODS LISTING GPATH="~/STAT5740HW" IMAGE_DPI=300;
TITLE "Distribution of Drug Experimentation by Socioeconomic Status";
PROC SGPLOT DATA=mylib.youth_smoking_drug_data_copy;
	VBOX Drug_experimentation / CATEGORY=Socioeconomic_Status;
RUN;
ODS LISTING CLOSE;


/* Chenchenyi Zhu: Which age group has a higher chance in engaging in smoking? */
PROC SORT DATA=mylib.youth_smoking_drug_data_copy;
	BY Age_Group;
RUN;
ODS LISTING GPATH="~/STAT5740HW" IMAGE_DPI=300;
TITLE "Distribution of Smoking Prevalence by Age Groups";
PROC SGPLOT DATA=mylib.youth_smoking_drug_data_copy;
	VBOX Smoking_Prevalence / GROUP=Age_Group;
RUN;
ODS LISTING CLOSE;



