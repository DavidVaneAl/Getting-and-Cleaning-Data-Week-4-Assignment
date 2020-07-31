library(dplyr)
library(data.table)

##Downloading and reading data
#Read link
    Archive_Zip <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    #Download data
    download.file(Archive_Zip,destfile = "data.zip")
    #Unzip archive
    unzip("data.zip")
    #select WD
    setwd("C:/Users/david/Desktop/UCI HAR Dataset")
    

##Read all files (.txt) and naming the columns (variables)
    #Features
    features <- read.table("features.txt")
    colnames(features) = c("n","functions")
    #Activities
    activities <- read.table("activity_labels.txt")
    colnames(activities) = c("code", "activity")
    #Subject test
    subjtest <- read.table("test/subject_test.txt")
    colnames(subjtest) = c("subject")
    #X test
    xtest <- read.table("test/X_test.txt")
    colnames(xtest) = c(features$functions)
    #Y test
    ytest <- read.table("test/y_test.txt")
    colnames(ytest) = c("code")
    #Subject train
    subjtrain <- read.table("train/subject_train.txt")
    colnames(subjtrain) = c("subject")
    #X train
    xtrain <- read.table("train/X_train.txt")
    colnames(xtrain) = c(features$functions)
    #Y train
    ytrain <- read.table("train/y_train.txt")
    colnames(ytrain) = c("code")

##Merging data in rows for every variable (x, y, subject) in every function (train, test)
    xvalue <- rbind(xtrain, xtest)
    yvalue <- rbind(ytrain, ytest)
    subjectvalue <- rbind(subjtrain, subjtest)

##Merging data in columns with last values merged
    subdata <- cbind(subjectvalue, yvalue, xvalue)
    
##Reading merged data and selected necessary data 
    data <- subdata %>% select(subject, code, contains("mean"), contains("std"))
    data$code <- activities[data$code, 2]

##Replacing names to different variables of the list with gsub()
##Variable's names were taken from (features_info.txt)
    names(data)[1] = "Subject"
    names(data)[2] = "Activity"

#Activities
    names(data) <- gsub("Acc", "acceleration_", names(data))
    names(data) <- gsub("BodyBody", "Body", names(data))
    names(data) <- gsub("Body", "body_", names(data))
    names(data) <- gsub("Gravity", "gravity_", names(data))
    names(data) <- gsub("Jerk", "jerk_", names(data))
    names(data) <- gsub("Gyro", "angular_speed_", names(data))
    names(data) <- gsub("Mag", "magnitude_", names(data))
    names(data) <- gsub("^t", "Time_domain_", names(data))
    names(data) <- gsub("^f", "Frequency_domain_", names(data))

#Features
    names(data) <- gsub("mean()", "Mean", names(data))
    names(data) <- gsub("std()", "Standard_deviation", names(data))
    names(data) <- gsub("meanfreq()", "Mean_frequency", names(data))
    names(data) <- gsub("angle", "Angle", names(data))
    names(data) <- gsub("gravity", "Gravity", names(data))
    names(data) <- gsub("max()", "Maximum", names(data))
    names(data) <- gsub("min()", "Minimum", names(data))
    names(data) <- gsub("sma()", "Signal_magnitude_area_(SMA)", names(data))
    names(data) <- gsub("mad()", "Median_absolute_deviation_(MAD)", names(data))
    names(data) <- gsub("energy()", "Energy_measure", names(data))
    names(data) <- gsub("iqr()", "Interquartile_range_(IQR)", names(data))
    names(data) <- gsub("entropy()", "Signal_entropy", names(data))
    names(data) <- gsub("arCoeff()", "Autoregression_coefficient_(ArCoeff)", names(data))
    names(data) <- gsub("correlation()", "Correlation", names(data))
    names(data) <- gsub("skewness()", "Skewness", names(data))
    names(data) <- gsub("kurtosis()", "Kurtosis", names(data))
    names(data) <- gsub("bandsEnergy", "Bands Energy", names(data))
    names(data) <- gsub("maxInds", "MaxInds", names(data))

##Grouping the Subjects and activities' mean in a new table
##Finally, creating a new file txt with the data in the WD

    totaldata <- data %>% group_by(Subject, Activity) %>% summarise_all(funs(mean))
    totaldata
    write.table(totaldata, "tidydata.txt", row.name = FALSE)

