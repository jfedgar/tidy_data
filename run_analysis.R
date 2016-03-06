library(dplyr)

#create a nice folder to contain all of this, set as working directory
working_dir_name = "tidy_data"
if(basename(getwd()) != working_dir_name) {
  dir.create(working_dir_name)
  setwd(working_dir_name)
}

zipfile_name <- "dataset.zip"
data_folder <- "UCI HAR Dataset"
#download file if it doesn't exist in working dir
if(!file.exists(zipfile_name)) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile=zipfile_name)
}
#unzip file if it has not already been unzipped
if(!file.exists(data_folder)) {
  unzip(zipfile_name, exdir = data_folder, junkpaths = TRUE)
}

#quick function for concatenating filename onto the data dir
get_file_path <- function(filename) {
  paste(data_folder, filename, sep="/")
}

#get activity labels and feature names
activity_labels <- read.table(get_file_path("activity_labels.txt"))
features <- read.table(get_file_path("features.txt"))
#get the indices of the columsn we want to keep and their names in a separate vector
features_to_keep_indices <- grep("mean|std", features$V2, value=FALSE )
features_to_keep_names <- grep("mean|std", features$V2, value=TRUE )
#get test data
test_data <- read.table(get_file_path("X_test.txt"))[features_to_keep_indices]
test_activities <- read.table(get_file_path("Y_test.txt"))
test_subjects <- read.table(get_file_path("subject_test.txt"))
#get training data
train_data <- read.table(get_file_path("X_train.txt"))[features_to_keep_indices]
train_activities <- read.table(get_file_path("Y_train.txt"))
train_subjects <- read.table(get_file_path("subject_train.txt"))
#merge data sets
merged_data <- rbind(test_data, train_data)
merged_activities <- rbind(test_activities, train_activities)
merged_subjects <- rbind(test_subjects, train_subjects)
#label merged data
colnames(merged_data) <- features_to_keep_names
#make names more descriptive

#add activity names and subject ids to data
merged_data$activity = activity_labels[merged_activities$V1, "V2"]
merged_data$subject = merged_subjects$V1

#create "narrow" form of data by melting the mean and std. dev. measurements into single 'measurement' column 
#with a 'value' column representing the value for that measurement, subject and activity
melted <- gather(merged_data, measurement, value, -subject, -activity)
#group rows by subject and activity and measurement
grouped <- group_by(melted, subject, activity, measurement)
#summarize on the mean of the value for each variable for each subject for each activity
tidy <- summarize(grouped, mean = mean(value))

write.table(tidy, "tidy_data.txt", row.names = FALSE)