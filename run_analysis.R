
# XXX CodeBook.md. 

# The organization of the original data is most peculiar.  I pieced things together in large part
# by data dimensions.  For example, X_train.txt, X_test.txt, y_train.txt, and y_test.txt are all 561
# columns wide, and features.txt has 561 rows.  Based on that and the descriptions of the fields, I'm
# of the opinion that the rows of features.txt map to the columns of X_train.txt etc.  Likewise,
# subject_train.txt and y_train are effectively extra columns for X_train.txt, and
# subject_test.txt and y_test are effectively extra columns for X_test.txt.
# Each row of subject_train indicates which person is responsible for the matching row in X_train.
# Likewise with subject_test and X_test.

# features contains the column names, one for each column in X_train.txt and X_test.txt
# both the training and the test data have these same columns
# see features_info.txt
# this supports requirement #4, Appropriately labels the data set with descriptive variable names.

features <- read.table("UCI_HAR_Dataset/features.txt") # 561 rows
colnames(features) <- c("id", "name")

# each row in X_train and X_test is data for one person doing a specific exercise; columns are different measurements taken.

# training data:

X_train <-  read.table("UCI_HAR_Dataset/train/X_train.txt", colClasses = "numeric")  # 7352 rows, 561 columns
colnames(X_train) <- features$name

subject_train <- read.table("UCI_HAR_Dataset/train/subject_train.txt", colClasses = "numeric")  # 7352 rows, 1 column
X_train$subject_id = subject_train$V1

y_train <-  read.table("UCI_HAR_Dataset/train/y_train.txt", colClasses = "numeric")   # 7352 rows, 1 column
X_train$activity_id = y_train$V1 # for each row of X_train, an id that relates to activity_labels

# test data:

X_test <-  read.table("UCI_HAR_Dataset/test/X_test.txt", colClasses = "numeric" )  # 2947 rows, 561 columns
colnames(X_test) <- features$name

subject_test <- read.table("UCI_HAR_Dataset/test/subject_test.txt", colClasses = "numeric" )  # 2947 rows, 1 column
X_test$subject_id = subject_test$V1

y_test <-  read.table("UCI_HAR_Dataset/test/y_test.txt", colClasses = "numeric" ) # 2947 rows, 1 column
X_test$activity_id = y_test$V1

# join training and test data
# this supports requirement #1, Merges the training and the test sets to create one data set.

X_combined <- rbind(X_train, X_test) # 10299 rows

# extract only the mean and std deviation fields, as well as the activity_id and subject_id fields we've injected in.  those look like this:
# [516] "fBodyBodyAccJerkMag-mean()"
# [517] "fBodyBodyAccJerkMag-std()"
# this supports requirement #2, Extracts only the measurements on the mean and standard deviation for each measurement.
  
X_combined <- X_combined[ grepl("-mean|-std|activity_id|subject_id", colnames(X_combined) ) ]

# get the human readable activity (label) for each row
# have to turn sort off so it doesn't ruin the order of the data, which matches the ordering of X_combined

# replace the activity_id column with an activity_name column that gives a more human readable description of the activity measured
# activity_labels gives names for the activity ids in y_train.txt and y_test.txt
# this supports requirement #3, Uses descriptive activity names to name the activities in the data set.

activity_labels <- read.table("UCI_HAR_Dataset/activity_labels.txt")
colnames(activity_labels) <- c("id", "activity_name")

X_combined$activity_name <- sapply( X_combined$activity_id, function(id) activity_labels$activity_name[id] )
X_combined$activity_id <- NULL

# split and aggregate

# create a combined id comprised of both activity_id and subject_id to split on
# this supports requirement #5, Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# my reading of that averaging should be done on the data after it is grouped into groups of unique combinations of subject and activity.
# for example, data for all observations of subject #1 walking would be averaged together, and seperately, all observations of subject #2 climbing stairs would be averaged together.
# as such, we use as a factor the combination of activity_name and subject_id
# this breaks the data into 180 groups

X_split <- split( X_combined, list(X_combined$activity_name, X_combined$subject_id ) )

# create a list of column names that need their means computed

numeric_column_names <-  grep("(-std)|(-mean)", colnames(X_combined), value=T )

# build a new set of dataframes from the means of the -std and -means columns, preserving our ids

X_means <- lapply(
    X_split, function(person_activity) {
        data.frame( 
            as.list(colMeans(person_activity[numeric_column_names])), 
            subject_id=as.integer(unique(person_activity$subject_id)), 
            activity_name=as.character(unique(person_activity$activity_name))
        )
    }
)

# bind those all back together into one dataframe

X <- do.call(rbind, X_means)

# save our "clean" data set to disk

write.csv(X, "cleaned_data_peer_assignment.csv") 

