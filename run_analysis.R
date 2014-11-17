library(data.table)
library(dplyr)
library(tidyr)

#   Initialize Variables
dataSetNames <- c("train","test")
subjectFiles <- c("./data/UCI HAR Dataset/train/subject_train.txt","./data/UCI HAR Dataset/test/subject_test.txt")
activityFiles <- c("./data/UCI HAR Dataset/train/y_train.txt","./data/UCI HAR Dataset/test/y_test.txt")
measurementFiles <- c("./data/UCI HAR Dataset/train/x_train.txt","./data/UCI HAR Dataset/test/x_test.txt")
dfData <- data.frame()

#   Load Common Data
print("Loading Common Data")

#   Read common variable names (features)  of the raw measurement data
fileName <- "./data/UCI HAR Dataset/features.txt"
features <- read.table(fileName, col.names = c("field","feature"), stringsAsFactors = FALSE)
fieldNames <- features[,2]
rm(features)

#   Read common activity names assocaited with the raw measurement data
fileName <- "./data/UCI HAR Dataset/activity_labels.txt"
rawActivityLabels <- read.table(fileName, col.names = c("ActivityClass","Activity"))

#   Convert data.frame to data table to allow for easier merging of data with raw data
dtActivityLabels <- data.table(rawActivityLabels)
rm(rawActivityLabels)
setkey(dtActivityLabels,ActivityClass)

#   Load Raw Measurement Data Files

print("Loading Training Data")
for (i in 1:length(dataSetNames)) {
    
    #   Read raw subject file associated with raw data measurements
    fileName <- subjectFiles[i]
    print(paste("Reading Subject File:",fileName))
    rawTrainSubjects <- read.table(fileName,col.names="Subject")
    
    #   Read raw activity file associated with raw data measurements
    fileName <- activityFiles[i]
    print(paste("Reading Subject Activity File:",fileName))
    rawTrainActivities  <- read.table(fileName,col.names = "ActivityClass")
    
    #   Convert data.frame to data table to allow for easier merging of data with raw data
    dtTrainActivities <- data.table(rawTrainActivities)
    rm(rawTrainActivities)
    setkey(dtTrainActivities,ActivityClass)

    #   Merge activity lables with assocaited actiivities
    dtActivityDetail <- merge(dtTrainActivities,dtActivityLabels)
    
    #   Read raw measurement data
    fileName <- measurementFiles[i]
    print(paste("Reading Subject Measurement File:",fileName))
    rawTrainData <- read.table(fileName)
    print(paste("Records Read:",as.character(nrow(rawTrainData))))

    #   Convert data.frame to dplyr table for easier manipulation
    print("Transforming Data")
    tblTrainData <- tbl_df(rawTrainData)
    rm(rawTrainData)
    
    #   identify and select only those columns that capture mean and standard deviations
    columnPatterns<- "mean\\(\\)|std\\(\\)"
    subColumns  <- grep(columnPatterns,fieldNames)
    subColumnNames  <- colnames(tblTrainData)[subColumns]
    tblTrainSubSet  <- select(tblTrainData,one_of(subColumnNames))
    rm(tblTrainData)

    #   Rename columns that do not reference specifc x/y/z dimensions as other
    columnPatterns<- "\\(\\)"
    cleanNames <- gsub(columnPatterns,"",fieldNames)
    cleanSubNames <- cleanNames[subColumns]
    xyzDimensions <-  grep("X$|Y$|Z$",cleanSubNames)
    cleanSubNames[-xyzDimensions] <- paste(cleanSubNames[-xyzDimensions],"-Other",sep="")

    #   Apply clean column names to table
    colnames(tblTrainSubSet) <- cleanSubNames

    #   Combine activity and subject details with raw data
    tblTrainSubSet <- mutate(tblTrainSubSet, Activity = dtActivityDetail$Activity, Subject = rawTrainSubjects$Subject)
    rm(rawTrainSubjects)

    #   Append processed data to consolidated processed data frame
    dfData <- rbind(dfData,tblTrainSubSet)
    rm(tblTrainSubSet)

    
}

#   Save raw transformed data 
print(paste("Total Data Transformed:",as.character(nrow(dfData))))
save(dfData, file = "data/MergedData.RData")

print("Data Merging Complete")

#   Start tidy data routines  
print("Tidying Data")

tblData <- tbl_df(dfData)

#   Start tidy data routines  
#   Conver wide formatted data to long format
#   group and summarize statistics
tblData %>%
    gather(sensor_stat_dim,Measure,1:66,-(67:68)) %>%
    separate(sensor_stat_dim,c("Sensor","Statistic","Dimension")) %>%
    select(Subject,Activity,Sensor,Statistic,Dimension,Measure) %>%
    group_by(Subject,Activity,Sensor,Statistic,Dimension) %>%
    summarize(mean(Measure)) %>%
    arrange(Subject,Activity,Sensor,Dimension,Statistic) -> tblTidy

#   Write final tidy data extract file
write.table(x = tblTidy,"./data/TidyData.txt", row.name=FALSE)

print("Data Tidying Complete")
print(paste("Total Tidy Data Rows:",as.character(nrow(tblTidy))))

