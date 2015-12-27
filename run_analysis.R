## E. Ho @ Coursera Data Cleaning Course Project 12.2015

run_analysis <- function() {

library(data.table)
library(reshape2)
library(dplyr)

## Read in 561-features names
## Read in test/train 561-feature vectors, merge the data frames
## Rename column names of test/train data frame to names of features.txt
## free memory from temp data frames
	features <- read.table("./features.txt")
	testData <- read.table("./test/X_test.txt")
	trainData <- read.table("./train/X_train.txt")
	allData <- as.data.frame(rbindlist(list(testData, trainData)))
	colnames(allData) <- features$V2
	allData <- allData[,grep("mean|std|Mean", colnames(allData))]
	names(allData) <- gsub("\\(", "", names(allData))
	names(allData) <- gsub("\\)", "", names(allData))
	rm(testData)
	rm(trainData)
	rm(features)

## Read in test/train activity codes, merge data into master data frame
## free memory from temp data frames
	testAct <- read.table("./test/y_test.txt")
	trainAct <- read.table("./train/y_train.txt")
	allAct <- rbindlist(list(testAct, trainAct))
	allData$actcode <- allAct$V1
	rm(testAct)
	rm(trainAct)
	rm(allAct)

## Read in test/train subject IDs, merge data into master data frame
## free memory from temp data frames
	testSub <- read.table("./test/subject_test.txt")
	trainSub <- read.table("./train/subject_train.txt")
	allSub <- rbindlist(list(testSub, trainSub))
	allData$subjectCode <- allSub$V1
	rm(testSub)
	rm(trainSub)
	rm(allSub)

## Read in activities labels, map into master data frame according to activity code (actcode)
	actlabels <- read.table("./activity_labels.txt")
	colnames(actlabels) <- c("actcode","activity")
	allData <- merge(allData, actlabels, sort=FALSE, all=FALSE)
	allData$actcode <- NULL

## Create seprate tidy data frame
	melted <- melt(allData, id.vars=c("subjectCode","activity"))
	summarised <- summarise(group_by(melted, subjectCode, activity, variable), mean=mean(value))
	## write.table(summarised, file="wearing2.txt", row.name=FALSE)
	casted <- dcast(summarised, subjectCode + activity ~ variable, fun.aggregate=mean)
	colnames(casted) <- paste("Avg", colnames(casted), sep=".")
	setnames(casted, old=c("Avg.subjectCode","Avg.activity"), new=c("subjectCode","activity"))
	write.table(casted, file="Average_per_Subject_per_Activity.txt", row.name=FALSE, eol="\n")

## copy-paste for data checking
	## rb <- read.table("Average_per_Subject_per_Activity.txt", header=TRUE)

}
