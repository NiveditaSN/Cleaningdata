#Getting and Cleaning Data Project

##Input

Download from the location https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and extract to working directory.

##Variables

feature<- read features.txt and stored in the variable
activity<-read activity_labels.txt and stored in the variable
subject <-read subject_train.txt and stored in the variable
x_train <- read X_train.txt and stored in the variable
y_train<- read y_train.txt and stored in the variable
subject_test <-read subject_test.txt and stored in the variable
x_test       <-read X_test.txt and stored in the variable 
y_test <-read Y_test.txt and stored in the variable
mergedata <- Used to merge the test and train data 
colNames <- Used to rename the columns to more meaningful names
finalData <- Holds the final result after taking mean values

##Functions 

rbind <- To merge train and test data row wise
cbind <- To merge columns
aggregate <- To find mean value 

##Result

Result is written to tidydata.txt file

