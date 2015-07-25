corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  all_csv_files <- list.files("specdata", "*.csv", full.names = TRUE)
  Number_Of_Csv <- length(all_csv_files)
  correlationVector <- numeric(Number_Of_Csv)
  j = 1
  for (i in 1:Number_Of_Csv)
  {
    name_of_file <- all_csv_files[i]
    current_file <- read.csv(name_of_file)
    good <- complete.cases(current_file)
    data_interested <- current_file[good, ]
    number_of_Complete_Row <- nrow(data_interested)
    if (number_of_Complete_Row >= threshold) 
    {
      correlationVector[j] <- cor(data_interested[, "sulfate"], data_interested[, "nitrate"])
      j <- j +1
      
    }
    
    
  }
  badone <- is.na(correlationVector)
  End_result <- correlationVector[!badone]
  End_result <- correlationVector[correlationVector != 0]

  End_result

  
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
}