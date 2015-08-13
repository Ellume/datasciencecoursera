complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  ############################################################
  ############################################################
  
  # List all files in the directory
  files <- list.files(directory)
  
  
  # Read in each file and calculate the number of complete rows
  # then add it to the output dataframe
  for (i in id) {
    nobs <- nrow(na.omit(read.csv(paste(directory,"/",files[[i]],sep=""))))
    if (i==id[[1]]) {
      output <- data.frame(id=i,nobs=nobs)
    } else {
      output <- rbind(output,data.frame(id=i,nobs=nobs))
    }
  }
  output
}