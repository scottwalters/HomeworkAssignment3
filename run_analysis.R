
#    Merges the training and the test sets to create one data set.
#    Extracts only the measurements on the mean and standard deviation for each measurement.
#    Uses descriptive activity names to name the activities in the data set
#    Appropriately labels the data set with descriptive variable names. 
#    Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# constant across training and test data:

features <- read.delim("UCI_HAR_Dataset/features.txt", skip=0, header=F, sep = "") # has 561 rows of essentially column names, one for each column in X_train.txt and X_test.txt; see features_info.txt
colnames(features) <- c("id", "name")

activity_labels <- read.delim("UCI_HAR_Dataset/activity_labels.txt", header = F, sep = " ")   # gives names for the activity ids used in y_train
colnames(activity_labels) <- c("id", "activity_name")

# training data:

X_train <-  read.delim("UCI_HAR_Dataset/train/X_train.txt", header = F, sep = "", colClasses = "numeric")  # okay; data.frame; 7352 rows
colnames(X_train) <- features$name

subject_train <- read.delim("UCI_HAR_Dataset/train/subject_train.txt", header = F, sep = " ")  # 7352 rows; which person is responsible for a given row in X_train
X_train$subject_id = subject_train$V1

y_train <-  read.delim("UCI_HAR_Dataset/train/y_train.txt", header = F, sep = " ")   # 7352 rows; for each row of X_train, an id that relates to activity_labels
X_train$activity_id = y_train$V1

# test data:

X_test <-  read.delim("UCI_HAR_Dataset/test/X_test.txt", header = F, sep = "", colClasses = "numeric")  # okay; data.frame; 7352 rows
colnames(X_test) <- features$name

subject_test <- read.delim("UCI_HAR_Dataset/test/subject_test.txt", header = F, sep = " ")  # 2947 rows
X_test$subject_id = subject_test$V1

y_test <-  read.delim("UCI_HAR_Dataset/test/y_test.txt", header = F, sep = " ") # 2947 rows; for each row of X_test, an id that relates to activity_labels
X_test$activity_id = y_test$V1

# join training and test data

X_combined <- rbind(X_train, X_test) # 10299 rows

# extract only the mean and std deviation fields.  those look like this:
# [516] "fBodyBodyAccJerkMag-mean()"
# [517] "fBodyBodyAccJerkMag-std()"
  
for( name in colnames(X_combined) ) {
    if( ! ( length(grep(pattern="-mean()", x=name, fixed=T)) || length(grep(pattern="-std()", x=name, fixed=T)) || name == "activity_id" || name == "subject_id") ) {  X_combined[name] <- NULL }
}

# get the human readable activity (label) for each row

y_combined_details <- merge(X_combined, activity_labels, by.x="activity_id", by.y="id", all=T, sort=F) # have to turn sort off so it doesn't ruin the order of the data, which matches the ordering of X_combined

# split and aggregate

# create a combined id comprised of both activity_id and subject_id to split on

y_combined_details$activity_subject_id = paste0(as.character(y_combined_details$activity_id), "-", as.character(y_combined_details$subject_id))

# create a list of data.frames, one data.frame for each combination of subject and activity

x <- split( y_combined_details, y_combined_details$activity_subject_id )

# create a list of column names that need their means computed

numeric_column_names <-  grep("(-std)|(-mean)", colnames(y_combined_details), value=T )

# summerize the data by computing the colMeans() of all of the -std and -mean columns.
# this creates a list of data.frames.

# y <- sapply(x, function (v) colMeans(v[numeric_column_names]) )  # works but we want to shape the data a bit
y <- lapply(x, function (v) {
    # want a wide table; many columns, but only one observation; as.list() accomplishes this; named numeric vectors create a tall data.frame which isn't what we want
    r <-as.data.frame(as.list(colMeans(v[numeric_column_names]))) 
    # unique() serves to make sure that there is only one value; otherwise, it stretches the data.frame out.
    r$subject_id=as.integer(unique(v$subject_id))
    r$activity_id=as.integer(unique(v$activity_id))
    r$activity_name=as.character(unique(v$activity_name))
    r
} )

# combine all of the data.frames (which each have one row) into one large data.frame again.
# have to iterate on lists; subscripting ranges fails; see per http://r.789695.n4.nabble.com/Recursive-Indexing-Failed-td3509179.html
# this is inefficient.  there's probably a better way to do this.

z <- data.frame()
for( i in 1:length(y) ) {
    z <- rbind(z, y[[i]])
}

# save our "clean" data set to disk

write.csv(z, "cleaning_data_peer_assignment.csv") 

