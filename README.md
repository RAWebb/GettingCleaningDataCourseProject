
Course Project for "Getting and Cleaning Data"
==========================================

#####Part of the Data Science Specialization offered by Johns-Hopkins Univ; hosted by Coursera.org.


###R.A. Webb
November 2015 session.

---------------------------

Files in repository:
------------------------------
*	README.md  -  This document.  Contains:  
  1.) Explaination of files present in this repo. 

  2.) Summary outline of the overall data processing procedure as executed by run_analysis.R.  A more detailed discussion is in codebook.md  

*	codebook.md   -  Contains:
  
  1.) Description & requirements for the project.

  2.) Description of the variables used in this project.  Both in the tidy HAR_tidy.txt and those present during the processing procedure.  

  3.) Detailed discussion of the steps in the data analysis.  This includes some explanation of the functions used in run_analysis.R and a discussion of the reasoning behind decisions made in the data processing such as variables to include in the "mean & standard deviation" group, and the selection of wide-form tidy data for output.

*	run_analysis.R  -  R script which contains all R code for transformation of raw data to tidy data.  
Script assumes raw data has been placed in R working directory under UCI HAR Dataset/ directory.  If not, codebook.md
and run_analysis.R both contain instructions & code to download and create the appropriate directory structure.  

*	HAR_tidy.txt  - Resultant tidy data set generated by run_analysis.R. A text file written by the R function `write.table()`. Descriptions of the variables contained in this file can be found in codebook.md.  To read this data back into R: `HAR_tidy <- read.table("HAR_tidy.txt", header = TRUE, stringsAsFactors=TRUE)`.  You can also find the syntax for this call in commented lines at the bottom of run_analysis.R.

*	readme_Reyes-Ortiz.txt  -  README file associated with the original data which contains further discussion of the study and details the files present in their dataset.  A copy of this file is named README.txt within the author's zipped dataset.


Other files used in this project:

Raw data :
*	`getdata-projectfiles-UCI HAR Dataset.zip` File downloads as a .zip.  After unzip, the following files are present and used in this project:
  * `UCI HAR Dataset/activity_labels.txt` Translation between activity & activity code.   
  * `UCI HAR Dataset/features.txt`  Names of variables in raw dataset.
  * `UCI HAR Dataset/features_info.txt`  Author's description of variable names, see also my codebook.md
  * `UCI HAR Dataset/README.txt`   Author's README file containing details of the study.
  * `UCI HAR Dataset/test/subject_test.txt`   List of subject ID's corresponding to observations in X_test.txt
    * `UCI HAR Dataset/train/subject_train.txt`   Same as above for the "train" dataset.
  * `UCI HAR Dataset/test/X_test.txt`  Raw data.  Statistical processing has been done, but this constitutes the "raw data".
    * `UCI HAR Dataset/train/X_train.txt`   Same as above for the "train" dataset.
  * `UCI HAR Dataset/test/y_test.txt`  Activity codes corresponding to each observation in X_test.txt
    * `UCI HAR Dataset/train/y_train.txt`   Same as above for the "train" dataset.
  * Files in `UCI HAR Dataset/test/Inertial Signals` and `UCI HAR Dataset/train/Inertial Signals` not used in this project.	
  
Outline of data processing:
---------------------------
Script created in R version 3.1.1.  Running on Windows 8.1; 64-bit platform.

1.) Download & unzip dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2.) Execute run_analysis.R script.  
This script:
  * Reads all relevant data files into R.
  * Corrects errors in some of variable names.
  * Attaches corrected labels to the variables.
  * Attaches the appropriate Subject & Activity Labels to each observation
  * Combines the Test and Train datasets into one R data frame.
  * Extracts only those variables measuring a mean or standard deviation of a measured quantity.
  * Converts integer factor levels for Activities into descriptive text names.
  * Creates new dataset consisting of the calculated mean of all remaining variables by subject and activity.  That is, creates 1 overall mean for each variable for each subject/activity pairing.
  * Relabels variables in new dataset to indicate mean has been taken.
  * Writes resultant tidy dataset to a text file:  `HAR_tidy.txt`



References:
===========================

Dataset comes from:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
