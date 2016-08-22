## assumes zip file is saved under working directory
unzip("getdata-projectfiles-UCI HAR Dataset.zip")

## test data:
XTest<- read.table("UCI HAR Dataset/test/X_test.txt")
YTest<- read.table("UCI HAR Dataset/test/Y_test.txt")
SubjectTest <-read.table("UCI HAR Dataset/test/subject_test.txt")

## train data:
XTrain<- read.table("UCI HAR Dataset/train/X_train.txt")
YTrain<- read.table("UCI HAR Dataset/train/Y_train.txt")
SubjectTrain <-read.table("UCI HAR Dataset/train/subject_train.txt")

## features and activity
features<-read.table("UCI HAR Dataset/features.txt")
activity<-read.table("UCI HAR Dataset/activity_labels.txt")

##Part1
X<-rbind(XTest, XTrain)
Y<-rbind(YTest, YTrain)
Subject<-rbind(SubjectTest, SubjectTrain)

##Part2
index<-grep("mean\\(\\)|std\\(\\)", features[,2])
length(index)
X<-X[,index]

##Part3
Y[,1]<-activity[Y[,1],2]

##Part4
names<-features[index,2]

names(X)<-names
names(Subject)<-"SubjectID"
names(Y)<-"Activity"

CleanedData<-cbind(Subject, Y, X)


##Part5
install.packages("data.table")
library(data.table)

CleanedData<-data.table(CleanedData)
TidyData <- CleanedData[, lapply(.SD, mean), by = 'SubjectID,Activity']
write.table(TidyData, file = "Tidy.txt", row.names = FALSE)