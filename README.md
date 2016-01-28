# WearableCourseProject
Create tidy data for a wearable dataset as part of a Coursera project

This repo contains course project work for "Getting and Cleaning Data" on Coursera

* There is a single script called run_analysis.R which loads, cleans, subsets, and summzrizes the project data

* There is a single codebook CodeBook.md that describes the background, raw data, processing/transformation, and final variables

The data is originally from an experiment conducted by Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine.  International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

A ZIP file of relevant text files representing experiment outcomes was obtained from the internet.  There were 8 datasets of interest for the course project.  Broadly, the script is designed to achieve four things:

* Read in 8 files that represent test and train data from the "wearable" experiment referenced above
* Bring these 8 files together in to a single data frame with sensible row and column descriptions
* Extract only those measurements (variables) associated to a mean or standard deviation
* Create a tidy data set with the average of each variable for each activity and each subject
