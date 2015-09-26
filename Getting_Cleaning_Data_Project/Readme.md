### Use of run_analysis.r

To reuse run_analysis.r, you may have to change the file Url inside the scripts. 
```R
setwd("~/Documents/DataScienceCoursera/Getting_Cleaning_Data_Project")
```
Replace with
```R
setwd("~/Your_File_Path")

```
Besides the file path, you have to install dplyr and plyr packages in your local Rstudio in order to reproduce the same result. 

### How run_analysis.r works

The scripts make use the following steps to transform raw data

1. Read the raw data using read.tables 
2. transform activity and subject data into factors, using factor function
3. get the index of the columns interested from the feature.txt, using grep function(regular expression)
4. use the index vector from the previous step for subsetting the raw data. Function used here is select from dplyr. 
5. transform activity from its coding into description.
6. rename all the columns according to their labels in feature.txt from the raw data. Here R basic function is used in a for loop to perform the transformation. dplyr package for some reason is not working right. 

```R
# Step VI: rename some of the variables
oldnames <- names(test_and_train_final)
newnames <- features_info$V2
for (i in 3:81) {
  new_name <- as.character(newnames[col_interested[i-2]])
  colnames(test_and_train_final)[i] <- new_name
  
}
```

7. To transform into the tidy dataset required from the instruction:
  * 7a. Group the data set by the subject and activity.
  * 7b. Use summarise_each with the mean function to calculate average value for each subject and activity observation. 
```R
Test_Train_Tidy <- Test_Train_Tidy %>% summarise_each(funs(mean))
```