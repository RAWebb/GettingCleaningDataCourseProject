# Codebook


####Course Project for "Getting and Cleaning Data"
Part of the Data Science Specialization offered by Johns-Hopkins Univ  hosted by Coursera.org.
==========================================

##R.A. Webb
November 2015
-----------------


### Description:
This project is intended to demonstrate some basic data cleaning skills and show the process for 
generating a tidy set.

Instructions copied from course pages:

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



Description of the variables:
============================

## Abbreviations used in raw & tidy variable names.  These follow the naming scheme from original data, but description has been expanded here:
Note: characters "-", "(" and ")" in the authors labels have been replaced by "." in this dataset.
* Before first "." 
  * leading t or f  for time or frequency (Fourier) domain.
  * Body or Gravity.  Whether quantity is measuring motion/acceleration of the body or due to gravity
  * Acc or Gyro.  Data as measured by accelerometer  or gyroscope sensor.
  * Jerk.  Measuring change in acceleration.
  * Mag.  Magnitude of signal independent of spatial direction. Combines XYZ signals.
  * Angle.  Angle between 2 vectors, not used in this project.
* After first ".", statistical and computed physical quantities:
  * mean, std, meanFreq.   mean, standard deviation and mean frequency of signals in Fourier domain, repsectively.  These are used in the project.
  * max, min, mad, sma, energy, arCoeff, correlation, igr, entropy, skewness, kurtosis, maxInds, bandsEnergy:  Other statistical and derived physical quantities not used in this project.
* After "..."
  * X, Y, Z.  Spatial dimensions for measurements (direction).
  * Numbers.  Coefficients and bands.  Not used in this project.

  
## Units of measurements:
* Authors state that the units for measurements in the inertial signals datasets  are in g's for accelerations  and 
radians / sec for angular velocities.  Presumably these carry over to the other datasets.  Also presumably, the Jerk measurements 
are derivatives done in the same units so g/sec and radians/s^2.


Variables in tidy dataset:  HAR_tidy.txt
-----------------------
Subject_ID and activity represent the ID# of the study participant and the activity for which the measurements were taken.

The remainder of the columns follow the naming scheme of the original dataset (outlined above).  The values in HAR_tidy.txt are
means of all the observations for a particular subject & activity indicated by capital MEAN prefix (see example below). 

An example to break down the difference between raw & tidy data is helpful, as we "mean" in the raw and "mean of a mean" in tidy:
* A single observation in the raw data might represent a subject walking for 5 minutes.  Each of many different motion parameters are measured 50X per second over this 5 minutes.  The mean, max, standard deviation & other statistical parameters of this 5 minute walk (50*60*5 = 15000 measurements)are calculated for each motion parameter and appear in raw data. The subject will then do several more walks and the measurements for each will appear as a separate observation (row) in the raw data.   In step 2 I extract only the mean and standard deviation measurements to our dataset, but each row still just represents 1 observation (1 walk).  In step 5, I calculate the mean over all the sessions of walking for a subject and get the overall walking average.


Raw data:
-------------------------

Details of the original study are not the purpose the present project, hence not reproduced here.  The author's discussion of the study and explanation of the data and variable names can be found in the README.txt in downloaded data, or copied to `README_Reyes-Ortiz.txt' in this repo.


