# Coursera "Getting and cleaning data": course project

library(reshape2)
library(dplyr)

datadir <- "UCI HAR Dataset"
featuresFile <- "features.txt"
destFile <- "tidyData.txt"

# Generate a normalized feature name
makeFeatureName <- function(fn)
{
    fn = sub( "-mean\\(\\)", "Mean", fn )
    fn = sub( "-std\\(\\)", "Std", fn )
    fn = sub( "-X", "X", fn )
    fn = sub( "-Y", "Z", fn )
    fn = sub( "-Z", "Z", fn )

    return( fn )
}


# Load a table file (without headers) from the data dir
# Optionally, only the given columns 'cols' will be returned
loadDataFile <- function(filename, cols=NULL)
{
    data <- read.table( file.path(datadir, filename), header=FALSE)

    if(! is.null(cols) )
    {
        data <- data[, cols]
    }

    return(data)
}


# Helper func: Load two table files and concat those into one table
loadCombined <- function( file1, file2, cols=NULL )
{
    data1 <- loadDataFile(file1, cols)
    data2 <- loadDataFile(file2, cols)

    data <- rbind(data1, data2)

    return( data )
}


# Load the two measurement data sets and adds the previously read
# subject and activity labelings
loadSamples <- function( features )
{
    data <- loadCombined("train/x_train.txt", "test/x_test.txt", features$cols)
    colnames(data) <- features$names
    data$subject <- as.factor(subjects$V1)
    data$activity <- factor(activities$V1, levels=activityLabels$key, labels=activityLabels$label)

    return( data )
}


# Reorganize the data to have 4 columns containing:
# subject, activity, measurement, value
reformatData <- function(data, features)
{
    #-- create narrow data
    temp <- melt(data, measure.vars = features$names)

    #-- generate the aggreageted data
    temp <- aggregate(temp$value, by=list(subject=temp$subject, activity=temp$activity, measurement=temp$variable), FUN=mean)
    temp <- rename( temp, value = x )

    return( temp )
}


getFeatures <- function()
{
    featuresAll <- read.delim(file.path(datadir, featuresFile), sep=' ', header=FALSE, col.names=c('col', 'name'))
    nc <- nrow(featuresAll)

    featInds <- grepl("-mean\\(\\)|-std\\(\\)", featuresAll$name)
    features <- as.character( (featuresAll$name)[featInds] )
    features <- lapply( features, makeFeatureName )
    fcols <- (featuresAll$col)[featInds]

    fs <- list( names=features, cols=fcols)

    return(fs)
}


activityLabels <- loadDataFile("activity_labels.txt")
colnames(activityLabels) <- c("key", "label")


features <- getFeatures()


subjects <- loadCombined("train/subject_train.txt", "test/subject_test.txt")
activities <- loadCombined("train/y_train.txt", "test/y_test.txt")


# load all data
data <- loadSamples(features)

# tidy-up the data
tidyData <- reformatData(data, features)

# save data
write.table( tidyData, file = destFile, row.name=FALSE)



