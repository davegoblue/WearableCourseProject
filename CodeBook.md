# Code book for analysis

## Data Sources and Background
Data for this project is downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data is based on work originally conducted by:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

See http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones for further details

The downloaded data is a ZIP file which creates a folder "UCI HAR Dataset".  There are two sub-folders, "test" and "train".  For purposes of this project, we are asked to ignore Inertial Signals, a further sub-folder contained under test/ and train/

The main folder of the download includes a README and a features_info.txt that describes the various measurements taken.  There are also 8 space-delimited text files (no headers) of relevance for the requested project work:

* test/X_test.txt has 2947 rows and 561 columns, representing 561 measurements taken at various times for subject-activity
* test/y_test.txt has 2947 rows and 1 column, containing the activity code associated to each row in X_test
* test/subj_test.txt has 2947 rows and 1 column, containing the subject associated to each row in X_test
* train/X_train.txt has 7352 rows and 561 columns, representing 561 measurements taken at various times for subject-activity
* train/y_train.txt has 7352 rows and 1 column, containing the activity code associated to each row in X_train
* train/subj_train.txt has 7352 rows and 1 column, containing the subject associated to each row in X_train
* activity_labels.txt has 6 rows and 2 columns, containing a map from activity number to activity description
* features.txt has 561 rows and 2 columns, containing a map from column number to column description

## Data Processing and Transformations
The script was run on 27-Jan-2016 using 64-bit R 3.2.3 on a Windows 7 machine.  The package dplyr is required.

The overall processing is to load these raw data files and then piece them together like a puzzle.  Specifically, the following actions are performed in the script:

* Load the raw data files as space-delimited text and confirm that dimensions are as expected
* Use features to label the columns of X_test and X_train
* Create useTestData by binding subj_test (variable subject), y_test (variable activity id), and X_test (main data)
* Create useTrainData by binding subj_train (variable subject), y_train (variable activity id), and X_train (main data)
* Create useData by row-binding useTestData, useTrainData
* Create an easy to read activity name by mapping activityID in useData against the activity_labels file

The 561 measasurement columns are then analyzed for whether they contain the string mean() or std().  There are 66 columns that meet this "or" criteria, and the other 495 measurement columns are discarded.

For simplicity of reading, measurements starting with tBody are renamed as timeBody, measurements starting with fBody are renamed as freqBody, and measurements starting with tGravity are renamed as timeGravity.  The () were extracted out of the variable names, and the dash(-) were converted to underscore(_) for easier use without requiring quoting.  The _ were left in the variable names since timeBodyAcc_mean_X is more readable than timeBodyAccmeanX.

Lastly, a dataset tidyData is creating using group_by(subject,activity) and summzrize_each(funs(mean)) using dplyr.  This final dataset contains 180 rows (30 subjects x 6 activities) and 68 columns (subject, activity, 66 mean or std measurements).  The data displayed in the measurement columns is the mean for that measurement across multiple raw records for subject and activity

## Variable in the final tidyData
