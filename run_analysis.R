#Loading test data - Binding the Subjects and Activities to the measurements
subject_test <- read.table("test\\subject_test.txt")
X_test <- read.table("test\\X_test.txt")
y_test <- read.table("test\\y_test.txt")
merged_test <- cbind(subject_test,y_test,X_test)

#Loading train data - Binding the Subjects and Activities to the measurements
subject_train <- read.table("train\\subject_train.txt")
X_train <- read.table("train\\X_train.txt")
y_train <- read.table("train\\y_train.txt")
merged_train <- cbind(subject_train,y_train,X_train)

#Loading features data and adding Subject and Activity to use as column names
features <- read.table("features.txt",stringsAsFactors = FALSE)
features <- rbind(c("0","Subject"),c("0","Activity"),features)

#Setting column names to test and train datasets and binding the 2 to create 1 dataset
colnames(merged_test) <- features$V2
colnames(merged_train) <- features$V2
merged <- rbind(merged_test,merged_train)

#Setting Activity labels to the activity column instead of the activity numbers
activity_labels <- read.table("activity_labels.txt")
activity_named_col <- activity_labels$V2[merged$Activity]

merged$Activity <- activity_named_col

#Extracting only the measurements on the mean and standard deviation for each measurement
tidy <- merged[grepl("mean|std|Activity|Subject", names(merged))]

#Ordering the datasaet based on Subject and the Activity
tidy <- tidy[order(tidy$Subject,tidy$Activity),]

#Using slightly more descriptive variable names
descriptive_names <- sapply(colnames(tidy), function(x) sub("tBody","timeBody",x))
descriptive_names <- sapply(descriptive_names, function(x) sub("fBody","frequencyBody",x))
descriptive_names <- sapply(descriptive_names, function(x) sub("tGravity","timeGravity",x))
descriptive_names <- sapply(descriptive_names, function(x) gsub("\\()|-","",x))
descriptive_names <- sapply(descriptive_names, function(x) sub("BodyBody","Body",x))

colnames(tidy) <- descriptive_names

# Creating another data set with the average of each variable for each activity and each subject. (Using dplyr package to group the data)
library(dplyr)
grouped_data <- group_by(tidy, Subject, Activity)
meandata <- summarize_all(grouped_data, funs(mean))

#Writing the dataset to a file 
write.table(meandata,"meandata.txt")

#Setting ouput as the final dataset
meandata