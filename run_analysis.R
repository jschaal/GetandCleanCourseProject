
library(data.table)
library(dplyr)

fileName <- "./data/UCI HAR Dataset/features.txt"
features <- read.table(fileName, col.names = c("field","feature"), stringsAsFactors = FALSE)
fieldNames <- features[,2]

fileName <- "./data/UCI HAR Dataset/activity_labels.txt"
rawActivityLabels <- read.table(fileName, col.names = c("ActivityClass","Activity"))
dtActivityLabels <- data.table(rawActivityLabels)
rm(rawActivityLabels)
setkey(dtActivityLabels,ActivityClass)

fileName <- "./data/UCI HAR Dataset/train/subject_train.txt"
rawTrainSubjects <- read.table(fileName,col.names="Subject")

fileName <- "./data/UCI HAR Dataset/train/y_train.txt"
rawTrainActivities  <- read.table(fileName,col.names = "ActivityClass")
dtTrainActivities <- data.table(rawTrainActivities)
rm(rawTrainActivities)
setkey(dtTrainActivities,ActivityClass)

dtActivityDetail <- merge(dtTrainActivities,dtActivityLabels)


fileName <- "./data/UCI HAR Dataset/train/x_train.txt"
rawTrainData <- read.table(fileName)

tblTrainData <- tbl_df(rawTrainData)
rm(rawTrainData)

columnPatterns<- "mean\\(\\)|std\\(\\)"
subColumns  <- grep(columnPatterns,fieldNames)
subColumnNames  <- colnames(tblTrainData)[subColumns]
tblSubSet  <- select(tblTrainData,one_of(subColumnNames))
rm(tblTrainData)
columnPatterns<- "\\(\\)"
cleanNames <- gsub(columnPatterns,"",fieldNames)
colnames(tblSubSet) <- cleanNames[subColumns]
tblSubSet <- mutate(tblSubSet, Activity = dtActivityDetail$Activity, Subject = rawTrainSubjects$Subject)

print("Data Creation Compplete")
