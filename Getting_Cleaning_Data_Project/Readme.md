### Use of run_analysis.r

To reuse run_analysis.r, you may have to change the file Url inside the scripts. 
```R
test_data_bulk <- read.table("./Getting_Cleaning_Data_Project/UCI HAR Dataset/test/X_test.txt")
test_data_activity <- read.table("./Getting_Cleaning_Data_Project/UCI HAR Dataset/test/y_test.txt")
test_data_subject <- read.table("./Getting_Cleaning_Data_Project/UCI HAR Dataset/test/subject_test.txt")
```
Replace with
```R
test_data_bulk <- read.table("./Your path here/X_test.txt")
test_data_activity <- read.table("./Your path here/y_test.txt")
test_data_subject <- read.table("./Your path here/subject_test.txt")

```
Besides the file path, you have to install dplyr and plyr packages in your local Rstudio in order to reproduce the same result. 
