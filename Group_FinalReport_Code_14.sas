
LIBNAME classlib "~/my_shared_file_links/kelbick10/Datasets";
LIBNAME myfmts "~/STAT5740HW/MyFormats";
options fmtsearch = (myfmts);
LIBNAME mylib "~/STAT5740HW";
ODS LISTING GPATH="~/STAT5740HW/MyResults";

/* Import excel file that was downloaded from https://www.kaggle.com/datasets/waqi786/youth-smoking-and-drug-dataset */
PROC IMPORT DATAFILE='~/STAT5740HW/youth_smoking_drug_data_10000_rows_expanded.csv'
	DBMS=CSV
	OUT=mylib.youth_smoking_drug_data
	REPLACE;
	*GUESSINGROWS=5000;
RUN;

/* Create new dataset with variables that we will be using for our report */
DATA mylib.youth_smoking_drug_data_copy;
	SET mylib.youth_smoking_drug_data;
	KEEP Age_Group Smoking_Prevalence Peer_Influence Family_Background Parental_Supervision 
        Socioeconomic_status Mental_Health Drug_Experimentation;
RUN;

/*View data contents*/
TITLE "Contents of Complete Data Set Ready For Analysis";
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


/* Question 1: (Chenchenyi Zhu) which age group has a higher chance in engaging in smoking?
*/
ODS LISTING GPATH="~/STAT5740HW/MyResults" IMAGE_DPI=300;
/*Table shows the mean, ci, t-value, and p-value of t-test for smoking prevalence*/
TITLE "Mean CI T and P-value of each age group";
PROC TABULATE DATA=mylib.youth_smoking_drug_data_copy STYLE=[BACKGROUNDCOLOR=PINK COLOR=BLACK];
	VAR Smoking_Prevalence / STYLE=[BACKGROUNDCOLOR=YELLOW COLOR=BLACK];
	CLASS Age_Group / STYLE=[BACKGROUNDCOLOR=POWDERBLUE COLOR=BLACK];
	KEYWORD ALL SUM / STYLE=[BACKGROUNDCOLOR=RED];
	TABLE Smoking_Prevalence*Age_Group, (MEAN STD LCLM UCLM T PROBT) ALL /
	BOX=[label="T-test for all age groups for smoking prevalence"
		STYLE=[BACKGROUNDCOLOR=ORANGE]];
RUN;
ODS LISTING CLOSE;

ODS LISTING GPATH="~/STAT5740HW/MyResults" IMAGE_DPI=300;
ODS GRAPHICS / RESET IMAGENAME="Graph_CZ" OUTPUTFMT=PNG
		HEIGHT=3in WIDTH=3in;
/*Overall smoking prevalence percentage plot for each age group */
TITLE "ANOVA Test for Smoking Prevalence between Age Groups";
PROC ANOVA DATA=mylib.youth_smoking_drug_data_copy;
    CLASS Age_Group; /*grouping variable*/
    MODEL Smoking_Prevalence = Age_Group;
    MEANS Age_Group / SCHEFFE;
    LABEL Age_Group = "Age groups";
    LABEL Smoking_prevalence = "Smoking Prevalence %";
RUN;
ODS GRAPHICS OFF;
ODS LISTING CLOSE;



/* Question 2: (Abby Kovach) Does socioeconomic status affect the likelihood of
an individual smoking or using drugs? */

/* Smoking Prevalence and Drug Experimentation density plots */
ODS LISTING GPATH="~/STAT5740HW" IMAGE_DPI=300;
TITLE "Smoking Prevalence Density";
PROC SGPLOT DATA=mylib.youth_smoking_drug_data_copy;
DENSITY smoking_prevalence / TYPE=KERNEL;
	XAXIS LABEL="Smoking Prevalence (%)";
	YAXIS LABEL="Density";
RUN;
ODS LISTING CLOSE;

ODS LISTING GPATH="~/STAT5740HW" IMAGE_DPI=300;
TITLE "Drug Experimentation Density";
PROC SGPLOT DATA=mylib.youth_smoking_drug_data_copy;
DENSITY drug_experimentation / TYPE=KERNEL;
	XAXIS LABEL="Drug Experimentation (%)";
	YAXIS LABEL="Density";
RUN;
ODS LISTING CLOSE;

/* Testing difference in means of smoking prevalence across socioeconomic status levels using ANOVA */
ODS LISTING GPATH="~/STAT5740HW" IMAGE_DPI=300 STYLE=Meadow;
TITLE "Smoking Prevalence by Socioeconomic Status ANOVA";
PROC ANOVA DATA=mylib.youth_smoking_drug_data_copy;
    CLASS Socioeconomic_status;
    MODEL Smoking_Prevalence = Socioeconomic_status;
    MEANS Socioeconomic_status / SCHEFFE;
    LABEL Socioeconomic_status = "Socioeconomic Status (Level)";
    LABEL Smoking_prevalence = "Smoking Prevalence %";
RUN;
ODS LISTING CLOSE;

/* Testing difference in means of drug experimentation across socioeconomic status levels using ANOVA */
ODS LISTING GPATH="~/STAT5740HW" IMAGE_DPI=300 STYLE=Seaside;
TITLE "Drug Experimentation by Socioeconomic Status ANOVA";
PROC ANOVA DATA=mylib.youth_smoking_drug_data_copy;
    CLASS Socioeconomic_status;
    MODEL Drug_Experimentation = Socioeconomic_status;
    MEANS Socioeconomic_status / SCHEFFE;
    LABEL Socioeconomic_status = "Socioeconomic Status (Level)";
    LABEL Drug_experimentation = "Drug Experimentation %";
RUN;
ODS LISTING CLOSE;

/* Question 3 */
/* Yulai Zhang: How deos Family Background and Parental Supervision affect the individual smoking?*/
ODS PDF FILE="~/STAT5740HW/MyResults/PreliminaryAnalysis.pdf";
*Mean, confidence interval, t-value, and p-value of the t-test;
TITLE "Yulai Zhang";
TITLE1 "Mean CI T and P-value of each Family background group";
PROC TABULATE DATA=mylib.youth_smoking_drug_data_copy STYLE=[BACKGROUNDCOLOR=BlUE COLOR=BLACK];
	VAR Smoking_Prevalence / STYLE=[BACKGROUNDCOLOR=PINK COLOR=BLACK];
	CLASS Family_Background / STYLE=[BACKGROUNDCOLOR=GREEN COLOR=BLACK];
	KEYWORD ALL SUM / STYLE=[BACKGROUNDCOLOR=RED];
	TABLE Smoking_Prevalence*Family_Background, (MEAN STD LCLM UCLM T PROBT) ALL /
	BOX=[label="T-test for all level of Family Background for smoking prevalence"
		STYLE=[BACKGROUNDCOLOR=ORANGE]];
RUN;


TITLE1 "Detailed T-test for each level of Family Background";
PROC SORT DATA=mylib.youth_smoking_drug_data_copy;
	BY Family_Background;
RUN;
PROC TTEST DATA=mylib.youth_smoking_drug_data_copy;
	BY Family_Background;
	VAR Smoking_Prevalence;
RUN;

PROC SGPLOT DATA=mylib.youth_smoking_drug_data_copy;
	HISTOGRAM Smoking_Prevalence / GROUP=Family_Background TRANSPARENCY=0.8;
	DENSITY Smoking_Prevalence;
	DENSITY Smoking_Prevalence / TYPE=KERNEL;
RUN;

TITLE1 "Mean CI T and P-value of each Parental Supervision group";
PROC TABULATE DATA=mylib.youth_smoking_drug_data_copy STYLE=[BACKGROUNDCOLOR=BlUE COLOR=BLACK];
	VAR Smoking_Prevalence / STYLE=[BACKGROUNDCOLOR=PINK COLOR=BLACK];
	CLASS Parental_Supervision / STYLE=[BACKGROUNDCOLOR=GREEN COLOR=BLACK];
	KEYWORD ALL SUM / STYLE=[BACKGROUNDCOLOR=RED];
	TABLE Smoking_Prevalence*Parental_Supervision, (MEAN STD LCLM UCLM T PROBT) ALL /
	BOX=[label="T-test for all level of Family Background for smoking prevalence"
		STYLE=[BACKGROUNDCOLOR=ORANGE]];
RUN;


TITLE1 "Detailed T-test for each level of Parental Supervision";
PROC SORT DATA=mylib.youth_smoking_drug_data_copy;
	BY Parental_Supervision;
RUN;
PROC TTEST DATA=mylib.youth_smoking_drug_data_copy;
	BY Parental_Supervision;
	VAR Smoking_Prevalence;
RUN;

PROC SGPLOT DATA=mylib.youth_smoking_drug_data_copy;
	HISTOGRAM Smoking_Prevalence / GROUP=Parental_Supervision TRANSPARENCY=0.8;
	DENSITY Smoking_Prevalence;
	DENSITY Smoking_Prevalence / TYPE=KERNEL;
RUN;
	
ODS PDF CLOSE;

/* The graph looks at smoking prevalence rates according to parental supervision levels and
 family background. Smoking prevalence varies by family background and is higher among those
 with less parental supervision, according to stacked bars. All backgrounds see a decrease in
 smoking prevalence with increased supervision, though the effects vary by category. This 
 implies that smoking behavior is influenced by both factors working together. */
ODS LISTING GPATH="~/STAT5740HW" IMAGE_DPI=300;
TITLE "Smoking Prevalence by Parental Supervision within Family Background";
PROC SGPLOT DATA=mylib.youth_smoking_drug_data_copy;
    VBAR Parental_Supervision / RESPONSE=Smoking_Prevalence GROUP=Family_Background STAT=MEAN;
    XAXIS LABEL="Parental Supervision level";
    YAXIS LABEL="Average Smoking Prevalence Rate";
RUN;
ODS LISTING CLOSE;


/* Question 4 */