library(dplyr)

# Read data to data tables
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
activity_labels$V2 <- as.character(activity_labels$V2)
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)

x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
colnames(x_test) <- features[,2]
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
colnames(y_test) <- "Activity"
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
colnames(subject_test) <- "subject_number"

# body_acc_x_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt", header = FALSE)
# body_acc_y_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt", header = FALSE)
# body_acc_z_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt", header = FALSE)
# 
# body_gyro_x_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt", header = FALSE)
# body_gyro_y_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt", header = FALSE)
# body_gyro_z_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt", header = FALSE)
# 
# total_acc_x_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt", header = FALSE)
# total_acc_y_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt", header = FALSE)
# total_acc_z_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt", header = FALSE)



x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
colnames(x_train) <- features[,2]
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
colnames(y_train) <- "Activity"
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
colnames(subject_train) <- "subject_number"

# body_acc_x_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt", header = FALSE)
# body_acc_y_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt", header = FALSE)
# body_acc_z_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt", header = FALSE)
# 
# body_gyro_x_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt", header = FALSE)
# body_gyro_y_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt", header = FALSE)
# body_gyro_z_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt", header = FALSE)
# 
# total_acc_x_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt", header = FALSE)
# total_acc_y_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt", header = FALSE)
# total_acc_z_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt", header = FALSE)

# merging training and test data sets to a master data set

test_set <- cbind(subject_test,y_test,x_test)
train_set <- cbind(subject_train,y_train,x_train)
full_data_set <- rbind(test_set, train_set)

# replacing activity numbers with activity labels

for (i in 1:length(full_data_set$Activity)) {
full_data_set$Activity[i] <- activity_labels[activitylabels[,1] == full_data_set$Activity[i],2]
}


#Extracting data sets with variables of mean and standard deviation
std_data <- full_data_set[,grep(c("std()"),names(full_data_set))]
mean_data <- full_data_set[,grep(c("mean()"),names(full_data_set))]
subject_number <- full_data_set$subject_number
Activity <- full_data_set$Activity
filtered_data_set <- cbind(full_data_set$subject_number,full_data_set$Activity,mean_data,std_data)

# Calculate means by subject and activity

aggdata <- aggregate(filtered_data_set, by=list(full_data_set$subject_number,full_data_set$Activity), FUN=mean, na.rm=TRUE)
 

write.table(aggdata,"averagedata.txt",row.name = FALSE)