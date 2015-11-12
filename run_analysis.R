
library(data.table)
library(plyr)     
library(dplyr)

#################################################
## Download and unzip data listed in the Project specification:
################################################# 
##     This script assumes data is already downloaded and unzipped to R's current 
##          working directory in a sub-directory "UCI HAR Datset/" 
##     If data have not been downloaded & unzipped into the appropriate structure, 
##          uncomment & execute the following lines:
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
#              "UCI_HAR_dataset.zip")
#unzip("UCI_HAR_dataset.zip")



#################################################
## Read data files into R.  Includes step 4.
################################################# 
## 
##     Note:  I incorporate step 4 (labeling variables) into the read of the 
##            files.  see codebook.md for discussion. 
##
##      First read the variable names, and assign names during read.  

features <- read.table("UCI HAR Dataset/features.txt", header=FALSE)
features <- as.vector(features$V2)

x_test        <- read.table("UCI HAR Dataset/test/X_test.txt",    
                            header=FALSE, col.names = features)
y_test        <- read.table("UCI HAR Dataset/test/y_test.txt",    
                            header=FALSE, col.names = "Activity", colClasses = "factor")
x_train       <- read.table("UCI HAR Dataset/train/X_train.txt", 
                            header=FALSE, col.names = features)
y_train       <- read.table("UCI HAR Dataset/train/y_train.txt", 
                            header=FALSE, col.names = "Activity", colClasses = "factor")
subject_test  <- read.table("UCI HAR Dataset/test/subject_test.txt",    
                            header=FALSE, col.names="Subject_ID")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", 
                            header=FALSE, col.names="Subject_ID")

## Convert dataframes to tbl_df for speed & convenience
x_test        <- tbl_df(x_test)
y_test        <- tbl_df(y_test)
x_train       <- tbl_df(x_train)
y_train       <- tbl_df(y_train)
subject_test  <- tbl_df(subject_test)
subject_train <- tbl_df(subject_train)

################
################


#################################################
## Step 1:
#################################################  
#       Combine Subject & activity with measured data for test & train sets.
#       Then combine test & train sets to form 1 dataset:
#
#       First attach subject ID's and activity labels to measured data:

test  <- cbind(subject_test,  y_test,  x_test)
train <- cbind(subject_train, y_train, x_train)

#       Now stack rows from test & train into 1 dataset

HAR <- rbind(test,train)

#################################################
## Step 2:
#################################################
#       Extract only mean and std_dev measurements:  ".mean" in regex eliminates
#       the angle measurements which aren't really means.  See codebook.md for more 
#       discussion.

HAR_mn_std <- select (HAR, Subject_ID, Activity, contains(".mean"), contains("std"))



#################################################
## Step 3:
#################################################
#       Use descriptive activity names to name the activities in the data set

HAR_mn_std$Activity <- revalue(HAR_mn_std$Activity, 
                                        c("1"= "walking", 
                                          "2"= "walking_upstairs",
                                          "3"= "walking_downstairs",
                                          "4"= "sitting", 
                                          "5"= "standing", 
                                          "6"= "laying"))

#################################################
## Step 4:
#################################################
##      Appropriately label the data set with descriptive variable names.
##
##      As mentioned above, I incorporate the naming of the variables (columns)
##      into the reading of the files into R, prior to step 1.  
##
##      see codebook.md for further discussion.  
##      


#################################################
## Step 5:
#################################################
##      From the data set in step 4, creates a second, independent tidy data set 
##      with the average of each variable for each activity and each subject.
##

HAR_tidy <-
    HAR_mn_std %>%
        group_by(Subject_ID, Activity) %>%
        summarise_each(funs(mean), -Subject_ID, -Activity) %>%
        arrange(Subject_ID, desc(Activity))

names(HAR_tidy[3:81]) <- paste("MEAN", names(HAR_tidy[3:81]))

write.table(HAR_tidy, file="HAR_tidy.txt", row.names = FALSE)


##  To read this data fiule back into an R dataframe, uncomment & execute:
# HAR_tidy <- read.table("HAR_tidy.txt", 
#                        header = TRUE, stringsAsFactors=TRUE)
