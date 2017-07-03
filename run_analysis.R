#Clear the memory
rm(list=ls())

#Read the files

feature<- read.table('./features.txt',header=FALSE)
activity<-read.table('./activity_labels.txt',header=FALSE)
subject <-read.table('./train/subject_train.txt',header=FALSE)
x_train <- read.table('./train/x_train.txt',header=FALSE)
y_train<- read.table('./train/y_train.txt',header=FALSE)
subject_test <-read.table('./test/subject_test.txt',header=FALSE)
x_test       <-read.table('./test/X_test.txt',header=FALSE) 
y_test       <- read.table('./test/y_test.txt',header=FALSE)

#Assign column names
colnames(activity)  <-c('activityId','activityType')
colnames(subject)  <-"subjectId"
colnames(x_train) <-feature[,2] 
colnames(y_train) <- "activityId"
train_data<-cbind(y_train,subject,x_train)
colnames(subject_test) <- "subjectId"
colnames(x_test)       <- feature[,2] 
colnames(y_test)       <- "activityId"
test_data <- cbind(y_test,subject_test,x_test)

#Merge training and test data
mergedata <- rbind(train_data,test_data)

mergedata <- cbind(mergedata[,"subjectId"],mergedata[,"activityId"],mergedata[, ( grep("mean" , colnames(mergedata),perl=  TRUE) ) ], mergedata[, ( grep("std" , colnames(mergedata),perl=  TRUE) ) ])

names(mergedata)[1]<-"SubjectId"
names(mergedata)[2]<-"activityId"
mergedata<- merge(x= mergedata, y= activity,by="activityId" , all.x=TRUE)

#Rename Columns
colNames <- colnames(mergedata)

for (i in 1:length(colNames)) 
  
{
  
  colNames[i] = gsub("\\()","",colNames[i])
  
  colNames[i]<- gsub("activityType","Activity",colNames[i])
  colNames[i] = gsub("std","StdDev",colNames[i])
  
  colNames[i] = gsub("mean","Mean",colNames[i])
  
  colNames[i] <- gsub("-","",colNames[i])
  
  colNames[i] <- gsub("([Gg]ravity)","Gravity",colNames[i])
  
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  
  colNames[i] = gsub("Acc","Acceleration",colNames[i])
  
  colNames[i] = gsub("Freq","Frequency",colNames[i])
  
};
colnames(mergedata)<- colNames

# Find aggregates
mergedata <- aggregate(mergedata[,names(mergedata) != 'Activity' & names(mergedata) != 'activityId' & names(mergedata) != 'SubjectId'],by=list(Activity=mergedata$Activity,SubjectId = mergedata$SubjectId),mean)

#Rearrange columns
finalData <- cbind(mergedata[,grep("SubjectId" , colnames(mergedata),perl=  TRUE )], mergedata[,grep("Activity" , colnames(mergedata),perl=  TRUE)  ],mergedata[, ( grep("Mean" , colnames(mergedata),perl=  TRUE) ) ], mergedata[, ( grep("Std" , colnames(mergedata),perl=  TRUE) ) ])
names(finalData)[1]<-"Subject"
names(finalData)[2]<-"Activity"

#Write results to tidydata.txt
write.table(finalData, './tidydata.txt',row.name=FALSE,sep='\t')



               
