Coursera.GettingCleaningData
============================

Project for the Coursera course "Getting and Cleaning Data 2014

The file run_analysis.R contains the code to create the tidy data set for this Coursera course.

The Codebook describes (1) the original data that was used to create the new data set and (2) the steps done to create the new one. It also contains the variables of the new data set.

Following steps were done to create the new data set:
1. The following table of the original dataset were read:
  X_train.txt
  y_train.txt
  subject_train.txt
  X_test.txt
  y_test.txt
  subject_test.txt
  features.txt
  activity_labels.txt
2. The train and test data were combined
3. The data contained in "features.txt" were inserted by creating a list with the label names renaming the columns of the data set with this list
4. Two columns were added to the dataset ('labels' and 'subjects')
5. Measurements containing 'mean' and 'sd" were extracted (subset)
6. Numbers for activities were replaced by the proper lables from the file 'activity_labels.txt'
7. Special characters were deleted from the variable names
8. Now, for the last step I know I did not use the best/most efficient method, but a rather laborious one. This is a beginner's solution. A matrix for each activity with dimensions: one row per subject and one column per variable (i.e. 86 measured variables and the two columns for label and subject) was created.
9. For each matrix a loop went through single subjects and the related measured varibales to calculate the mean and assign the result to its place in the matrix.
10. Then a data frame was created out of the matrix and the right varibale names were inserted.
11. The final data frame was created by binding the data frames containing the means.
12. The output file was created.
