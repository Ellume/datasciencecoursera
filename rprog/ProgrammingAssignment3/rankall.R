rankall <- function(outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  
  measures <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # Check outcome
  chk_outcome <- c("heart attack", "heart failure", "pneumonia")
  if (!(outcome %in% chk_outcome)) { stop("invalid outcome") }
  
  #clean data by outcome
  if (outcome=="heart attack") {
    measures[, 11] <- as.numeric(measures[, 11])
    measures <- measures[complete.cases(measures[,11]),]
    measures <- measures[order(measures[,11],measures[,2]),]
  } else if (outcome=="heart failure") {
    measures[, 17] <- as.numeric(measures[, 17])
    measures <- measures[complete.cases(measures[,17]),]
    measures <- measures[order(measures[,17],measures[,2]),]
  } else if (outcome=="pneumonia") {
    measures[, 23] <- as.numeric(measures[, 23])
    measures <- measures[complete.cases(measures[,23]),]
    measures <- measures[order(measures[,23],measures[,2]),]
  }
  
  s.measures<-split(measures, measures[,7])
  
  result<- data.frame(Hospital.Name=as.character(),State=as.character())
  for (i in 1:length(s.measures)) {
    if (num == "best") {
      result<-rbind(result,s.measures[[i]][1,c(2,7)])
    } else if (num == "worst") {
      result<-rbind(result,s.measures[[i]][nrow(s.measures[[i]]),c(2,7)])
    } else if (is.null(s.measures[[i]]) | num>nrow(s.measures[[i]])) {
      result<-rbind(result,data.frame(Hospital.Name=NA,State=s.measures[[i]][nrow(s.measures[[i]]),7]))
    } else {
      result<-rbind(result,s.measures[[i]][num,c(2,7)])
    }
  }
  names(result)<-c("hospital","state")
  row.names(result)<-names(s.measures)
  result
  
}