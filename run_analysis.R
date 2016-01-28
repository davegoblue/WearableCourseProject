## This script creates a tidy data set as part of a "Getting and Cleaning Data" module on Coursera

## Data based on: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
## Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 
## International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

## Broadly, this script is to achieve the following
## A) Read in 8 files that represent test and train data from the "wearable" experiment referenced above
## B) Bring these 8 files together in to a single data frame with sensible row and column descriptions
## C) Extract only those measurements (variables) associated to a mean or standard deviation
## D) Create a tidy data set with the average of each variable for each activity and each subject

## This function is to simplify reading in all my text files as they are all in the same format
readText <- function(filePath) {
    temp <- read.table(filePath,header=FALSE,sep="",stringsAsFactors=FALSE)
}

## This function is to check that dimensions are OK - separated this since it is called twice
checkDims <- function(mainData,activityCol,subjCol,featureRow,typeFile="too lazy") {
    if (!identical(nrow(mainData),nrow(activityCol),nrow(subjCol))) {
        stop(paste0("ERROR: Aborting due to inconsistent rows for ",typeFile))
    } else if (!identical(ncol(activityCol),ncol(subjCol),1)) {
        stop(paste0("ERROR: Aborting due to 2+ columns for activity or subject in ",typeFile))
    } else if (!identical(ncol(mainData),nrow(featureRow))) {
        stop(paste0("ERROR: Aborting due to inconsistent feature columns for ",typeFile))
    } else {
        print(paste0("Dimensions OK for ",typeFile,": ",nrow(mainData)," by ",ncol(mainData)))
    }
}


### Step A - read in all the files (on my computer, they are in fileDirMain and then \test and \train)
## fileDirMain <- "C:\\Users\\Dave\\Documents\\Personal\\Learning\\Coursera\\2016 01 - Data Science\\Module 03 - Getting and Cleaning Data\\Course Project Data\\UCI HAR Dataset"
## Recasting this to home directory as per submission request

fileDirMain <- getwd()

featureData <- readText(paste0(fileDirMain,"\\features.txt"))
activityLabels <- readText(paste0(fileDirMain,"\\activity_labels.txt"))

xTestData <- readText(paste0(fileDirMain,"\\test\\X_test.txt"))
yTestData <- readText(paste0(fileDirMain,"\\test\\y_test.txt"))
subjTestData <- readText(paste0(fileDirMain,"\\test\\subject_test.txt"))

xTrainData <- readText(paste0(fileDirMain,"\\train\\X_train.txt"))
yTrainData <- readText(paste0(fileDirMain,"\\train\\y_train.txt"))
subjTrainData <- readText(paste0(fileDirMain,"\\train\\subject_train.txt"))


## Confirm that dimensions are OK for later combinations
checkDims(xTestData,yTestData,subjTestData,featureData,"test files")
checkDims(xTrainData,yTrainData,subjTrainData,featureData,"train files")


## Step B: Bring these 8 files together in to a single data frame
## B1: Attach featureData to the relevant columns of xTestData and yTestData
if (ncol(featureData)!=2) {
    stop("Expected featureData to be a 2-column file, aborting")
} else if (sum(featureData[,1]!=1:nrow(featureData))>0) {
    stop("Expected that featureData would be ordered 1:N with no repeats, aborting")
}

for (ctr in 1:nrow(featureData)) { colnames(xTestData)[ctr] <- featureData[ctr,2] }
for (ctr in 1:nrow(featureData)) { colnames(xTrainData)[ctr] <- featureData[ctr,2] }


## B2:  Bind the new columns for subjectID and activityID at the front of the frame
useTestData <- cbind(subjTestData,yTestData,xTestData)
colnames(useTestData)[1] <- "subjectID"
colnames(useTestData)[2] <- "activityID"

useTrainData <- cbind(subjTrainData,yTrainData,xTrainData)
colnames(useTrainData)[1] <- "subjectID"
colnames(useTrainData)[2] <- "activityID"


## B3: Put the two data sets together, with a descriptor for thir source
useTestData$source <- "Test"
useTrainData$source <- "Train"
useData <- rbind(useTestData,useTrainData)


## B4: Attach activity names from the activityLabels file
if (ncol(activityLabels)!=2) {
    stop("Expected a 2-column file for activity labels, aborting")
} else if (sum(unique(useData$activityID)[order(unique(useData$activityID))]!=activityLabels[,1])>0) {
    stop("There is a mismatch between the activity IDs in useData and activityLabels, aborting")
}

for ( ctr in 1:nrow(useData) ) { 
    useData$activityName[ctr] <- activityLabels[activityLabels[,1]==useData$activityID[ctr],2] 
}


## Step C: Extract only those columns associated to mean() or std(), plus subject and activityName
myCol <- grepl("[Mm][Ee][Aa][Nn]\\(\\)",colnames(useData)) | grepl("[Ss][Tt][Dd]\\(\\)",colnames(useData))
analysisData <- cbind(useData$subjectID, useData$activityName, useData[,myCol])

## Given the first two columns more meaningful names
colnames(analysisData)[1:2] <- c("subject","activity")

## Strip the () from the variable names
## The variables only start three ways: tBody -> timeBody, tGravity -> timeGravity, fBody -> freqBody
## Leave in the - but convert to _ as they  make the variable names readable . . . 
## timeBody_mean_X vs. timeBodymeanX
origNames <- colnames(analysisData)
modNames <- gsub("\\()","",origNames)
modNames <- gsub("-","_",modNames)
modNames <- sub("tBody","timeBody",modNames)
modNames <- sub("fBody","freqBody",modNames)
modNames <- sub("tGravity","timeGravity",modNames)
colnames(analysisData) <- modNames


## Step D: Summarize these to be unique by Subject-Activity (use dplyr with group_by and summarise_each)
print(paste0("Prior to summarizing, analysisData is ",nrow(analysisData)," by ",ncol(analysisData)))

library(dplyr)
tidyData <- analysisData %>% group_by(subject,activity) %>% summarize_each(funs(mean))

print(paste0("After summarizing, tidyData is ",nrow(tidyData)," by ",ncol(tidyData)))
write.csv(tidyData,"tidyData.csv",row.names=FALSE)
write.table(tidyData,"tidyData.txt",row.names=FALSE)