# Getting-and-Cleaning-Data-Week-4-Assignment

This README was created to explain the analysis files

The next tasks were developed:

Downloading and reading data into your R working directory using download.file() and unzip()

Set a new directory in the folder created in the last step using setwd() to be able to read the necessary data

Read all files (.txt) and naming the columns (variables) using read.tables() and colnames()

Merging data in rows for every variable (x, y, subject) in every function (train, test) using rbind()

Merging data in columns with last values merged using cbind()

Reading merged data and selected necessary data using 'pipe' operator (%>%) and select()

Replacing names to different variables of the list (Activities and features) with gsub()
*Variable's names were taken from (features_info.txt)

Grouping the Subjects and activities' mean in a new table using 'pipe' operator, group_by() and summarise_all()

Finally, creating a new file txt with the data in the WD using write.table()
