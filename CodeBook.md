# Code book for analysis

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
