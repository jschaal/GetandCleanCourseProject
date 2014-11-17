Get and Clean Course Project
============================

The purpose of this project is to to prepare tidy data set from a summary of raw data produced during measurement experiments of fitness oriented wearable computing devices produced by Samsung.

The raw data contains numerous measurements of **three** dimensional acceleration from **six** different activities conducted on **30** experiment subjects in **two** conditions, *training* and *testing*.   The raw data consists of **68** measurements but the data we are interested in is only for those measurements which are **mean** and **standard deviation** calculations of specific dimensional accelerations.

The resulting tidy data is produced by a script called **run_analysis.R**.   The script produces a number of out puts, stored in the data directory of the working directory, including an R formatted extract called **MergedData.RData** and the final **long formatted** tidy dataset in standard R text format called **TidyData.txt**.

The script combines a number of different raw data sets that include separate information, such as the index of the test subject and the type of activity being measured. It  supplies appropriate field labels then produces a tidy data set in long format of the means of any included measurement of mean and standard orientation data.

The script utilizes a number of R libraries and data types, including *data.frames*, *data.tables* and *dplyr oriented tables*.

###The specific steps of the script are:

1.  Read the common variable names (features)  of the raw measurement data into a data.frame
2.  Read common activity names associated with the raw measurement data into a data.frame
3.  Convert data.frames to data table to allow for easier merging of data with raw data
4.  Read any number of raw Measurement files (in this case, 2, one for test data and one for training data)
    +   Raw the raw raw subject file associated with raw data measurements
    +   Read raw activity file associated with raw data measurements
    +   Convert data.frames to data table to allow for easier merging of data with raw data
    +   Merge activity labels with associated activities
    +   Read raw measurement data
    +   Convert data.frame to dplyr table for easier manipulation
    +   identify and select only those columns that capture mean and standard deviations
    +   Rename columns that do not reference specific x/y/z dimensions as other
    +   Subset data to include only those measurements that pertain to mean and standard deviation measurements
    +   Apply clean column names to table
    +   Combine activity and subject details with raw data
    +   Append processed data to consolidated processed data frame
5. Save raw transformed data 
6. Perform a series of dplyr orient transformations to convert untidy data to summarized, long formatted tidy data
7.  Write final tidy data extract file

 
