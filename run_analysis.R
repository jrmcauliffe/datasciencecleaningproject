## Download dataset archive and un-pack into local working directory
## tempfilename <- "archive.zip"
## archive <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
##                     destfile=tempfilename, method="curl")
## Cleanup by removing temporary zip archive
## unzip(tempfilename)

## file.remove(tempfilename)

## Manage the filepath for the exctracted zip file
sets <- c("train", "test") 
datadirectoryroot <- "UCI HAR Dataset"

## Load activity labels and format
activitylabelsfilepath <- paste(datadirectoryroot,"/activity_labels.txt", sep="")
activitylabels <- read.table(activitylabelsfilepath)
names(activitylabels) <- c("id", "activity")

## Load feature labels
featurelabelsfilepath <- paste(datadirectoryroot,"/features.txt", sep="")
featurelabels <- read.table(featurelabelsfilepath)[,2]




subjects = do.call("rbind", lapply(paste(datadirectoryroot,"/",sets,"/subject_",sets,".txt", sep=""), read.table))
xvalues <- do.call("rbind", lapply(paste(datadirectoryroot,"/",sets,"/X_",sets,".txt", sep=""), read.table, col.names=featurelabels))
activity <- do.call("rbind", lapply(paste(datadirectoryroot,"/",sets,"/y_",sets,".txt", sep=""), read.table))

## Name subjexts and activity vectors
names(subjects) <- "subject"
names(activity) <- "activity"

## Assign correct activity name to activity id
activity <- lapply(activity[,1], function(x) activitylabels[activitylabels$id==x,2])

all = cbind(subjects, activity, xvalues)
