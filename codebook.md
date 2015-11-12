# Codebook


##Course Project for "Getting and Cleaning Data"

##Part of the Data Science Specialization offered by Johns-Hopkins Univ
hosted by Coursera.org.
==========================================

##R.A. Webb
### November 2015
-----------------


## Description:
###This project is intended to demonstrate some basic data cleaning skills and generate a tidy set.

Instructions:
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal 
is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of 
yes/no questions related to the project. You will be required to submit: 
1.) a tidy data set as described below, 
2.) a link to a Github repository with your script for performing the analysis, and 
3.) a code book that describes the variables, the data, and any transformations or work that you performed to 
clean up the data called CodeBook.md. 

You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts 
work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this 
article. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to 
attract new users. The data linked to from the course website represent data collected from the accelerometers 
from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You should create one R script called run_analysis.R that does the following. 
1.) Merges the training and the test sets to create one data set.
2.) Extracts only the measurements on the mean and standard deviation for each measurement. 
3.) Uses descriptive activity names to name the activities in the data set
4.) Appropriately labels the data set with descriptive variable names. 
5.) From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
for each activity and each subject.

Good luck!



Outline and discussion of steps:
================================



Preliminary steps:
-------------------
The run_analysis.R script assumes the raw data have been downloaded and unzipped to R's current working
directory, following the same directory structure provided in the .zip.  If this isn't the case, execute
the following in R:
* download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "UCI_HAR_dataset.zip")
* unzip("UCI_HAR_dataset.zip")
 
 I first read the variable names (labels) from features.txt, then read each of the data frames to be used
via the read.table function while assigning variable names to the data frames.  This actually constitutes step
4 of the processing, but assigning names here seems far more logical, less error prone, and makes subsequent 
manipulations easier.  Not sure why it is recommended as step 4.

 
Step 1:
-------------------
There are various functions that could be used, but here, we're just sticking together tables based on rows & 
columns, there's no real matching of the data or keys or indexing involved.  Just a 1-to-1 match of columns 
then rows, so a simple cbind & rbind seems appropriate.



Step 2:
-------------------
Extract only the measurements on the mean and standard deviation for each measurement. 

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

*  Similarly all those that contain ".mean" are clearly averages of actual measurements.  NOTE: "-", 
"(" and ")"  from features.txt  file has been replaced with "." in dataframe column headers.

* ambiguous case 1:  Measured angles which contain:  tBodyAccMean, tBodyAccJerkMean, gravityMean or tBodyGyroMean.
These measure the angular separation between 2 vectors.  The fact that these vectors are derived from averages of other
quantities, does not make these measurements a mean of anything.  There is no averaging involved in calculating these 
values.  Once the vectors have been calculated, these actual measure of angle are fixed and there is no averaging to derive 
these quantities.   Thus, I opt not to include these variables in the extracted dataset.

* ambiguous case 2:  Columns which contain ".meanfreq()"  in the header.  These measure the average frequency of 
components of the Fourier transform of the quantity in question.  While they are not averages of physically measured 
quantities, they averages of quantities mathematically derived from the measurements.  Thus, my interpretation is 
that they should be included in the extracted data.


Step 3:
------------------------
Activity levels were already defined as factors when data was read into R, so we use revalue() to change the names 
of the factors.  Note revalue() comes from the plyr  package and when using both plyr  & dplyr  packages, plyr should 
generally be loaded first, otherwise it could interfere with dplyr functions such as summarize().


Step 4:
------------------------
Appropriately label the data set with descriptive variable names.

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
From the data set in step 4, creates a second, independent tidy data set  with the average of each variable for each 
activity and each subject.

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


Description of the variables:
============================

## Abreviations used in raw & tidy variable names:
* Before first "." 
  * leading t or f  for time or frequency (Fourier) domain.
  * Body or Gravity.  Whether quantity is measuring motion/acceleration of the body or due to gravity
  * Acc or Gyro.  Data as measured by accelerometer  or gyroscope sensor.
  * Jerk.  Measuring change in acceleration.
  * Mag.  Magnitude of signal independent of spatial direction. Combines XYZ signals.
  * Angle.  Angle between 2 vectors, not used in this project.
* After first ".", statistical and computed physical quantities:
  * mean, std, meanFreq.   mean, standard deviation and mean frequency of signals in Fourier domain.  These are used in the project.
  * max, min, mad, sma, energy, arCoeff, correlation, igr, entropy, skewness, kurtosis, maxInds, bandsEnergy:  Other statistical and
derived physical quantities not used in this project.
* After "..."
  * X, Y, Z.  Spatial dimensions for measurements (direction).
  * Numbers.  Coefficients and bands.  Not used in this project.

  
## Units of measurements:
* Authors state that the units for measurements in the inertial signals datasets  are in g's for accelerations  and 
radians / sec for angular velocities.  Presumably these carry over to the other datasets.  Also presumably, the Jerk measurements 
are derivatives done in the same units so g/sec and radians/s^2.


###HAR_tidy.txt
-----------------------
Subject_ID and activity represent the ID# of the study participant and the activity for which the measurements were taken.

The remainder of the columns follow the naming scheme of the original dataset (outlined below).  The values in HAR_tidy.txt are
means of all the observations for a particular subject & activity indicated by capital MEAN prefix.  The individual observations 
in the raw data themselves represent a series of measurements over time and their statistical properties appear in the raw data from 
which we only extract mean & standard deviation.

An example is helpful:
* A single observation in the raw data might represent a subject walking for 5 minutes.  Each of many different motion parameters are measured 
50X per second over this 5 minutes.  The mean, max, standard deviation & other statistical parameters of this 5 minute walk (50*60*5 = 15000 measurements) 
are calculated for each 
motion parameter and appear in raw data. The subject will then do several more walks and the measurements for each will appear as a separate 
observation (row) in the raw data.   In step 2 I extract only the mean and standard deviation measurements to our dataset, but each row still 
just represents 1 observation (1 walk).  In step 5, I calculate the mean over all the sessions of walking for a subject and get the overall 
walking average.


Raw data:
-------------------------

Here is the author's discussion and explanation of the data and variable names:
Note: characters "-", "(" and ")" have been replaced by "." in this dataset. 


The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

Additional notes:
----------------------------


