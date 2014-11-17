---
title: "CodeBook"
date: "Monday, November 17, 2014"
output: html_document
---

Data Set Code Book: Means of Means and Standard Deviations of Wearable Computing Accelration Data

This data called TidyData.txt represents the means of a number of dimensional measurements captured from an experiement of 30 volunteers utilizing fitness based wearable computing devices.    

The file contains 2,640 summarizations across 6 different variables that represent the subject, sensor, activites, and dimesnion of various acceleration measurements captured by fitness oriented wearble computing devices worned by the 30 different experiement volunteers.


|**Element**            |**Information**
|--------------         |-----------
|**Variable**           |Subject
|**Variable Type**      |Integer
|**Allowable Values**   |1-30 representing the subject who was measured
|**Comments**           |                                                   |                                             
|                       |                                                   |
|**Variable**           |Acivity
|**Variable Type**      |Character
|**Allowable Values**   |WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING
|**Comments**           |One of 6 different activities performed by the subject                                                    |                                             
|                   |                                                   |
|Variable           |Sensor
|Variable Type      |Character
|Allowable Values   |fBodyAcc, fBodyAccJerk, fBodyAccMag, fBodyBodyAccJerkMag, fBodyBodyGyroJerkMag, fBodyBodyGyroMag, fBodyGyro, tBodyAcc, tBodyAccJerk, tBodyAccJerkMag, tBodyAccMag, tBodyGyro, tBodyGyroJerk, tBodyGyroJerkMag, tBodyGyroMag, tGravityAcc, tGravityAccMag
|Comments           |Which of the 17 different sensors the measurement was captured from                                                    |                                             
|                   |                                                   |
|Variable           |Statistic
|Variable Type      |Character
|Allowable Values   |Mean, Std
|Comments           |The statistic (mean or standard deviation (std)) which was captured by the measurement




Study Investigator: Doe
 

Variable:
 
Investigator
 

Variable type:
 
Character
 

Allowable values:
 
Study Investigator: Doe
 

Comments:
    

*Field       Description

==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit? degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 
