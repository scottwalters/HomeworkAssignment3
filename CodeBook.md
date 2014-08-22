
## Code Book for run_analysis.R

Columns are added to the output for the following values:

* activity_name (taken from activity_labels.txt, based on values in y_test.txt/y_train.txt)
* subject_id (ID of the person the data was collected from, taken from subject_test.txt/subject_train.txt)

Features (columns) are described in features_info.txt in the zip archive and are repeated here:

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. 
Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. 
Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). 
Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

(End text from features_info.txt.)

Permutations of each of these columns exist for -mean and -std (standard deviation) versions of each of these columns:

* tBodyAcc-XYZ -- "the acceleration signal separated into body and gravity acceleration signals"
* tGravityAcc-XYZ -- "the acceleration signal separated into body and gravity acceleration signals"
* tBodyGyro-XYZ -- "the magnitude of these three-dimensional signals were calculated using the Euclidean norm"
* tBodyGyroJerk-XYZ -- "linear acceleration and angular velocity were derived in time to obtain Jerk signals"
* tBodyAccJerk-XYZ -- "linear acceleration and angular velocity were derived in time to obtain Jerk signals"
* tBodyAccMag -- "the magnitude of these three-dimensional signals were calculated using the Euclidean norm"
* tGravityAccMag -- "the magnitude of these three-dimensional signals were calculated using the Euclidean norm"
* tBodyAccJerkMag -- "the magnitude of these three-dimensional signals were calculated using the Euclidean norm"
* tBodyGyroMag -- "the magnitude of these three-dimensional signals were calculated using the Euclidean norm"
* tBodyGyroJerkMag -- "the magnitude of these three-dimensional signals were calculated using the Euclidean norm"
* fBodyAcc-XYZ --  Fast Fourier Transform (FFT) applied to the "t" version above
* fBodyAccJerk-XYZ -- Fast Fourier Transform (FFT) applied to the "t" version above
* fBodyGyro-XYZ -- Fast Fourier Transform (FFT) applied to the "t" version above
* fBodyAccMag -- Fast Fourier Transform (FFT) applied to the "t" version above
* fBodyAccJerkMag -- Fast Fourier Transform (FFT) applied to the "t" version above
* fBodyGyroMag -- Fast Fourier Transform (FFT) applied to the "t" version above
* fBodyGyroJerkMag -- Fast Fourier Transform (FFT) applied to the "t" version above

For each of observation of those values, the average and standard deviation are averaged separately for each person engaging in each activity.
Eg, if one person walked up the stairs ten times, all rows for those ten observations are averaged together to create the output dataset.
