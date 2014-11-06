library(data.table)
library(dplyr)
library(tidyr)

#   Initialize Variables
dataSetNames <- c("train","test")
subjectFiles <- c("./data/UCI HAR Dataset/train/subject_train.txt","./data/UCI HAR Dataset/test/subject_test.txt")
activityFiles <- c("./data/UCI HAR Dataset/train/y_train.txt","./data/UCI HAR Dataset/test/y_test.txt")
measurementFiles <- c("./data/UCI HAR Dataset/train/x_train.txt","./data/UCI HAR Dataset/test/x_test.txt")
dfData <- data.frame()

#Load Common Data
print("Loading Common Data")

fileName <- "./data/UCI HAR Dataset/features.txt"
features <- read.table(fileName, col.names = c("field","feature"), stringsAsFactors = FALSE)
fieldNames <- features[,2]
rm(features)

fileName <- "./data/UCI HAR Dataset/activity_labels.txt"
rawActivityLabels <- read.table(fileName, col.names = c("ActivityClass","Activity"))
dtActivityLabels <- data.table(rawActivityLabels)
rm(rawActivityLabels)
setkey(dtActivityLabels,ActivityClass)

#Load Measurements

print("Loading Training Data")
for (i in 1:length(dataSetNames)) {
    
    
    fileName <- subjectFiles[i]
    print(paste("Reading Subject File:",fileName))
    rawTrainSubjects <- read.table(fileName,col.names="Subject")
    
    
    fileName <- activityFiles[i]
    print(paste("Reading Subject Activity File:",fileName))
    rawTrainActivities  <- read.table(fileName,col.names = "ActivityClass")
    dtTrainActivities <- data.table(rawTrainActivities)
    rm(rawTrainActivities)
    setkey(dtTrainActivities,ActivityClass)
    
    dtActivityDetail <- merge(dtTrainActivities,dtActivityLabels)
    
    
    fileName <- measurementFiles[i]
    print(paste("Reading Subject Measurement File:",fileName))
    rawTrainData <- read.table(fileName)
    print(paste("Records Read:",as.character(nrow(rawTrainData))))
    
    print("Transforming Data")
    tblTrainData <- tbl_df(rawTrainData)
    rm(rawTrainData)
    
    columnPatterns<- "mean\\(\\)|std\\(\\)"
    subColumns  <- grep(columnPatterns,fieldNames)
    subColumnNames  <- colnames(tblTrainData)[subColumns]
    tblTrainSubSet  <- select(tblTrainData,one_of(subColumnNames))
    rm(tblTrainData)
    
    columnPatterns<- "\\(\\)"
    cleanNames <- gsub(columnPatterns,"",fieldNames)
    cleanSubNames <- cleanNames[subColumns]
    xyzDimensions <-  grep("X$|Y$|Z$",cleanSubNames)
    cleanSubNames[-xyzDimensions] <- paste(cleanSubNames[-xyzDimensions],"-Other",sep="")
    
    colnames(tblTrainSubSet) <- cleanSubNames
    tblTrainSubSet <- mutate(tblTrainSubSet, Activity = dtActivityDetail$Activity, Subject = rawTrainSubjects$Subject)
    rm(rawTrainSubjects)
    dfData <- rbind(dfData,tblTrainSubSet)
    rm(tblTrainSubSet)

    
}

print(paste("Total Data Transformed:",as.character(nrow(dfData))))
save(dfData, file = "data/MergedData.RData")

print("Data Merging Complete")

print("Tidying Data")

tblData <- tbl_df(dfData)

tblData %>%
    gather(sensor_stat_dim,Measure,1:66,-(67:68)) %>%
    separate(sensor_stat_dim,c("Sensor","Statistic","Dimension")) %>%
    select(Subject,Activity,Sensor,Statistic,Dimension,Measure) %>%
    group_by(Subject,Activity,Sensor,Statistic,Dimension) %>%
    summarize(mean(Measure)) %>%
    arrange(Subject,Activity,Sensor,Dimension,Statistic) -> tblTidy

write.table(x = tblTidy,"./data/TidyData.txt", row.name=FALSE)

print("Data Tidying Complete")
print(paste("Total Tidy Data Rows:",as.character(nrow(tblTidy))))

