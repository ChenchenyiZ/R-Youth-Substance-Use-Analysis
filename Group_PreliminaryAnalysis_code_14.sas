LIBNAME classlib "~/my_shared_file_links/kelbick10/Datasets";
LIBNAME myfmts "~/STAT5740HW/MyFormats";
options fmtsearch = (myfmts);
LIBNAME mylib "~/STAT5740HW";
ODS LISTING GPATH="~/STAT5740HW/MyResults";

*Chenchenyi: Which age group has a higher chance in engaging in smoking?;
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

ODS PDF FILE="~/STAT5740HW/MyResults/PreliminaryAnalysis.pdf";
*This shows the mean, confidence interval, t-value, and p-value of the t-test;
TITLE "Mean CI T and P-value of each age group";
PROC TABULATE DATA=mylib.youth_smoking_drug_data_copy STYLE=[BACKGROUNDCOLOR=PINK COLOR=BLACK];
	VAR Smoking_Prevalence / STYLE=[BACKGROUNDCOLOR=YELLOW COLOR=BLACK];
	CLASS Age_Group / STYLE=[BACKGROUNDCOLOR=POWDERBLUE COLOR=BLACK];
	KEYWORD ALL SUM / STYLE=[BACKGROUNDCOLOR=RED];
	TABLE Smoking_Prevalence*Age_Group, (MEAN STD LCLM UCLM T PROBT) ALL /
	BOX=[label="T-test for all age groups for smoking prevalence"
		STYLE=[BACKGROUNDCOLOR=ORANGE]];
RUN;
*This is more specific of the above calculations, with graphics;
TITLE "Detailed T-test for each age group";
PROC SORT DATA=mylib.youth_smoking_drug_data_copy;
	BY Age_Group;
RUN;
PROC TTEST DATA=mylib.youth_smoking_drug_data_copy;
	BY Age_Group;
	VAR Smoking_Prevalence;
RUN;

PROC SGPLOT DATA=mylib.youth_smoking_drug_data_copy;
	HISTOGRAM Smoking_Prevalence / GROUP=Age_Group TRANSPARENCY=0.8;
	DENSITY Smoking_Prevalence;
	DENSITY Smoking_Prevalence / TYPE=KERNEL;
RUN;
	
ODS PDF CLOSE;


