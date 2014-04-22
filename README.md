## Coursera 'Getting and Cleaning Data' peer assessment project

### 1. Introduction

The purpose of this assignment is to take an existing dataset and produce an R script to merge all of the relevant component parts into a master data set. From this data, another subset of data is to be produced which adheres to tidy data princples. The assignment goals are stated as

> Create one R script called run_analysis.R that does the following. 

> 1.    Merges the training and the test sets to create one data set.
> 2.    Extracts only the measurements on the mean and standard deviation for each measurement. 
> 3.    Uses descriptive activity names to name the activities in the data set
> 4.    Appropriately labels the data set with descriptive activity names. 
> 5.    Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

> Create a file README.md with a description of the process used and a file CodeBook.md with a description of the data in the dataset.


### 2. Description of the data

The dataset is built from recording the motion of 30 subjects undertaking 6 different activities, using the inertial sensors within a modern smartphone. 

The data from the experiment is made available as two subsets (train and test), for the purposes of machine learning applications. For our requirements, the two datasets will be merged into one. The data archive also contains the original inertial sensor readings that were used to create the data. From the [site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) 

>The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

For the sake of this analysis, it is assumed that we only require this derived data.

Information on the data created buy both parts of the script can be found in the CodeBook.md document. 

### 3. Description of the script

The script run_analysis.R is intended to be run standalone in the current working directory. The steps it goes through are

1. Check to see whether the archive containing the data has been downloaded/unpacked already, if not do so.
2. Load the activity labels from a text file in the archive (activity_labels.txt). These are the various activities that correspond with the activity ids in the data (Walking, Sitting etc.).
3. Load the feature labels from a text file in the archive (features.txt). These are the labels for the different derived observed varibles in our dataset.
4. Load and merge the subject, activity and observation data from test and train subsets (Part 1 of requirements).
5. Add the activity labels from step 2 to the activity data  (Part 3 of requirements).
6. Add the feature labels to our feature data (Part 4 of requirements).
7. Find the subset of our feature data to match our initial requirement, those features that are mean or standard deviations of measurements Part 2 of requirements). 
8. Join the subject, activity and feature data into a single dataset and save to disk (combined.txt).
9. Melt and recast the data to give the average of each feature for every combination of subject and activity (Part 5 of requirements). 
10. Save this tidy dataset to disk (tidy.txt).

Each of these steps is documented in the script itself.

### 4. Notes

* Part 2 of the requirements was taken to mean all variables that contain either std() or mean(), including the component vector observations
* Assuming Part 4 of the requirements should read 'Appropriately labels the data set with descriptive *feature* names'

