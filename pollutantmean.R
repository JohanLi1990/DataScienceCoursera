pollutantmean <- function(directory, pollutant, id = 1:332)
{
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  ## NOTE: Do not round the result!
  
  
  #declare a new vector. 
  sum_of_all_value <- 0
  number_of_all_values <- 0
  
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
    #single out the pollutant file, and remove NA values
    data_interested <- current_file[, pollutant]
    bad <- is.na(data_interested)
    data_interested <- data_interested[!bad]
    sum_of_all_value <- sum_of_all_value + sum(data_interested, na.rm = TRUE)
    number_of_all_values <- length(data_interested) + number_of_all_values
    

  }
  mean <- sum_of_all_value/number_of_all_values
  mean

  
}