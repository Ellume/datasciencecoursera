rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with the given rank
  ## 30-day death rate
  
  
  
  measures <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # Check state
  if (!(state %in% measures[,7])) { stop("invalid state") }
  
  # Check outcome
  chk_outcome <- c("heart attack", "heart failure", "pneumonia")
  if (!(outcome %in% chk_outcome)) { stop("invalid outcome") }
  
  measures <- measures[measures[,7]==state,]
  
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
  
  
  if (num == "best") {
    measures[1,2]
  } else if (num == "worst") {
    measures[nrow(measures),2]
  } else if (is.null(measures) | num>nrow(measures)) {
    return(NA)
  } else {
    measures[num,2]
  }
}