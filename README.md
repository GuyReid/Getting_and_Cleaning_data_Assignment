Getting-and-Cleaning-Data-Week-4-Assignment

This repo was created to finish the assignment for week 4 of Getting and Cleaning Data Coursera course. The data is training and testing results from wearable technology

The requirement is as follows:

You should create one R script called run_analysis.R that does the following.

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The Runanalysis.R script achives this by running a routine taking in the following steps:

Download Source data and unzips it

Extracts mean and standard deviation data only based on character vector on the features file grep has been used to filter the strings

Normalises field names by string manipulation using Gsub

merges Test and Train datasets

Aggregates data using Dplyr Group by and Summarise all to average each field

Output data set is tidy.txt
