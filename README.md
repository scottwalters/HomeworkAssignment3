
## run_analysis.R -- distil Galaxy S motion data collected from people performing various activities

This R program operators on data in this archive:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The unzip'd directory was renamed to "UCI_HAR_Dataset".  The script should be in the same directory as "UCI_HAR_Dataset" when run.

The script:

* Merges training and test data sets
* Drops all columns except the mean and standard deviation columns
* Adds a column with a human readable description of the activity being performed
* Splits the data by a combination of user and activity
* Computes column means on all data columns
* Writes the results into a file named "cleaning_data_peer_assignment.csv"

To do this, it reads and mixes in data from activity_labels.txt, subject_*.txt, y_*.txt into X_train.txt and X_test.txt. 


