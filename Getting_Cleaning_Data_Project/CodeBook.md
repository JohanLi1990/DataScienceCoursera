# CodeBook: Wearble devices dataset

## Raw Data

The raw data is collected from the research: "Human Activity Recognition Using Smartphones Data Set"
link: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The raw data is in txt file format, with no headers. The subject and activity were separated from the rest of the variables initially. 
Furthermore, the test and training data sets are also separated, and it is our intention to combine them. 

There are 10299 observation in totall. 


## Variables

The research experiments involve 30 human subjects, who were to perform tests for 6 type of activity: walking, walking upstairs, walking downstair, standing, laying, sitting. 

For each single observation, 561 derived measurements were made from the accelerometer. However, in this case, we were only interested at the mean and standard deviations among the derived measurements, thus reducing number of variables to 79. 

With the inclusion of Activity and Subject, the variables sampled are listed below:

  variable names|                                |                                          |                                 |
 ----------|-------------------------------------|------------------------------------------|---------------------------------|
  "Subject" |                        "Activity"   |                     "tBodyAcc-mean()-X"  |             "tBodyAcc-mean()-Y" |
 "tBodyAcc-mean()-Z" |              "tBodyAcc-std()-X"  |              "tBodyAcc-std()-Y"  |              "tBodyAcc-std()-Z"  |             
 "tGravityAcc-mean()-X" |           "tGravityAcc-mean()-Y"  |          "tGravityAcc-mean()-Z"   |         "tGravityAcc-std()-X" |           
 "tGravityAcc-std()-Y" |            "tGravityAcc-std()-Z" |            "tBodyAccJerk-mean()-X"|           "tBodyAccJerk-mean()-Y" |         
 "tBodyAccJerk-mean()-Z" |          "tBodyAccJerk-std()-X"  |          "tBodyAccJerk-std()-Y" |           "tBodyAccJerk-std()-Z"   |        
 "tBodyGyro-mean()-X" |             "tBodyGyro-mean()-Y"  |            "tBodyGyro-mean()-Z" |             "tBodyGyro-std()-X"  |            
 "tBodyGyro-std()-Y" |             "tBodyGyro-std()-Z"  |             "tBodyGyroJerk-mean()-X" |         "tBodyGyroJerk-mean()-Y" |        
 "tBodyGyroJerk-mean()-Z" |         "tBodyGyroJerk-std()-X"  |         "tBodyGyroJerk-std()-Y"  |         "tBodyGyroJerk-std()-Z"  |        
 "tBodyAccMag-mean()" |             "tBodyAccMag-std()" |              "tGravityAccMag-mean()"|           "tGravityAccMag-std()" |          
 "tBodyAccJerkMag-mean()"  |        "tBodyAccJerkMag-std()" |          "tBodyGyroMag-mean()"   |          "tBodyGyroMag-std()" |           
 "tBodyGyroJerkMag-mean()"|         "tBodyGyroJerkMag-std()" |         "fBodyAcc-mean()-X"  |             "fBodyAcc-mean()-Y" |             
 "fBodyAcc-mean()-Z"  |             "fBodyAcc-std()-X"   |             "fBodyAcc-std()-Y"   |             "fBodyAcc-std()-Z"   |            
 "fBodyAcc-meanFreq()-X" |          "fBodyAcc-meanFreq()-Y" |          "fBodyAcc-meanFreq()-Z" |          "fBodyAccJerk-mean()-X"  |        
 "fBodyAccJerk-mean()-Y"  |         "fBodyAccJerk-mean()-Z"  |         "fBodyAccJerk-std()-X"  |          "fBodyAccJerk-std()-Y"  |         
 "fBodyAccJerk-std()-Z"  |          "fBodyAccJerk-meanFreq()-X" |      "fBodyAccJerk-meanFreq()-Y" |      "fBodyAccJerk-meanFreq()-Z" |     
 "fBodyGyro-mean()-X" |             "fBodyGyro-mean()-Y" |             "fBodyGyro-mean()-Z"  |            "fBodyGyro-std()-X"  |            
 "fBodyGyro-std()-Y" |              "fBodyGyro-std()-Z"  |             "fBodyGyro-meanFreq()-X" |         "fBodyGyro-meanFreq()-Y"  |       
 "fBodyGyro-meanFreq()-Z" |         "fBodyAccMag-mean()"  |            "fBodyAccMag-std()"    |           "fBodyAccMag-meanFreq()" |        
 "fBodyBodyAccJerkMag-mean()" |     "fBodyBodyAccJerkMag-std()" |      "fBodyBodyAccJerkMag-meanFreq()"|  "fBodyBodyGyroMag-mean()"   |     
 "fBodyBodyGyroMag-std()"|          "fBodyBodyGyroMag-meanFreq()" |    "fBodyBodyGyroJerkMag-mean()"  |   "fBodyBodyGyroJerkMag-std()" |    
 "fBodyBodyGyroJerkMag-meanFreq()"|
 
 
 At the end of the project, new variable based on average of the measurements were calculated. They are simply labeled with an "Average in front", for example:
 
 Old Variable | New Variable|
 -------------|-------------|
 fBodyGyro-std()-Y|Average fBodyGyro-std()-Y|
 
 
### Data Type
Variable | DataType
---------|---------
Subject, Activity|factor
The rest|numeric

### Dictionary
1. Activity

Value | Meaning
------|--------
1 | WALKING
2 | WALKING_UPSTAIRS
3 | WALKING_DOWNSTAIRS
4 | SITTING
5 | STANDING
6 | LAYING

2. Subject

Value | Meaning
------|--------
1~30 | 30 different subject

3. Rest of the variables

Value | Meaning
------|--------
[-1, 1]| normalized values




## Transformations from Raw to Tidy Data set

1. Read the raw data using read.tables 
2. transform activity and subject data into factors, using factor function
3. get the index of the columns interested from the feature.txt, using grep function(regular expression)
4. use the index vector from the previous step for subsetting the raw data. Function used here is select from dplyr. 
5. transform activity from its coding into description.
6. rename all the columns according to their labels in feature.txt from the raw data. Here R basic function is used in a for loop to perform the transformation. dplyr package for some reason is not working right. 
7. To transform into the tidy dataset required from the instruction:
  * 7a. Group the data set by the subject and activity.
  * 7b. Use summarize_each with the mean function to calculate average value for each subject and activity observation. 

