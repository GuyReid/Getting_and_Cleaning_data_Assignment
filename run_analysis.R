
##Define URL and File destinations and download and unzip package
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
Destfile <- "dataset.zip"
download.file(url, Destfile)
unzip(Destfile)
##Import Activity Labels and set character vector based on Activity Name
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
##Import Features and set character vector based on Feature Name
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

##Select Mean and Standard Deviation measures from Features
featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
##Define names associated with features Vector
featuresWanted.names <- features[featuresWanted,2]
## Replace specific strings to normalise the strings within the list
featuresWanted.names = gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names = gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)

##Import Train table but only fields that are associated with mean and standard deviation this is defined with a column vector called Features Wanted
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresWanted]
##Import Train and Test Activities and Train Subjects and create a single "Train" and "Test" data set
trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)
test <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresWanted]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)
# Merge Test and Train data sets and set column names to the names estabished in "FeaturesWanted"
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", featuresWanted.names)

# turn activities & subjects into factors based on values in activities and subject files
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)
##Aggregate Data Set grouping by Subject and Activity and returning the mean of the other fields
library(dplyr)
allData_Aggregated <- allData %>% group_by(subject, activity) %>% summarise_all(mean,na.rm = TRUE)
##Output Aggregated Data set to Text file
write.table(allData_Aggregated, "tidy.txt", row.names = FALSE, quote = FALSE)






