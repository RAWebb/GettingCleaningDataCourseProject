
Course Project for "Getting and Cleaning Data"
==========================================
###Part of the Data Science Specialization offered by Johns-Hopkins Univ; hosted by Coursera.org.


##R.A. Webb
##November 2015 session.


Files in repository:
========================
*	README.md  -  This document.  
  1.) Explains files present in this repo. 
  2.) Discusses data processing procedure.  Outlines the overall process & details the steps contained run_analysis.R  

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

*	HAR_tidy.txt  - Resultant tidy data set generated by run_analysis.R. A text file written by the R function `write.table()`. Descriptions of the variables contained in this file can be found in codebook.md.  To read this data back into R: `HAR_tidy <- read.table("HAR_tidy.txt", header = TRUE, stringsAsFactors=TRUE)`.  You can also find the syntax for this call in commented lines at the bottom of run_analysis.R.

* readme_Reyes-Ortiz.txt  -  README file associated with the original data which contains further discussion of the study and details the files present in their dataset.  A copy of this file is named README.txt within the author's zipped dataset.


Other files used in this project:

Raw data :
*	`getdata-projectfiles-UCI HAR Dataset.zip` File downloads as a .zip.  After unzip, the following files are present and used in this project:
  * In `UCI HAR Dataset/activity_labels.txt`   
  * `UCI HAR Dataset/features.txt`
  * `UCI HAR Dataset/features_info.txt`
  * `UCI HAR Dataset/README.txt`
  * `UCI HAR Dataset/test/subject_test.txt`
    * `UCI HAR Dataset/train/subject_train.txt`   Same as above for the "train" dataset.
  * `UCI HAR Dataset/test/X_test.txt`
    * `UCI HAR Dataset/train/X_train.txt`   Same as above for the "train" dataset.
  * `UCI HAR Dataset/test/y_test.txt`
    * `UCI HAR Dataset/train/y_train.txt`   Same as above for the "train" dataset.
  *Files in `UCI HAR Dataset/test/Inertial Signals` and `UCI HAR Dataset/train/Inertial Signals` not used in this project.	
  
Outline of data processing:
---------------------------
Script created in R version 3.1.1.  Running on Windows 8.1; 64-bit platform.
1.) Download & unzip dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2.) Execute run_analysis.R script.  This script:
  * Reads all relevant data files into R.
  * Attaches labels to the variables.
  * Attaches the appropriate Subject & Activity Labels to each observation
  * Combines the Test and Train datasets into one R dataframe.
  * Extracts only those variables measuring a mean or standard deviation of a measured quantity.
  * Converts integer factor levels for Activities into descriptive text names.
  * Creates new dataset consisting of the calculated mean of all remaining variables by subject and activity.  That is, creates 1 overall mean for each variable for each subject/activity pairing.
  * Relabels variable in new dataset to indicate mean has been taken.
  * Writes resultant tidy dataset to a text file:  `HAR_tidy.txt`

Detailed discussions of data processing steps:
=====================================

Preliminary steps:
-------------------
The run_analysis.R script assumes the raw data have been downloaded and unzipped to R's current working
directory, following the same directory structure provided in the .zip.  If this isn't the case, execute
the following in R:
```
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "UCI_HAR_dataset.zip")

unzip("UCI_HAR_dataset.zip")
``` 
 I first read the variable names (labels) from features.txt, then read each of the data frames to be used
via the read.table() function while at the same time assigning variable names to the data frames.  This actually 
constitutes step 4.) of the processing, but assigning names here seems far more logical, less error prone, and 
makes subsequent manipulations easier.  Not sure why it is recommended as step 4.

 
Step 1:
-------------------
```
Merge the training and the test sets to create one data set.
```

There are various functions that could be used, but here, we're just sticking together tables based on rows & 
columns, there's no real matching of the data or keys or indexing involved.  Just a 1-to-1 match of columns 
then rows, so a simple cbind & rbind seems appropriate.



Step 2:
-------------------
```
Extract only the measurements on the mean and standard deviation for each measurement. 
```

The exact list of variables which were intended to be extracted is left (intentionally?) vague.  
Compounding the issue is that authors of the original dataset were brief in their descriptions of the
exact meanings of each variable and labels don't  always match exactly between files.  Thirdly, some 
of variables in question are far beyond the mathematical scope of this course - in particular
those that are measured in frequency space under a Fourier Transform.  Nonetheless, here is my interpretation 
of the appropriate variables to extract:

The easiest route would be to extract all columns whose headers contain "mean" or "std".  While I wouldn't 
mark anyone off for doing this, I don't believe this is quite what is being asked for.  

* There is no ambiguity in the standard deviation variables.  All columns which contain "std" in the header
are actual statistical measurements of the standard deviation of the quantity in question.

*  Similarly all those that contain ".mean" are clearly averages of actual measurements. Those in the "f" frequency domain are still amplitude signals.   NOTE: "-", "(" and ")"  from features.txt  file has been replaced with "." in dataframe column headers.

* ambiguous case 1:  Measured angles which contain:  tBodyAccMean, tBodyAccJerkMean, gravityMean or tBodyGyroMean.
Each of these variables is associated with an "Angle", measuring the angular separation between 2 vectors.  The fact that these vectors are derived from averages of other quantities, does not make these measurements a mean of anything.  There is no averaging involved in calculating these values.  Once the vectors have been calculated, these actual measure of angle are fixed and there is no averaging to derive these quantities.   Thus, I opt to exclude these variables in the extracted dataset.

* ambiguous case 2:  Columns which contain ".meanfreq()"  in the header.  
These measure the average frequency of components of the Fourier transform of the quantity in question.  While they are not averages of physically measured quantities, and they represent average frequencies instead of amplitudes in the other variables, they still are averages of quantities mathematically derived from the measurements (frequencies in Fourier domain).  Thus, my interpretation is that they should be included in the extracted data.


Step 3:
------------------------
```
Use descriptive activity names to name the activities in the data set
```
Activity levels were already defined as factors when data was read into R, so we use revalue() to change the names 
of the factors.  Note revalue() comes from the plyr  package and when using both plyr  & dplyr  packages, plyr should 
generally be loaded first, otherwise it could interfere with dplyr functions such as summarize().


Step 4:
------------------------
```
Appropriately label the data set with descriptive variable names.
```

I incorporate labelling of the data into the read of the data into R, prior to step 1.

Seems easier, less error prone & more logical than trying to maintain 
the structure through all the manipulations and then match up labels at 
the end.

While the variable names from the original data are somewhat dense & tricky to parse
they contain all the necessary info to use in conjunction with the feature_info.txt
file from the zipped dataset (also reproduced at the bottom of this document) to derive the meaning 
of each variable.  Hence, the names are quite descriptive and well chosen for a dataset with such 
a large number of similar & complex variables. 


Note that R has replace certain characters such as "-", "(", ")"  with "."
but this doesn't impair deciphering the meaning at all.

Description of the variables & variable names is discussed in the next section.


Step 5:
------------------------
```
From the data set in step 4, creates a second, independent tidy data set  with the average of each variable for each 
activity and each subject.
```

The grading rubric for the assignment indicates that either the long form or the wide form of tidy data is acceptable 
for this project.  I have opted to use the wide format here for several reasons:

1.) The raw data is delivered in a wide format (not fully "tidy", but with each variable in a separate column).  The 
processing naturally leads to wide-form tidy dataset with much less manipulation.

2.)  While long-form data may be preferred or even required by some R functions, visually the long-form of the data is 
quite impractical for human readability.  

3.) Many of the measured variables are very closely related to one another.  For example, the 3 separate spatial 
components of many of the measurements really must be combined & analyzed together to understand the nature of the 
motion.  Thus, it makes sense to keep the data in a form where related measurements stay together & is obvious how 
they group.

4.)  There is much less repetition in the wide-form of the tidy dataset for this case.  The long form would include 
repeating the somewhat long & unwieldy variable names 180 times for each of 79 measured variables meaning the variable 
names would appear over 14000 times.


In any event, the delivered data should be considered tidy as each column represents one variable.  And each row 
represents 1 observation of each of those variables.  As well, the dataset contains a header row with variable names.



References:
===========================

Dataset comes from:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones 
using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). 
Vitoria-Gasteiz, Spain. Dec 2012
