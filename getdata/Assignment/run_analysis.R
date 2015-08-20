###########################################
##                                       ##
## Coursera Data Science: Get/Clean Data ##
##                                       ##
##       Assignement: Clean Data         ##
##                                       ##
###########################################
##                                       ##
##          Created By Ellume            ##
##           August 19, 2015             ##
##                                       ##
###########################################


# Change working directory
setwd("C:/Users/Ellume/Git/datasciencecoursera/getdata/Assignment")

# Install required dplyr package
install.packages("dplyr")
library(dplyr)


# Read in data for test subjects
test.subject = read.table("./UCI HAR Dataset/test/subject_test.txt")
test.count=nrow(test.subject)

# Read in and calculate Mean and Standard Deviation for test subjects
test.measure = read.table("./UCI HAR Dataset/test/X_test.txt")
test.measure.mean=apply(test.measure,1,mean)
test.measure.sd=apply(test.measure,1,sd)

# Transform activity data into a readable format
test.activity = read.table("./UCI HAR Dataset/test/Y_test.txt")
test.activity.readable = test.activity
test.activity.readable[test.activity.readable==1]="Walking"
test.activity.readable[test.activity.readable==2]="Walking.Upstairs"
test.activity.readable[test.activity.readable==3]="Walking.Downstairs"
test.activity.readable[test.activity.readable==4]="Sitting"
test.activity.readable[test.activity.readable==5]="Standing"
test.activity.readable[test.activity.readable==6]="Laying"

# create table for test subjects
test=data.frame(Subject=test.subject[[1]],
               Data.Set=rep("Test",times=test.count),
               Activity=test.activity.readable[[1]],
               Measure.Mean=test.measure.mean,
               Measure.SD=test.measure.sd)

#######

# Read in data for train subjects
train.subject = read.table("./UCI HAR Dataset/train/subject_train.txt")
train.count=nrow(train.subject)

# Read in and calculate Mean and Standard Deviation for train subjects
train.measure = read.table("./UCI HAR Dataset/train/X_train.txt")
train.measure.mean=apply(train.measure,1,mean)
train.measure.sd=apply(train.measure,1,sd)

# Transform activity data into a readable format
train.activity = read.table("./UCI HAR Dataset/train/Y_train.txt")
train.activity.readable = train.activity
train.activity.readable[train.activity.readable==1]="Walking"
train.activity.readable[train.activity.readable==2]="Walking.Upstairs"
train.activity.readable[train.activity.readable==3]="Walking.Downstairs"
train.activity.readable[train.activity.readable==4]="Sitting"
train.activity.readable[train.activity.readable==5]="Standing"
train.activity.readable[train.activity.readable==6]="Laying"

# create table for train subjects
train=data.frame(Subject=train.subject[[1]],
               Data.Set=rep("Train",times=train.count),
               Activity=train.activity.readable[[1]],
               Measure.Mean=train.measure.mean,
               Measure.SD=train.measure.sd)

########

# Combine the test and train tables into completed data set
cleaned.data=rbind(test,train)

# Create a tidy summary table
grouped.data=group_by(cleaned.data,Subject,Activity)
tidy.summary.data=summarise(grouped.data,Mean=mean(Measure.Mean),SD=mean(Measure.SD))

# Write the table to txt file
write.table(tidy.summary.data, "./tidy.summary.data.txt", row.names=F)