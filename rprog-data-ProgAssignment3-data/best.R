best <- function(state, outcome) 
{
  #Read the source of the outcome care
  outcome_of_care <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state and outcome are valid
  valid_state <- unique(outcome_of_care[,7])
  valid_outcome <- c("heart attack", "heart failure",  "pneumonia")
  if (!state %in% valid_state) 
  {
    stop("Invalid State!")
    
  }
  else if(!outcome %in% valid_outcome)
  {
    stop("invalid outcome!")
  }
  
  
  ## Read outcome data
  
  ## 1st I subset the original database according to states selected by user.
  Hospital_In_the_States <- subset(outcome_of_care, outcome_of_care$State == state)
  
  ## 2ndly, I sort the data according to 
  names_of_columns <- c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack",
                                   "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure",
                                   "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
  if (outcome == valid_outcome[1] ) 
  {
    #if we are interested in heart-attack mortality rate, we sort it according to the column
    Hospital_In_the_States<- Hospital_In_the_States[!Hospital_In_the_States$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack
                                                    == "Not Available", ]
    Data_Hospital_Interested <- 
      Hospital_In_the_States[order(as.numeric(Hospital_In_the_States$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)), ]
    Resulting_DF <- Data_Hospital_Interested[, c("Hospital.Name",names_of_columns[1])]

  }
  else if(outcome == valid_outcome[2])
  {
    Hospital_In_the_States <- Hospital_In_the_States[!Hospital_In_the_States$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure
                                                     == "Not Available", ]
    Data_Hospital_Interested <- 
      Hospital_In_the_States[order(as.numeric(Hospital_In_the_States$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)), ]
    Resulting_DF <- Data_Hospital_Interested[, c("Hospital.Name",names_of_columns[2])]
    
  }
  else
  {
    Hospital_In_the_States <- Hospital_In_the_States[!Hospital_In_the_States$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia
                                                     == "Not Available", ]
    Data_Hospital_Interested <- 
      Hospital_In_the_States[order(as.numeric(Hospital_In_the_States$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)), ]
    Resulting_DF <- Data_Hospital_Interested[, c("Hospital.Name",names_of_columns[3])]
  }
  
  #Subset all the missing values
  good <- complete.cases(Resulting_DF)
  Resulting_DF1 <- Resulting_DF[good, ]
  # Resulting_DF
#   Before we return the top hospital, we have to check if there is a tie. 
  res_name <- Resulting_DF1[, 1]
  res_val <- Resulting_DF1[, 2]
  final_name <- res_name[1]
  j <- 2 
  for (i in 1:length(Resulting_DF1)) 
  {
    if(res_val[i] == res_val[i+1])
    {
      final_name[j] <- res_name[i+1]
      j <- j+1
    }
    else
    {
      break
    }
    
  }
  
  last <- sort(final_name)
  last
#   
  
  ## Return hospital name in that state with lowest 30-day death rate
}