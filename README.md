==================================================================
Data Cleaning Course Project
Data manipulation and reformatting based on this dataset:
  Human Activity Recognition Using Smartphones Dataset (Version 1.0)
  by www.smartlab.ws (activityrecognition@smartlab.ws)
E.Ho @ Coursera Data Clearning Course Project 12.2015
==================================================================

About this data set
===================
This dataset takes the test and training data from the Samsung datasets from various data files (txt files), extract only mean and standard deviation readings from the 561-features variables, then generate averages for each variable per test subject per activity.

Raw Triaxial accelerometer and gyroscope readings are not used and not represented in this data set.

About the Samsung data set
==========================
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.


For each record it is provided:
===============================
- Subject Code (subjectcode), an identifier of the subject who carried out the experiment
- activity, the activity carried out by subject for taking measurements
- A 86-feature vector with time and frequency domain mean and standard deviation variables


The Files:
==========

- 'README.md' : 
	this file, header info and explain how run_analysis script works

- 'CodeBook.md' : 
	contains descriptions of variables, data, and any transformations of work for clean up

- 'run_analysis.R': 
	R script that does the data cleaning and forms the resulting dataset
	This script contains one function, run_analysis(workdir=".") 
	This script assumes the original Samsung data set to be in the same directory as this script, inthe following structure:
		./features.txt
		./activity_labels.txt
		./test/X_test.txt
		./test/y_test.txt
		./test/subject_test.txt
		./train/X_train.txt
		./train/y_train.txt
		./train/subject_train.txt
	This script:
		- reads features.txt, and uses the feature names in column(2) as the column names of the X_test.txt, X_train.txt data
		- reads X_test.txt and X_train.txt and combine them into one data frame (allData) with rbindList function
		- assign column names to the above data frame from features.txt
		- keep only columns with names "means","std","Means" and remove rest from the allData data frame. column number decreased from 561 to 86
		- reads y_test.txt and y_train.txt for activity code, add code column to data frame (allData$actcode). This column will be later removed once activity label column (allData$activity) is appended.
		- reads subject_test.txt and subject_train.txt for subject code, add code column to data frame (allData$subjectCode)
		- reads activity_labels.txt and merge descriptive label per activity code to allData$actcode, resulting in new column allData$activity
		- melt (library reshape2) the allData data frame per subjectCode and activity in preparation for average(mean) calculation
		- use summarise (library dplyr) to calculate average(mean) value per subjectCode per activity
		- use dcast (library reshape2) to reshape data frame back to wide format, with each of the 86-feature variable as one column, subjectcode one column, and activity one column. Each row in this new data frame (casted) represents average values per subject per activity for each of the 86-feature variables
		- Prefix all 86-feature column names with "Avg." to indicated these are averages of these values
		- output final data frame (casted) to text file ('Average_per_Subject_per_Activity.txt') with write.table() with row.name=FALSE

- 'Average_per_Subject_per_Activity.txt': 
	this file will be genrated after run_analysis.R is executed


Files required from Samsung data set
====================================
feature and activity labels
- 'features.txt" - contains 561-feature variable names, to be used as column names for new dataset
- 'activity_labels.txt' - contains the activity labels to be map back to activity code provide in Samsung data set
test data
- './test/X_test.txt' - contains the 561-feature variable set, one row per reading
- './test/y_test.txt' - contains the activities label which the subject performed
- './test/subject_test.txt' - contains the subject identifier who performed the activity for measurement
train data
- './train/X_train.txt' - contains the 561-feature variable set, one row per reading
- './train/y_train.txt' - contains the activities label which the subject performed
- './train/subject_train.txt' - contains the subject identifier who performed the activity for measurement

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.
