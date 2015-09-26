# Getting & Cleaning Data Project 
# R scripts
# Goal:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with 
#    the average of each variable for each activity and each subject.
#
setwd("~/Documents/DataScienceCoursera/Getting_Cleaning_Data_Project")
library(plyr)
library(dplyr)

# #----Step I: read into Rstudio, inspect data samples---
test_data_bulk <- read.table("X_test.txt")
test_data_activity <- read.table("y_test.txt")
test_data_subject <- read.table("subject_test.txt")

train_data_bulk <- read.table("X_train.txt")
train_data_activity <- read.table("y_train.txt")
train_data_subject <- read.table("subject_train.txt")

# Step II : convert activity and subject to factors
test_data_subject$V1 <- factor(test_data_subject$V1)
test_data_activity$V1 <- factor(test_data_activity$V1)

train_data_subject$V1 <- factor(train_data_subject$V1)
train_data_activity$V1 <- factor(train_data_activity$V1)

# Step III: get all the column index related to mean and std from features_info.txt
# using regular expression
features_info <- read.table("features.txt")
pattern1 <- "mean"
pattern2 <- "std"
int_1 <- grep(pattern1, x = features_info$V2)
int_2 <- grep(pattern2, x = features_info$V2)
col_interested <- c(int_1, int_2)
col_interested <- sort(col_interested)

# Step IV: select col_interested from test_data_bulk, 
test_interest <- select(test_data_bulk, col_interested)
train_interest <- select(train_data_bulk, col_interested)

# Step V: transform activity into a descriptive one:
test_data_activity$V1 <- revalue(test_data_activity$V1, c("1" = "Walking", 
                              "2" = "Walking_Upstair", 
                              "3" = "Walking_Downstair", 
                              "4" = "Sitting", 
                              "5" = "Standing", 
                              "6" = "Laying"))
train_data_activity$V1 <- revalue(train_data_activity$V1, c("1" = "Walking", 
                                                          "2" = "Walking_Upstair", 
                                                          "3" = "Walking_Downstair", 
                                                          "4" = "Sitting", 
                                                          "5" = "Standing", 
                                                          "6" = "Laying"))
# attach subject & activity to the respective test and train data

test_interest$Subject <- test_data_subject$V1
train_interest$Subject <- train_data_subject$V1
test_interest$Activity <- test_data_activity$V1
train_interest$Activity <- train_data_activity$V1

# change the order of the columns a little bit for readability
test_interest <- test_interest[, c(80:81, 1:79)]
train_interest <- train_interest[, c(80:81, 1:79)]

# Since the column names are the same, we can vertically combine the two dataframes
test_and_train_final <- rbind(test_interest, train_interest)

# Step VI: rename some of the variables
oldnames <- names(test_and_train_final)
newnames <- features_info$V2
for (i in 3:81) {
  new_name <- as.character(newnames[col_interested[i-2]])
  colnames(test_and_train_final)[i] <- new_name
  
}

# Step VII: Create the tidy data set 
Test_Train_Tidy <- group_by(test_and_train_final, Subject, Activity)
Test_Train_Tidy <- Test_Train_Tidy %>% summarise_each(funs(mean))

for (i in 3:81) {
  old_name <- names(Test_Train_Tidy)[i]
  new_name <- paste("Average",old_name, sep = " " )
  colnames(Test_Train_Tidy)[i] <- new_name
  
}




