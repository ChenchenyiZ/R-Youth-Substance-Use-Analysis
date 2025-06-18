LIBNAME classlib "~/my_shared_file_links/kelbick10/Datasets";
LIBNAME myfmts "~/STAT5740HW/MyFormats";
options fmtsearch = (myfmts);
LIBNAME mylib "~/STAT5740HW";
ODS LISTING GPATH="~/STAT5740HW/MyResults";



PROC IMPORT DATAFILE='~/STAT5740HW/youth_smoking_drug_data_10000_rows_expanded.csv'
	DBMS=CSV
	OUT=mylib.youth_smoking_drug_data
	REPLACE;
	GUESSINGROWS=5000;
RUN;

DATA mylib.youth_smoking_drug_data_copy;
	SET mylib.youth_smoking_drug_data;
	KEEP Age_Group Smoking_Prevalence Peer_Influence Family_Background Parental_Supervision 
        Socioeconomic_status Mental_Health Drug_Experimentation;
RUN;

PROC PRINT DATA=mylib.youth_smoking_drug_data_copy;
RUN;

/* Specific question(Yulai Zhang;zhang.14631): How do family background 
and Parental Supervision levels influence smoking prevalence among youth? */

DATA mylib.youth_smoking_drug_data_copy_YZ;
	SET mylib.youth_smoking_drug_data_copy;
	KEEP Family_Background Parental_Supervision Smoking_Prevalence;
RUN;

PROC PRINT DATA=mylib.youth_smoking_drug_data_copy_YZ;
RUN;


ODS PDF FILE="~/STAT5740HW/MyResults/Group_Contents_14.pdf";
TITLE "Contents of Complete Data Set Ready For Analysis";
TITLE2 "Group 14: Abby K., Chenchenyi Z., Yulai Z., and Xinrui W.";
PROC CONTENTS DATA=mylib.youth_smoking_drug_data_copy;
RUN;
TITLE "Yulai Zhang: How do family background 
and Parental Supervision levels influence smoking prevalence among youth?";
TITLE2 "Variables: Family_Background Parental_Supervision Smoking_Prevalence";
PROC CONTENTS DATA=mylib.youth_smoking_drug_data_copy_YZ;
RUN;
ODS PDF CLOSE;



