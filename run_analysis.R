######                                                ###########
###### Getting and Cleaning Data Class- Course Project###########
######                   **05-24-2014**               ###########

#read in relevant files
x.test<-read.table("UCI HAR Dataset/test/X_test.txt")#activity variables
y.test<-read.table("UCI HAR Dataset/test/Y_test.txt")#activity labels
subject.test<-read.table("UCI HAR Dataset/test/subject_test.txt")#subect monitored

x.train<-read.table("UCI HAR Dataset/train/X_train.txt")
y.train<-read.table("UCI HAR Dataset/train/Y_train.txt")
subject.train<-read.table("UCI HAR Dataset/train/subject_train.txt")

activity.labels<-subject.test<-read.table("UCI HAR Dataset/activity_labels.txt")#subect monitored

#***1) Merges the training and the test sets to create one data set.

#bind and combine! ;)
test.df<-cbind(subject.test,y.test,x.test)
train.df<-cbind(subject.train,y.train,x.train)

merge.df<-rbind(test.df,train.df)

act.names<-read.table("UCI HAR Dataset/features.txt")

names(merge.df)[3:563]<-paste(act.names[,2])
names(merge.df)[1:2]<-c("subject","activity")


#***2) Extracts only the measurements on the mean and standard deviation for each measurement.

#subset for variables that contain key terms
terms<-c("subject|activity|mean|std")

merge.df<-merge.df[,grep(terms, names(merge.df))]


#***3) Uses descriptive activity names to name the activities in the data set

##better disc   ribe activity 
merge.df$activity[merge.df$activity==1]<-"Walking"
merge.df$activity[merge.df$activity==2]<-"Walking Upstairs"
merge.df$activity[merge.df$activity==3]<-"Walking Downstairs"
merge.df$activity[merge.df$activity==4]<-"Sitting"
merge.df$activity[merge.df$activity==5]<-"Standing"
merge.df$activity[merge.df$activity==6]<-"Laying"


#***4) Appropriately labels the data set with descriptive activity names.

## modify descriptive activity names for more appropriate labeling
t.r<-c("\\)|-|\\(")
names(merge.df)<-gsub(t.r,"",names(merge.df))
names(merge.df)<-tolower(names(merge.df))

#tidy up workspace ;)

remove(list=ls()[!(ls() %in% c("merge.df"))])


#***5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##melt merge.df and compute pair-wise means for id variables "subject" and "activity"
melt<-melt(merge.df,id=c("subject","activity"))

avg.df<-dcast(melt,subject + activity ~ variable, fun.aggregate=mean)

#write tidy dataset
write.table(avg.df,"Averages for Subjects and Activities.txt", sep="\t")


    