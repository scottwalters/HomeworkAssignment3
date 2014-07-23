
## run_analysis.R -- distil Galaxy S motion data collected from people performing various activities

This R program operators on data in this archive:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The unzip'd directory was renamed to "UCI_HAR_Dataset".  The script should be in the same directory as "UCI_HAR_Dataset" when run.

The script:

* Merges training and test data sets
* Drops all columns except the mean and standard deviation columns
* Adds a column with a human readable description of the activity being performed
* Splits the data by a combination of user and activity
* Computes column means on all data columns for that user and activity combination
* Writes the results into a file named "cleaning_data_peer_assignment.csv"

Columns are added for the following values:

* activity_id (matching the values in activity_labels.txt and y_test.txt/y_train.txt)
* activity_name (taken from activity_labels.txt)
* subject_id (ID of the person the data was collected from, taken from y_test.txt/y_training.txt)

To do this, it reads and mixes in data from activity_labels.txt, subject_(test and training).txt, y_(test and training).txt into X_train.txt and X_test.txt. 

Features (columns) are described in features_info.txt in the zip archive and are repeated here:

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

(End text from features_info.txt.)

For each of those values, the average and standard deviation are averaged separately for each person engaging in each activity.
Eg, if one person walked up the stairs ten times, all rows for those ten observations are averaged together to create the output dataset.

