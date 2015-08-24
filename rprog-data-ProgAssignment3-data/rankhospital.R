rankhospital <- function(state, outcome, num = "best") 
{
  ## Read outcome data
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
  ## Return hospital name in that state with the given rank

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
      Hospital_In_the_States[order(as.numeric(Hospital_In_the_States$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack), 
                                   Hospital_In_the_States$Hospital.Name), ]
    Resulting_DF <- Data_Hospital_Interested[, c("Hospital.Name",names_of_columns[1])]
    
    
  }
  else if(outcome == valid_outcome[2])
  {
    Hospital_In_the_States <- Hospital_In_the_States[!Hospital_In_the_States$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure
                                                     == "Not Available", ]
    Data_Hospital_Interested <- 
      Hospital_In_the_States[order(as.numeric(Hospital_In_the_States$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure),
                                   Hospital_In_the_States$Hospital.Name), ]
    Resulting_DF <- Data_Hospital_Interested[, c("Hospital.Name",names_of_columns[2])]
    
  }
  else
  {
    Hospital_In_the_States <- Hospital_In_the_States[!Hospital_In_the_States$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia
                                                     == "Not Available", ]
    Data_Hospital_Interested <- 
      Hospital_In_the_States[order(as.numeric(Hospital_In_the_States$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia), 
                                   Hospital_In_the_States$Hospital.Name), ]
    Resulting_DF <- Data_Hospital_Interested[, c("Hospital.Name",names_of_columns[3])]
  }
  
  
  ## With regards to rank, 
  # if num == best, then return the first hospital 
  # if num == worst, last hospital
  # else return the hospital at the rank specified by num
  res_name <- Resulting_DF[, 1]
  if(num == "best")
  {
    res_hospital <- res_name[1]
  }
  else if(num == "worst")
  {
    res_hospital <- res_name[length(res_name)]
  }
  else
  {
    res_hospital <- res_name[num]
  }
  
  res_hospital
  
}


