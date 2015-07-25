complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  idColumn <- id
  nobsColumn <- numeric(length(id))
  j <- 1 # sentinel value indicating items in id, nobs
  for (i in id) 
  {
    if (i>0 & i<10) 
    {
      new_i <- paste("00", i, sep = "")
    }
    else if (i >= 10 & i<100)
    {
      new_i <- paste("0", i, sep = "")
    }
    else
      new_i <- i
    
    name_of_file <- paste(directory, "/", new_i, ".csv",sep = "")
    current_file <- read.csv(name_of_file)
    #Return true only when an entire row is not NA
    good <- complete.cases(current_file)
    data_interested <- current_file[good, ]
    nobsColumn[j] <- nrow(data_interested)
    j <- j+1
  }
  
  end_result <- data.frame(idColumn, nobsColumn)
  colnames(end_result) <- c("id", "nobs")
  end_result
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
}