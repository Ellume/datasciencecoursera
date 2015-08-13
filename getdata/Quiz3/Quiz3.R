# Question 1
# The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv 
# 
# and load the data into R. The code book, describing the variable names is here: 
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
# 
# Create a logical vector that identifies the households on greater than 10 acres(ACR=3) who sold more than $10,000 worth of agriculture products (AGS=6). Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE. which(agricultureLogical) What are the first 3 values that result?
# 25, 36, 45
# 236, 238, 262
# 59, 460, 474
# 125, 238,262

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv",".\\Quiz3\\ss06pid.csv")
DT<-read.table(".\\Quiz3\\ss06pid.csv", sep=",",header=TRUE)

agricultureLogical<-with(DT, ACR==3 & AGS==6)
which(agricultureLogical)
# 125, 238,262



# Question 2
# Using the jpeg package read in the following picture of your instructor into R 
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg 
# 
# Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? (some Linux systems may produce an answer 638 different for the 30th quantile)
# -15259150 -10575416
# -14191406 -10904118
# -15259150 -594524
# -10904118 -10575416

install.packages("jpeg")
library(jpeg)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", destfile=".\\Quiz3\\jeff.jpeg",mode="wb")
jeff<-readJPEG(".\\Quiz3\\jeff.jpeg",native=T)
quantile(jeff, probs=c(.3,.8))
#     30%       80% 
#  -15259150 -10575416




# Question 3
# Load the Gross Domestic Product data for the 190 ranked countries in this data set: 
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# 
# Load the educational data from this data set: 
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv 
# 
# Match the data based on the country shortcode. How many of the IDs match? Sort the data 
# frame in descending order by GDP rank (so United States is last). What is the 13th country
# in the resulting data frame? 
# 
# Original data sources: 
#   http://data.worldbank.org/data-catalog/GDP-ranking-table 
# http://data.worldbank.org/data-catalog/ed-stats
# 189 matches, 13th country is Spain
# 234 matches, 13th country is Spain
# 234 matches, 13th country is St. Kitts and Nevis
# 190 matches, 13th country is St. Kitts and Nevis
# 190 matches, 13th country is Spain
# 189 matches, 13th country is St. Kitts and Nevis
install.packages("dplyr")
library(dplyr)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile=".\\Quiz3\\FGDP.csv")
GDP<-read.csv(".\\Quiz3\\FGDP.csv",skip=5,blank.lines.skip = TRUE,nrows=190,header=F,col.names=c("CountryCode","Ranking","X","Country","USD","X.1","X.2","X.3","X.4","X.9"))
GDP<-GDP[,c(1,2,4,5)]
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile=".\\Quiz3\\FEDSTATS_Country.csv")
EDU<-read.csv(".\\Quiz3\\FEDSTATS_Country.csv")
DT<-merge(GDP,EDU,by.x="CountryCode",by.y="CountryCode")
#DT$Ranking<-as.numeric(DT$Ranking)
DT2<-arrange(DT,desc(Ranking))
# 189 matches, 13th country is St. Kitts and Nevis





# Question 4
# What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
# 23, 45
# 30, 37
# 32.96667, 91.91304
# 133.72973, 32.96667
# 23, 30
# 23.966667, 30.91304










# Question 5
# Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries are Lower middle income but among the 38 nations with highest GDP?
# 3
# 13
# 12
# 5