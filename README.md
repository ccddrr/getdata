# getdata
Getting and Cleaning Data: course project

## Summary

This repository contains my own solution to the course project of the
coursera course "Getting and Cleaning data".

It essentially contains an GNU R script called "run_analysis.R". This script is
part of the contribution to the task.

Running this script first loads the referenced original data sets, merges all data,
reorganizes and aggregates the data. Finally, the tidied data get written into
a destination file called "tidyData.txt".

The original data sets are expected to be besides the script, namely in a sub-folder
called "UCI HAR Dataset" and having the sub-sub-folder and file structure as
when unzipping the data archive as mentioned in the original task project description.


## How the script works

The script "run_analysis.R" first defines a source folder for the original data
to be loaded ("datadir"). Furthermore, the name of the destination file for the
tidy data is defined ("destFile").

Then, some support functions are defined. These include functions for loading
the data from the datadir and the original feature names, cleaning up column names,
and tidiying-up the data.

Subsequently, the activity names are loaded and the features filtered for the mean
and std columns. Then, the activity labellings and the subject labellings are
loaded. Following, the measurement data are loaded (including the merge of train
and test sets, and selecting the desired columns, and adding the subject and
activity columns).

Finally, the data set is reorganized and written to the destination file.


## Codebook of generated tidy data

The resulting tidy data is in a narrow format. This means, the tidy data contains
the 4 columns "subject", "activity", "measurement", and "value".

While the first 3 columns are factors, the "value" column is numeric. The factor
columns "activity" and "measurement" are given as verbose character strings in
the file.

The factor "subject" has 30 levels ("1"" to "30") naming the participating subjects.

The factor "activity" contains 6 levels describing the activity label for each
measurement. The labels are named:

- "WALKING"
- "WALKING_UPSTAIRS"
- "WALKING_DOWNSTAIRS"
- "SITTING"
- "STANDING"
- "LAYING""

The factor column "measurement" has 66 levels describing measurement features.
Every feature was generated from raw sampling data (which is not further
explicated here). The 66 features are named:

 [1] "tBodyAccMeanX"            "tBodyAccMeanZ"           
 [3] "tBodyAccMeanZ"            "tBodyAccStdX"            
 [5] "tBodyAccStdZ"             "tBodyAccStdZ"            
 [7] "tGravityAccMeanX"         "tGravityAccMeanZ"        
 [9] "tGravityAccMeanZ"         "tGravityAccStdX"         
[11] "tGravityAccStdZ"          "tGravityAccStdZ"         
[13] "tBodyAccJerkMeanX"        "tBodyAccJerkMeanZ"       
[15] "tBodyAccJerkMeanZ"        "tBodyAccJerkStdX"        
[17] "tBodyAccJerkStdZ"         "tBodyAccJerkStdZ"        
[19] "tBodyGyroMeanX"           "tBodyGyroMeanZ"          
[21] "tBodyGyroMeanZ"           "tBodyGyroStdX"           
[23] "tBodyGyroStdZ"            "tBodyGyroStdZ"           
[25] "tBodyGyroJerkMeanX"       "tBodyGyroJerkMeanZ"      
[27] "tBodyGyroJerkMeanZ"       "tBodyGyroJerkStdX"       
[29] "tBodyGyroJerkStdZ"        "tBodyGyroJerkStdZ"       
[31] "tBodyAccMagMean"          "tBodyAccMagStd"          
[33] "tGravityAccMagMean"       "tGravityAccMagStd"       
[35] "tBodyAccJerkMagMean"      "tBodyAccJerkMagStd"      
[37] "tBodyGyroMagMean"         "tBodyGyroMagStd"         
[39] "tBodyGyroJerkMagMean"     "tBodyGyroJerkMagStd"     
[41] "fBodyAccMeanX"            "fBodyAccMeanZ"           
[43] "fBodyAccMeanZ"            "fBodyAccStdX"            
[45] "fBodyAccStdZ"             "fBodyAccStdZ"            
[47] "fBodyAccJerkMeanX"        "fBodyAccJerkMeanZ"       
[49] "fBodyAccJerkMeanZ"        "fBodyAccJerkStdX"        
[51] "fBodyAccJerkStdZ"         "fBodyAccJerkStdZ"        
[53] "fBodyGyroMeanX"           "fBodyGyroMeanZ"          
[55] "fBodyGyroMeanZ"           "fBodyGyroStdX"           
[57] "fBodyGyroStdZ"            "fBodyGyroStdZ"           
[59] "fBodyAccMagMean"          "fBodyAccMagStd"          
[61] "fBodyBodyAccJerkMagMean"  "fBodyBodyAccJerkMagStd"  
[63] "fBodyBodyGyroMagMean"     "fBodyBodyGyroMagStd"     
[65] "fBodyBodyGyroJerkMagMean" "fBodyBodyGyroJerkMagStd" 


The numeric column "value" gives the mean of *all* valid individual measurement
samples for one specific subject while doing one specific avtivity and for one
measurement feature.

Every subject was measured for each activity. Thus, the number of rows of the
tidy data is 11880 = 30 * 66 * 6






