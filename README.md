
Course Project for "Getting and Cleaning Data"
==========================================
###Part of the Data Science Specialization offered by Johns-Hopkins Univ; hosted by Coursera.org.


##R.A. Webb
###November 2015 session.


Files in repository:
-----------------
*	README.md  -  This document.

*	codebook.md   -  Contains:
  
  1.) Descriptions of the variables in outputted dataset:  HAR_tidy.txt.  

  2.) Discussion of the steps taken in run_analysis.R to generate tidy data set (HAR_tidy.txt) from the raw data. 

  3.) Discussion of reasoning behind decisions made in the data processing such as variables to include in the "mean 
& stand deviation" group.  And the selection of wide-form tidy data for output.

*	run_analysis.R  -  R script which contains all R code for transformation of raw data to tidy data.  
Script assumes raw data has been placed in R working directory under UCI_HAR_dataset/ directory.  codebook.md
and run_analysis.R contain instructions & code to download and create the appropriate directory structure.  
Simply uncomment the  "download & unzip data" section in run_analysis.R.  Script is annotated & labels each 
step taken in the processing.

*	HAR_tidy.txt  - Resultant tidy data set generated by run_analysis.R. Text file written by the write.table() 
function. Descriptions of the variables contained in this file can be found in codebook.md.  To read this data 
back into R: 'HAR_tidy <- read.table("HAR_tidy.txt", header = TRUE, stringsAsFactors=TRUE)'.  You can also find the syntax for this call in commented lines at the bottom of run_analysis.R.

* readme_Reyes-Ortiz.txt  -  readme file associated with the original data which contains further discussion of the study.


Other files used in this project:

Raw data:
*	getdata-projectfiles-UCI HAR Dataset.zip      File downloads as a .zip.  After unzip, the following files are present:

*	

References:
-----------------

Dataset comes from:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones 
using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). 
Vitoria-Gasteiz, Spain. Dec 2012
