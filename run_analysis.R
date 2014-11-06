library(data.table)
library(dplyr)

#Load training data
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
tblTrainSubSet  <- select(tblTrainData,one_of(subColumnNames))
rm(tblTrainData)

columnPatterns<- "\\(\\)"
cleanNames <- gsub(columnPatterns,"",fieldNames)
cleanSubNames <- cleanNames[subColumns]
xyzDimensions <-  grep("X$|Y$|Z$",cleanSubNames)
cleanSubNames[-xyzDimensions] <- paste(cleanSubNames[-xyzDimensions],"-Other",sep="")

colnames(tblTrainSubSet) <- cleanSubNames
tblTrainSubSet <- mutate(tblTrainSubSet, Activity = dtActivityDetail$Activity, Subject = rawTrainSubjects$Subject)

#Load testing data

fileName <- "./data/UCI HAR Dataset/test/subject_test.txt"
rawTestSubjects <- read.table(fileName,col.names="Subject")

fileName <- "./data/UCI HAR Dataset/test/y_test.txt"
rawTestActivities  <- read.table(fileName,col.names = "ActivityClass")
dtTestActivities <- data.table(rawTestActivities)
rm(rawTestActivities)
setkey(dtTestActivities,ActivityClass)

dtActivityDetail <- merge(dtTestActivities,dtActivityLabels)


fileName <- "./data/UCI HAR Dataset/test/x_test.txt"
rawTestData <- read.table(fileName)

tblTestData <- tbl_df(rawTestData)
rm(rawTestData)

tblTestSubSet  <- select(tblTestData,one_of(subColumnNames))
#rm(tblTestData)
colnames(tblTestSubSet) <- cleanSubNames
tblTestSubSet <- mutate(tblTestSubSet, Activity = dtActivityDetail$Activity, Subject = rawTestSubjects$Subject)

tblData <-  merge(tblTrainSubSet,tblTestSubSet,all = TRUE)

#write.table(x = tblData,"./data/MergedData.txt", row.name=FALSE)
save(tblData, file = "data/MergedData.RData")

print("Data Creation Compplete")
