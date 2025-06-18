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
RUN;

PROC PRINT DATA=mylib.youth_smoking_drug_data_copy;
	VAR Age_Group Smoking_Prevalence Peer_Influence Family_Background Parental_Supervision;
RUN;

ODS PDF FILE="~/STAT5740HW/MyResults/Group_Contents_14.pdf";
TITLE "Contents of Complete Data Set Ready For Analysis";
TITLE2 "Group 14: Abby K., Chenchenyi Z., Yulai Z., and Xinrui W.";
PROC CONTENTS DATA=mylib.youth_smoking_drug_data_copy;
RUN;
ODS PDF CLOSE;



