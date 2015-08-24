rankall <- function(outcome, num = "best") {
  ## Read outcome data
  outcome_of_care <- read.csv("outcome-of-care-measures.csv")
  
  
  ## Check that outcome are valid
  valid_outcome <- c("heart attack", "heart failure",  "pneumonia")
  valid_state <- unique(outcome_of_care$State) #54 Levels
  valid_state <- sort(valid_state)
  HospitalNames <- rep("", length(valid_state))
  if(!outcome %in% valid_outcome)
  {
    stop("Invalid Outcome!")
  }
  else if(outcome == valid_outcome[1])
  {
    #first simplify the dataset
    outcome_of_care <- data.frame(Hospital.Name = outcome_of_care$Hospital.Name, 
                                  State = outcome_of_care$State,
                                  Mortality.Rate = outcome_of_care$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
    # we have 54 states, have to find the hospital with the specified rank for each state
    for(i in 1:length(valid_state))
    {
      Hospital_In_the_States <- subset(outcome_of_care, outcome_of_care$State == valid_state[i])
      Hospital_In_the_States<- Hospital_In_the_States[!Hospital_In_the_States$Mortality.Rate
                                                      == "Not Available", ]

      Data_Hospital_Interested <- 
        Hospital_In_the_States[order(as.numeric(Hospital_In_the_States$Mortality.Rate), 
                                     Hospital_In_the_States$Hospital.Name), ]
      res_name <- Data_Hospital_Interested$Hospital.Name
      if(num == "best")
      {
        res_hospital <- res_name[1]
      }
      else if(num == "worst")
      {
        res_hospital <- res_name[length(Data_Hospital_Interested)]
      }
      else
      {
        res_hospital <- res_name[num]
      }
      #print(res_hospital)
      HospitalNames[i] <- as.character(res_hospital)

      
    }
    
  }
  else if(outcome == valid_outcome[2])
  {
    outcome_of_care <- data.frame(Hospital.Name = outcome_of_care$Hospital.Name, 
                                  State = outcome_of_care$State,
                                  Mortality.Rate = outcome_of_care$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
    # we have 54 states, have to find the hospital with the specified rank for each state
    for(i in 1:length(valid_state))
    {
      Hospital_In_the_States <- subset(outcome_of_care, outcome_of_care$State == valid_state[i])
      Hospital_In_the_States<- Hospital_In_the_States[!Hospital_In_the_States$Mortality.Rate
                                                      == "Not Available", ]
      Hospital_In_the_States <- data.frame(lapply(Hospital_In_the_States, as.character), stringsAsFactors = FALSE)
      Hospital_In_the_States$Mortality.Rate <- as.numeric(as.character(Hospital_In_the_States$Mortality.Rate))

      Data_Hospital_Interested <- 
        Hospital_In_the_States[order(Hospital_In_the_States$Mortality.Rate, 
                                     Hospital_In_the_States$Hospital.Name), ]
      res_name <- Data_Hospital_Interested$Hospital.Name
      c <- length(res_name)
      c<- as.numeric(as.character(c))
      if(num == "best")
      {
        res_hospital <- res_name[1]
      }
      else if(num == "worst")
      {
        res_hospital <- res_name[c]
      }
      else
      {
        res_hospital <- res_name[num]
      }
      
      HospitalNames[i] <- as.character(res_hospital)

      
    }
  }
  else if(outcome == valid_outcome[3])
  {
    outcome_of_care <- data.frame(Hospital.Name = outcome_of_care$Hospital.Name, 
                                  State = outcome_of_care$State,
                                  Mortality.Rate = outcome_of_care$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
    # we have 54 states, have to find the hospital with the specified rank for each state
    for(i in 1:length(valid_state))
    {
      Hospital_In_the_States <- subset(outcome_of_care, outcome_of_care$State == valid_state[i])
      Hospital_In_the_States<- Hospital_In_the_States[!Hospital_In_the_States$Mortality.Rate
                                                      == "Not Available", ]
      
      Hospital_In_the_States <- data.frame(lapply(Hospital_In_the_States, as.character), stringsAsFactors = FALSE)
      Hospital_In_the_States$Mortality.Rate <- as.numeric(as.character(Hospital_In_the_States$Mortality.Rate))
      #Hospital_In_the_States$Hospital.Name <- as.character(Hospital_In_the_States$Hospital.Name)
      Data_Hospital_Interested <- 
        Hospital_In_the_States[order(Hospital_In_the_States$Mortality.Rate, Hospital_In_the_States$Hospital.Name),  ]
      res_name <- Data_Hospital_Interested$Hospital.Name
      c <- length(res_name)
      c <- as.numeric(as.character(c))
      if(num == "best")
      {
        res_hospital <- res_name[1]
      }
      else if(num == "worst")
      {
        #
        res_hospital <- res_name[c]
      }
      else
      {
        res_hospital <- res_name[num]
      }
      
      res_hospital <- res_hospital
      HospitalNames[i] <- res_hospital


      
    }
  }
  
  #HospitalNames
  
  final_result <- data.frame(hospital =HospitalNames,
                             state = valid_state)

  final_result
#  
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  
}