# Coursera course project - Getting and Cleaning Data
This project uses data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
The `run_analysis.R` script does the following
1. Loading test data and bind the Subjects and Activities to the measurement
2. Loading train data and bind the Subjects and Activities to the measurement
3. Loading features data and adding Subject and Activity to use as column names
4. Setting column names to test and train datasets and binding the 2 to create 1 dataset
5. Setting Activity labels to the activity column instead of the activity numbers
6. Extracting only the measurements on the mean and standard deviation for each measurement
7. Ordering the datasaet based on Subject and the Activity
8. Using slightly more descriptive variable names (Complete description foung in Codebook.md)
9. Creating another data set with the average of each variable for each activity and each subject. (Using dplyr package to group the data)
10. Writing the dataset to a file called `meandata.txt`
