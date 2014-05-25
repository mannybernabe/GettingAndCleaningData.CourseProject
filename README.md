# README.md
### Getting and Cleaning Data Course Project
### Saturday, May 24, 2014


## Intro
* Firstly, please assure that in your working directory you have the file "UCI HAR Dataset" obtain from the zip folder found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip .  The "HCI HAR Dataset" folder contains all of the folders that the script will be reading and utilizing.  The script name is run_analysis.R

## 1) Merges the training and the test sets to create one data set.
* The script first reads the relevant file from the main folder ("UCI HAR Dataset"):
    * UCI HAR Dataset/test/X_test.txt
    * UCI HAR Dataset/test/Y_test.txt
    * UCI HAR Dataset/test/subject_test.txt
    * UCI HAR Dataset/train/X_train.txt
    * UCI HAR Dataset/train/Y_train.txt
    * UCI HAR Dataset/train/subject_train.txt

* Broadly speaking, the "X" data above pertains to various measurements of activity as measured by a Smartphone.   "Y" data pertains to the label of activity of the subject ("subject" data above) at the time of measurement.

* After reading in the data, the script will proceed to combine data from the train and test files into merge.df.  Thereafter, merge.df will have its names updated.  Columns 1 and 2 will be labeled "subject" and "activity" and columns 3 through 563 will be labeled with variable names obtained from UCI HAR Dataset/features.txt .

## 2) Extracts only the measurements on the mean and standard deviation for each measurement.

* Next, the script selects from column names in merge.df that contain at least one of the follow terms: "subject" "activity" "mean" "std".  The remainder columns are dropped.

## 3) Uses descriptive activity names to name the activities in the data set
* Next the activity column is passed more readable labels, i.e. "walking", "sitting", etc. using a grep() function. 

## 4) Appropriately labels the data set with descriptive activity names.
* Thereafter, the script modifies the measure variables to exclude parentheses and operator signs ("-").  Additionally, all the letters are converted to lower case.  For example, before: tBodyAcc-mean()-X ; after: tbodyaccmeanx . 

## 5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* The script then "melts" merge.df and "casts" to compute the pair-wise means for id variables "subject" and "activity".  The new data frame is called avg.df, and holds means for all the combinations of subjects and activities.  

* Lastly, we write the ave.df as a text, tab-delinated file called "Averages for Subjects and Activities.txt" to the working directory.

## Fin
