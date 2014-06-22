getting_cleaning_data_project
=============================

Project for the Coursera Getting and Cleaning Data

First I read all the test data files and the train data files and create two different data frames
Then I create a new data frame from the previous two data frames
The next thing is to subset the all inclusive data frame with only those features that contatin mean() and std()
The next step is to ddaply the mean function grouping by subject and activity
Finally I add the activity description into a new data frame and write this dataframe as csv file


