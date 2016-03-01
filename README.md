# GettingandCleaningData_Assignment

Assignment for week 4 of Getting and Cleaning Data online course. 

To run the script, you need the data in the original folder, as "UCI HAR Dataset". 
In other words, all the following must be the locations of each file: 

UCI HAR Dataset/test/X_test.txt

UCI HAR Dataset/test/y_test.txt

UCI HAR Dataset/test/subject_test.txt

UCI HAR Dataset/train/X_train.txt

UCI HAR Dataset/train/y_train.txt

UCI HAR Dataset/train/subject_train.txt

The analysis was performed on the data as described in the assignment. 
First, necessary libraries are loaded (namely "reshape2"). 
Then each file is read into R with "read.table".
The script then attaches the activity and subject identifier to the data. 

The script loads the feature information into R, and then use 'grep' to find all the instances of "mean" and "std". This information is the indices where the relevant data is found (mean and std data), and is stored in a variable called Cols.

Then we are ready to start checking off the assignment details. 

1: Merge the "test" and "train" datasets into one dataset, as per step 1 in the project description. This is done simply with the rbind function, appending both sets of information into one new dataset called all_data

2: Extract only the relevant mean, std, activity and subject data and put it into a single table, as per step 2 in the project description. This uses the variable "Cols", as mentioned above, selecting only those columns. 

4: Rename the variables based on the file features.txt, as per step 4 in the project description. Note, i found it simpler to do step 4 before step 3. To do this I use the names() function, reassigning the column names. 

3: Convert the activity names into appropriate descriptive character strings, as per step 3 in the project description. I use the descriptions found in the features.txt file, as they are a balance of being both descriptive and brief: 'mean Body Acceleration in the Y direction, in the time domain' is referred to as tBodyAcc-mean()-Y. There was no way to make these titles more descriptive without making them cumbersomely long and verbose. 

5: Create a second, independent tidy data set with the average of each variable for each activity and each subject. To do this, we take advantage of the "melt" function from the reshape2 package, melting along the subject and activity variables, and then we use "dcast" to organize the data, taking the mean of each variable for every subject and every activity. This data is stored in a tidy data set (which is a wide tidy data set). The data is tidy because each column is only one variable: there is one column with subject id, one with activity id in a nice easy to understand name, and all the column names are descriptive. 
