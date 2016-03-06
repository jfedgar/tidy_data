# Getting and Cleaning Data - Week 4 - Course Project

`run_analysis.r` is a script for downloading and tidying data from the UCI
Machine Learning Repository - Human Activity Recognition Using Smartphones Data
Set

`run_analysis.r` creates a tidy summary table with the mean measurement value
per subject per activity for each of the standard deviation and mean
measurements represented in the distilled "X_test" and "X_train" data from the 
UCI HAR Dataset.

In order to achieve this, `run_analysis.r` does the following:

1. Creates a folder called "tidy_data" for storing all original and generated
   data files
2. Downloads and unzips the UCI HAR Dataset into this folder if it does not already exist
3. Loads the feature and activity information for both the test
   and training data
4. Loads both the test and training datasets, only keeping columns which
   contain the mean or standard deviation information
5. Binds the test and training data sets
6. Binds the test and training activity data
7. Binds the test and training subjects data
8. Appends the activity name for each observation as a new column
9. Appends the subject id for each observation as a new column
10. Gathers the 79 mean and std deviation measurement columns into a single column, giving the
   dataset the "narrow" form.
11. Creates a tidy summary dataset that consists of the subject, activity, measurement, and mean of each
   measurement type for each subject and activity pair. There is one row for the mean
value of every measurement per subject per activity.
12. Writes this summary dataset to a text file called "tidy_data.txt"
