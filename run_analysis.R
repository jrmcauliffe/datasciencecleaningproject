## root directory that zip archive unpacks into
datadirectoryroot <- "UCI HAR Dataset"

## Check to see if we already have archive in current directory
## if not, download and unpack
if (!file.exists(datadirectoryroot)){
  tempfilename <- "archive.zip"
  
  ## Download zip file from web
  archive <- download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                            destfile=tempfilename, method="curl")
  ## un-pack archive
  unzip(tempfilename)
  
  ## Cleanup by removing temporary zip archive  
  file.remove(tempfilename)
}

## Load activity labels
activitylabelsfilepath <- paste(datadirectoryroot,"/activity_labels.txt", sep="")
activitylabels <- read.table(activitylabelsfilepath)
names(activitylabels) <- c("id", "activity")

## Load feature labels
featurelabelsfilepath <- paste(datadirectoryroot,"/features.txt", sep="")
featurelabels <- read.table(featurelabelsfilepath)[,2]

## Load the subject, activity and observation data into pairs of dataframes
## (test, train). The two set of filepaths are calculated using the sets vector.
## These pairs are then row bounnd togther for combined data.

sets <- c("train", "test")

subjects = do.call("rbind", lapply(paste(datadirectoryroot,"/",sets,"/subject_",sets,".txt", sep=""), read.table))
activity <- do.call("rbind", lapply(paste(datadirectoryroot,"/",sets,"/y_",sets,".txt", sep=""), read.table))
allobservations <- do.call("rbind", lapply(paste(datadirectoryroot,"/",sets,"/X_",sets,".txt", sep=""), read.table, col.names=featurelabels))

## Apply the feature labels to our feature data
names(allobservations) <- featurelabels

## Get the subset require for our data (mean and standard deviation columns)
requiredcolumns <-  grep("(std|mean)\\(\\)$", names(allobservations))
requiredobservations <- allobservations[, requiredcolumns]

## Name subjexts and activity vectors
names(subjects) <- "subject"
names(activity) <- "activity"

## Assign correct activity name to activity id
activity <- sapply(activity[,1], function(x) activitylabels[activitylabels$id==x,2])

## Column bind the subjects, activity and observations to create the completed dataset
combined = cbind(subjects, activity, requiredobservations)

## Write the new dataframe out to disk
write.table(combined, "combined.csv", row.names = FALSE)

