---
title: "CodeBook"
date: "Monday, November 17, 2014"
output: html_document
---

##Introduction
Data Set Code Book: Means of Means and Standard Deviations of Wearable Computing Acceleration Data

This data called TidyData.txt represents the means of a number of dimensional measurements from a series of acceleration sensors (accelerometers and gyroscopes) captured from an experiment of 30 volunteers utilizing fitness based wearable computing devices.    

The file contains **2,640** of summarizations of the mean and standard deviation calculations across **30** subjects, **6** different activities and **17** different sensors that mean of acceleration measurements captured by fitness oriented wearble computing devices worn by the experiments participants.

The underlying raw data was from the dataset **Human Activity Recognition Using Smartphones Dataset
Version 1.0** by  Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.  A full description of the raw dataset and the data itself can be obtained from  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Methodology

The file TidyData.txt represents a series of transformations and summarizations of the underlying raw data.  The data is presented in Long Format and consists of the mean of of the measurement of selected captured data associated with one of 17 sensors measured in the experiment, grouped by subject, activity, the measured dimension, the sensor measured and that statistic captured.   The raw data consists of 561 sensor/dimension/statistic combinations.   This data sample is restricted to include only those measurements from the sensors that provided mean and standard deviation data.  Variables were included if and only if the underlying raw variable name contained a refernece to a mean or standard deviation statistic (std).

Of 561 variables in the raw data, 68 variables provided mean and standard deviation information for different sensors for different physical dimensions.  This data was further transformed so all measurements were presented in long form, with each row of the data source representing the mean of a single measurement, as a function of the subject, activity, sensor, statistic and dimension of the objservation.  different measures, which are a combination of an underlying sensor and a specific statistical calculation.   

##Variable Descriptions
|**Element**            |**Information**
|--------------         |-----------
|**Variable**           |Subject
|**Variable Type**      |Integer
|**Allowable Values**   |1-30 representing the subject who was measured
|**Comments**           |                                                   |                                             
|                       |                                                   |
|**Variable**           |Activity
|**Variable Type**      |Character (18)
|**Allowable Values**   |WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING
|**Comments**           |One of 6 different activities performed by the subject                                                    |                       |                                                   |
|**Variable**           |Sensor
|**Variable Type**      |Character (20)
|**Allowable Values**   |fBodyAcc, fBodyAccJerk, fBodyAccMag, fBodyBodyAccJerkMag, fBodyBodyGyroJerkMag, fBodyBodyGyroMag, fBodyGyro, tBodyAcc, tBodyAccJerk, tBodyAccJerkMag, tBodyAccMag, tBodyGyro, tBodyGyroJerk, tBodyGyroJerkMag, tBodyGyroMag, tGravityAcc, tGravityAccMag
|**Comments**           |Which of the 17 different sensors the measurement was captured from  
|                       |                                                   |
|**Variable**           |Statistic
|**Variable Type**      |Character (4)
|**Allowable Values**   |Mean, Std
|**Comments**           |The statistic, mean or standard deviation (std), of the measurement
|                       |                                                   |
|**Variable**           |Dimension
|**Variable Type**      |Character (5)
|**Allowable Values**   |X, Y, Z, Other
|**Comments**           |The physical orientation (axis) of the sensor used to calculate the measurement. Sensors with no X, Y, or Z axis are labeled as Other.
|                       |                                                   |
|**Variable**           |Mean
|**Variable Type**      |Double
|**Allowable Values**   |Numeric (Double)
|**Comments**           |The mean of the measurement for the given subject, activity, sensor, statistic and dimension in standard gravity units g.

# Study Design

*The follow is the study design information from the raw data set:*

Human Activity Recognition Using Smartphones Dataset
Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universit? degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:

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

'Notes: '
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

'License:'
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
