corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
  ############################################################
  ############################################################
  
  # List all files in the directory
  files <- list.files(directory)
  
  # Get list of complete cases
  nobs <- complete(directory)
  
  # 
  output <- numeric()
  for (i in 1:nrow(nobs)) {
    if (threshold<=nobs[[i,2]]) {
      fulltbl <- na.omit(read.csv(paste(directory,"/",files[[nobs[[i,1]]]],sep="")))
      output <- c(output,cor(fulltbl$sulfate,fulltbl$nitrate))
    }
  }
  output
}