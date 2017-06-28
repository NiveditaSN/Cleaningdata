 
# Variables

feature,activity,subject,x_train,y_train,subject_test,x_test,y_test - To read respective files

mergedata - To merge train and test data

# Functions used for getting and cleaning data

Identify columns with mean and standard deviation values 
---------------------------------------------------------
mergedata[, ( grep("mean" , colnames(mergedata),perl=  TRUE) ) ], mergedata[, ( grep("std" , colnames(mergedata),perl=  TRUE) ) ]

Average for each activity 
--------------------------
aggregate(mergedata[,names(mergedata) != 'activityId' & names(mergedata) != 'subjectId'],by=list(activityId=mergedata$activityId,subjectId = mergedata$subjectId),mean)

Loop through column names and Change column names to be more menaingful
------------------------------------------------------------------------
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

