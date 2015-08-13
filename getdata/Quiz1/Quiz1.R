#Question 1
#The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
#  
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
#
#and load the data into R. The code book, describing the variable names is here: 
#  
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
#
#How many properties are worth $1,000,000 or more?

#Answer 1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", destfile=".\\Quiz1\\USA_Community_Survey.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf", destfile=".\\Quiz1\\USA_Community_Survey_Codebook.pdf")

USA_Com<-read.table(".\\Quiz1\\USA_Community_Survey.csv",sep=",",header=TRUE)

sum(complete.cases(USA_Com[USA_Com$VAL==24,"VAL"]))


#Question 2
#Use the data you loaded from Question 1. Consider the variable FES in the code book. Which of the "tidy data" principles does this variable violate?

#Tidy data has variable values that are internally consistent.
#Tidy data has one variable per column.
#Tidy data has one observation per row.
#Each tidy data table contains information about only one type of observation.

#Answer 2
# Tidy data has one variable per column.


#Question 3
#Download the Excel spreadsheet on Natural Gas Aquisition Program here: 
#  
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx 
#
#Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:
#  dat 
#What is the value of:
#  sum(dat$Zip*dat$Ext,na.rm=T) 
#(original data source: http://catalog.data.gov/dataset/natural-gas-acquisition-program)
#36534720
#338924
#154339
#33544718

#Answer 3
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx",".\\Quiz1\\gov_NGAP.xlsx", mode="wb")
library(xlsx)
dat<-read.xlsx(".\\Quiz1\\gov_NGAP.xlsx", sheetIndex=1,header=TRUE,startRow = 18,endRow = 23,colIndex = c(7:15))
#36534720

#Question 4
#Read the XML data on Baltimore restaurants from here: 
#  
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml 
#
#How many restaurants have zipcode 21231?
#127
#156
#130
#28



#Answer 4
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml",".\\Quiz1\\restraurants.xml")
temp<-xmlTreeParse(".\\Quiz1\\restraurants.xml",useInternalNodes = TRUE)
xpathSApply(temp,"//zipcode",xmlValue)
sum(tmp2==21231)
#127



#Question 5
#The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
#  
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 
#
#using the fread() command load the data into an R object
#DT 
#Which of the following is the fastest way to calculate the average value of the variable
#pwgtp15 
#broken down by sex using the data.table package?
#
#DT[,mean(pwgtp15),by=SEX]
#rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]
#tapply(DT$pwgtp15,DT$SEX,mean)
#mean(DT$pwgtp15,by=DT$SEX)
#sapply(split(DT$pwgtp15,DT$SEX),mean)
#mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)


#Answer 5
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",".\\Quiz1\\ss06pid.xml")
DT<-fread(".\\Quiz1\\ss06pid.xml", sep=",",header=TRUE)



