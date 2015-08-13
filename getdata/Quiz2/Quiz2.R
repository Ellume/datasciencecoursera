#Question 1
#Register an application with the Github API here https://github.com/settings/applications. Access the API to get information on your instructors repositories (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). Use this data to find the time that the datasharing repo was created. What time was it created? This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). You may also need to run the code in the base R package and not R studio.
#2013-08-28T18:18:50Z
#2013-11-07T13:25:07Z
#2012-06-20T18:39:06Z
#2014-02-06T16:13:11Z

#Answer 1

library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "55aef596e1a087853360",
                   secret = "86dfb46204abf225b0747838ea34ac02111cd534")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content(req)

# OR:
req <- with_config(gtoken, GET("https://api.github.com/rate_limit"))
stop_for_status(req)
content(req)

gitinfo<-jsonlite::fromJSON(toJSON(content(req)))

## 2013-11-07T13:25:07Z



#Question 2
#The sqldf package allows for execution of SQL commands on R data frames. We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL. Download the American Community Survey data and load it into an R object called
#acs


#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 

#Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?
#sqldf("select * from acs")
#sqldf("select * from acs where AGEP < 50 and pwgtp1")
#sqldf("select * from acs where AGEP < 50")
#sqldf("select pwgtp1 from acs where AGEP < 50")

#Answer2

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv",destfile="./Quiz2/survey.csv")
acs<- read.table("./Quiz2/survey.csv",header=T,sep=",")

#sqldf("select pwgtp1 from acs where AGEP < 50")


#Question 3
#Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)
#sqldf("select unique AGEP from acs")
#sqldf("select distinct AGEP from acs")
#sqldf("select distinct pwgtp1 from acs")
#sqldf("select AGEP where unique from acs")

#Asnwer3
#sqldf("select distinct AGEP from acs")

#Question 4
#How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page: 
  
#  http://biostat.jhsph.edu/~jleek/contact.html 

#(Hint: the nchar() function in R may be helpful)
#43 99 8 6
#43 99 7 25
#45 31 7 25
#45 31 7 31
#45 92 7 2
#45 31 2 25
#45 0 2 2


#Answer4
con<- url("http://biostat.jhsph.edu/~jleek/contact.html")
htmlLines<-readLines(con)
close(con)
nchar(htmlLines[[10]])
#45
nchar(htmlLines[[20]])
#31
nchar(htmlLines[[30]])
#7
nchar(htmlLines[[100]])
#25

#Question 5
#Read this data set into R and report the sum of the numbers in the fourth of the nine columns. 

#https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for 

#Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for 

#(Hint this is a fixed width file format)
#36.5
#28893.3
#32426.7
#222243.1
#101.83
#35824.9

#Answer5
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for",destfile="./Quiz2/getdata-wksst8110.for",mode="wb")
x <- read.fwf(
  file="./Quiz2/getdata-wksst8110.for",
  skip=4,
  widths=c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4))
sum(x[[4]])
#[1] 32426.7