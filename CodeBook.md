==================================================================
Data Cleaning Course Project
Data manipulation and reformatting based on this dataset:
  Human Activity Recognition Using Smartphones Dataset (Version 1.0)
  by www.smartlab.ws (activityrecognition@smartlab.ws)
E.Ho @ Coursera Data Clearning Course Project 12.2015
==================================================================

More information in README.md

For each observation it is provided:
===================================
- Subject Code (subjectcode)
	identifier of the subject who carried out the experiment

- activity
	the activity carried out by subject for taking measurements

- Avg.* (86 columns)
	each of these 86 columns contains a time or frequency domain mean or standard deviation variables, averaged per subject per activity



Transformation and clean up: (Also detailed in README.md)
===========================
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

- prefix all 86-feature column names with "Avg_" to indicated these are averages of these values
