library(reshape2)

#load the test data
subject_test <- read.table("UCI_HAR_Dataset/test/subject_test.txt")
X_test <- read.table("UCI_HAR_Dataset/test/X_test.txt")
y_test <- read.table("UCI_HAR_Dataset/test/y_test.txt")

#load the train data
subject_train <- read.table("UCI_HAR_Dataset/train/subject_train.txt")
X_train <- read.table("UCI_HAR_Dataset/train/X_train.txt")
y_train <- read.table("UCI_HAR_Dataset/train/y_train.txt")

#load the activity names
activity_labels <- read.table("UCI_HAR_Dataset/activity_labels.txt")

#load the feature names
features <- read.table("UCI_HAR_Dataset/features.txt")
headers <- features[,2]

#name columns of test and train features
names(X_test) <- headers
names(X_train) <- headers

#select only mean and std headers
mean_and_std <- grepl("mean\\(\\)|std\\(\\)", headers)

#filter mean and std columns on test and train
X_test_mean_and_std <- X_test[,mean_and_std]
X_train_mean_and_std <- X_train[,mean_and_std]

#merge all test and train rows
subject_all <- rbind(subject_test, subject_train)
X_all <- rbind(X_test_mean_and_std, X_train_mean_and_std)
y_all <- rbind(y_test, y_train)

#combine all vectors/data.frames into one data.frame
merged <- cbind(subject_all, y_all, X_all)
names(merged)[1] <- "SubjectID"
names(merged)[2] <- "Activity"

#tidy = aggregate by subjectid and activity
tidy <- aggregate(. ~ SubjectID + Activity, data=merged, FUN = mean)

#give activities better names
tidy$Activity <- factor(tidy$Activity, labels=activity_labels[,2])

write.table(tidy, file="./tidy.txt", sep="\t", row.names=FALSE)

