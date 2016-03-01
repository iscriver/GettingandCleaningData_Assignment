##

## Load the necessary libraries

library(reshape2)

## Load the test and trial data into R (I have assumed we already downloaded 
## the data)

test_Data <- read.table(file = "UCI HAR Dataset/test/X_test.txt")
test_activity <- read.table(file = "UCI HAR Dataset/test/y_test.txt", colClasses = "character")
test_subject <- read.table(file = "UCI HAR Dataset/test/subject_test.txt", colClasses = "character")

train_Data <- read.table(file = "UCI HAR Dataset/train/X_train.txt")
train_activity <- read.table(file = "UCI HAR Dataset/train/y_train.txt", colClasses = "character")
train_subject <- read.table(file = "UCI HAR Dataset/train/subject_train.txt", colClasses = "character")

## Attach the activity and subject identifier to the data

test_Data <- cbind(test_Data, test_subject, test_activity)
train_Data <- cbind(train_Data, train_subject, train_activity)

## Load the feature information into R, and then use 'grep' to find all the 
## instances of "mean" and "std"

features <- read.table(file = "UCI HAR Dataset/features.txt", colClasses = "character")
Cols <- grep("(mean)|(std)", features$V2)

## 1: Merge the "test" and "train" datasets into one dataset, as per step 1 in 
## the project description

all_data <- rbind(test_Data, train_Data)

remove(test_Data, test_subject, test_activity)
remove(train_Data, train_subject, train_activity)
## 2: Extract only the relevant mean, std, activity and subject data and put it 
## into a single table, as per step 2 in the project description. This uses
## the variable "Cols", created above. 

data <- all_data[,c(Cols, 562, 563)]

## 4: Rename the variables based on the features text file, as per step 4 in the 
## project description

names(data) <- c(features$V2[Cols], "Subject", "Activity")

## 3: Convert the activity names into appropriate descriptive character strings,
## as per step 3 in the project description

data$Activity <- gsub(pattern = "1", replacement = "Walking", x = data$Activity)
data$Activity <- gsub(pattern = "2", replacement = "Walking Upstairs", x = data$Activity)
data$Activity <- gsub(pattern = "3", replacement = "Walking Downstairs", x = data$Activity)
data$Activity <- gsub(pattern = "4", replacement = "Sitting", x = data$Activity)
data$Activity <- gsub(pattern = "5", replacement = "Standing", x = data$Activity)
data$Activity <- gsub(pattern = "6", replacement = "Laying", x = data$Activity)

## 5: Create a second, independent tidy data set with the average of each 
## variable for each activity and each subject

data_melt <- melt(data, id = c("Subject", "Activity"), measure.vars = features$V2[Cols])
 
tidy_data <- dcast(data_melt, Subject + Activity~variable, mean)

remove(data_melt)

write.table(file = "tidy_data.txt")