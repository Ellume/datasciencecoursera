best <- function(state, outcome) {
  ## Read outcome data
  ## Check that state and outcome are valid
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
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
    measures <- measures[order(measures[,2]),]
    measures <- measures[measures[,11]==min(measures[,11]),2][1]
  } else if (outcome=="heart failure") {
    measures[, 17] <- as.numeric(measures[, 17])
    measures <- measures[complete.cases(measures[,17]),]
    measures <- measures[order(measures[,2]),]
    measures[measures[,17]==min(measures[,17]),2][1]
  } else if (outcome=="pneumonia") {
    measures[, 23] <- as.numeric(measures[, 23])
    measures <- measures[complete.cases(measures[,23]),]
    measures <- measures[order(measures[,2]),]
    measures <- measures[measures[,23]==min(measures[,23]),2][1]
  }
  

}
