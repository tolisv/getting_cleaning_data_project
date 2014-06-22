library(plyr)
# read from files that constitute the test data and create a test_data dataframe
feat_test = read.table("X_test.txt")
act_test = read.table("y_test.txt")
subj_test = read.table("subject_test.txt")
test_data = cbind(subj_test, cbind(act_test, feat_test))

# read from the files that constitute the training data and create a train_data dataframe
feat_train = read.table("X_train.txt")
act_train = read.table("y_train.txt")
subj_train = read.table("subject_train.txt")
train_data = cbind(subj_train, cbind(act_train, feat_train))

# combine the test and train dataframes into one
alldata = rbind(test_data, train_data)

# change the first two columns names to more descriptive names
colnames(alldata)[1] = "subj_id"
colnames(alldata)[2] = "activ_id"

# read the activity labels file and change the column names
act_table = read.table("activity_labels.txt")
colnames(act_table)[1] = "activ_id"
colnames(act_table)[2] = "description"


# create a new dataframe with the features that contain mean() and std()
feat_tab = read.table("features.txt")
std_log = grepl("std()", feat_tab$V2)
std_ind  = which(std_log) + 2
mean_log = grepl("mean()", feat_tab$V2)
mean_ind = which(mean_log) + 2
feat_ndx = c(1, 2, sort(c(mean_ind, std_ind)))
alldata_subset = alldata[,feat_ndx]
alldata_subset_tidy = ddply(alldata_subset, .(subj_id, activ_id), colwise(mean))

alldata_subset_tidy_desc = merge(act_table, alldata_subset_tidy)

tidy_data_final = alldata_subset_tidy_desc[order(alldata_subset_tidy_desc$subj_id, alldata_subset_tidy_desc$description),]

# write.table(alldata_subset_tidy, file = "tidydata.csv", sep = ",")

write.table(tidy_data_final, file = "tidydata.csv")


