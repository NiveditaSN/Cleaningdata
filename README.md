# Cleaningdata
# Clear the memory
-----------------
rm(list=ls())

# Read the files
---------------
feature<- read.table('./features.txt',header=FALSE)
activity<-read.table('./activity_labels.txt',header=FALSE)
subject <-read.table('./train/subject_train.txt',header=FALSE)
x_train <- read.table('./train/X_train.txt',header=FALSE)
y_train<- read.table('./train/y_train.txt',header=FALSE)
subject_test <-read.table('./test/subject_test.txt',header=FALSE)
x_test       <-read.table('./test/X_test.txt',header=FALSE) 
y_test       <- read.table('./test/y_test.txt',header=FALSE)
# Assign column names
----------------------

colnames(activity)  <-c('activityId','activityType')
colnames(subject)  <-"subjectId"
colnames(x_train) <-feature[,2] 
colnames(y_train) <- "activityId"
train_data<-cbind(y_train,subject,x_train)
colnames(subject_test) <- "subjectId"
colnames(x_test)       <- feature[,2] 
colnames(y_test)       <- "activityId"
test_data <- cbind(y_test,subject_test,x_test)

# Merge train and test data
---------------------------
mergedata <- rbind(train_data,test_data)

mergedata <- cbind(mergedata[,"subjectId"],mergedata[,"activityId"],mergedata[, ( grep("mean" , colnames(mergedata),perl=  TRUE) ) ], mergedata[, ( grep("std" , colnames(mergedata),perl=  TRUE) ) ])

names(mergedata)[1]<-"subjectId"
names(mergedata)[2]<-"activityId"

colNames <- colnames(mergedata)

for (i in 1:length(colNames)) 
  
{
  
  colNames[i] = gsub("\\()","",colNames[i])
  
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  
  colNames[i] = gsub("-mean","Mean",colNames[i])
  
  colNames[i] = gsub("^(t)","time",colNames[i])
  
  colNames[i] = gsub("^(f)","freq",colNames[i])
  
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
  
};
colnames(mergedata)<- colNames

# Find aggregates
------------------
mergedata <- aggregate(mergedata[,names(mergedata) != 'activityId' & names(mergedata) != 'subjectId'],by=list(activityId=mergedata$activityId,subjectId = mergedata$subjectId),mean)
finalData<- merge(x= mergedata, y= activity,by="activityId" , all.x=TRUE)
# Write results to tidydata.txt
-------------------------------
write.table(finalData, './tidydata.txt',row.name=FALSE,sep='\t')
