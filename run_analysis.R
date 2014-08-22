#STEP 1: Merge training and test sets to create one data set
#STEP 1.1: reading in the data
  #reading in train data files
  trainData<-read.table("X_train.txt")
  trainLabels<-read.table("y_train.txt")
  trainSub<-read.table("subject_train.txt") 
  #reading in test data files
  testData<-read.table("X_test.txt")
  testLabels<-read.table("y_test.txt")
  testSub<-read.table("subject_test.txt")
  #reading in the features data file
  fea<-read.table("features.txt")
  #reading in fiel with activity labels
  act<-read.table("activity_labels.txt")
  
#STEP 1.2: Combinging files to one dataset
  #combinging the train data files, i.e. two adding coloumns with labels and subjects
  newDataTrain<-cbind(trainData,trainLabels,trainSub)
  #combinging the test data files, i.e. two adding coloumns with labels and subjects
  newDataTest<-cbind(testData,testLabels,testSub)
  #adding the test data rows to the train data set to create one dataset
  combData<-rbind(newDataTrain,newDataTest)

#STEP 1.3: Inserting the features as column names
  #creating list with label names (data type "character")
  labelText<-as.character(fea$V2)
  #adding labels for the added columns (i.e. y_test file and subject_test)
  labelText[[length(labelText)+1]]<-"labels"
  labelText[[length(labelText)+1]]<-"subjects"
  #renaming the columns with the proper variable names
  names(combData)<-labelText

#STEP 2: Extract only measurements on mean and standard deviation
  #Changing all variable names to only have lower case letters
  names(combData)<-tolower(names(combData))
  #subsetting combData to varibales including "mean" and "std" in names (keeping columns "labels" and "subjects")
  combData2<-combData[grepl("mean|std|labels|subjects",names(combData))]
  
#STEP 3:Use descriptive activity names to name the activities in the data set
  for (n in 1:6){combData2$labels<-sub(n,act$V2[n],combData2$labels)}

#Step 4: Appropriately label data set with descriptive variable names
#Naming the data set was already done in step 1.3
  #Getting rid of - and () etc.
  names(combData2)<-sub("\\(|\\)|\\,|\\-","",names(combData2))
  
#Step 5: Create tidy data set with the average of each variable for each activity and each subject
#
# I am sure there is a better/easier way to do this; this is my beginner's attempt, but it works
#
#creating one matrix for each activity with dimensions: one row per subject and one column per variable, i.e. 86 measured variables and the two columns for label and subject
  standing<-matrix(, nrow=30,ncol=88)
  sitting<-matrix(, nrow=30,ncol=88)
  laying<-matrix(, nrow=30,ncol=88)
  walking<-matrix(, nrow=30,ncol=88)
  walkingDS<-matrix(, nrow=30,ncol=88)
  walkingUS<-matrix(, nrow=30,ncol=88)
#for each matrix loop through single subjects and the related measured varibales to calculate the mean and assign the result to its place in the matrix
#then create a data frame out of the matrix and insert the right varibale names
  #matrix STANDING
  for (i in 1:30){
    for (n in 1:86){standing[i,n]<-mean(subset(combData2, labels=="STANDING" & subjects==i)[,n])
    standing[i,88]=i
    }
    standing[i,87]="STANDING"
  }
  standingDF<-data.frame(standing)
  names(standingDF)<-names(combData2)
  #matrix SITTING
  for (i in 1:30){
    for (n in 1:86){sitting[i,n]<-mean(subset(combData2, labels=="SITTING" & subjects==i)[,n])
    sitting[i,88]=i
    }
    sitting[i,87]="SITTING"
  }
  sittingDF<-data.frame(sitting)
  names(sittingDF)<-names(combData2)  
  #matrix LAYING
  for (i in 1:30){
    for (n in 1:86){laying[i,n]<-mean(subset(combData2, labels=="LAYING" & subjects==i)[,n])
    laying[i,88]=i    
    }
    laying[i,87]="LAYING"
  }
  layingDF<-data.frame(laying)
  names(layingDF)<-names(combData2)
  #matrix WALKING
  for (i in 1:30){
    for (n in 1:86){walking[i,n]<-mean(subset(combData2, labels=="WALKING" & subjects==i)[,n])
    walking[i,88]=i
    }
    walking[i,87]="WALKING"
  }
  walkingDF<-data.frame(walking)
  names(walkingDF)<-names(combData2)
  #matrix WALKING DOWNSTAIRS
  for (i in 1:30){
    for (n in 1:86){walkingDS[i,n]<-mean(subset(combData2, labels=="WALKING_DOWNSTAIRS" & subjects==i)[,n])
    walkingDS[i,88]=i
    }
    walkingDS[i,87]="WALKING_DOWNSTAIRS"
  }
  walkingDSDF<-data.frame(walkingDS)
  names(walkingDSDF)<-names(combData2)
  #matrix WALKING UPSTAIRS
  for (i in 1:30){
    for (n in 1:86){walkingUS[i,n]<-mean(subset(combData2, labels=="WALKING_UPSTAIRS" & subjects==i)[,n])
    walkingUS[i,88]=i
    }
    walkingUS[i,87]="WALKING_UPSTAIRS"
  }
  walkingUSDF<-data.frame(walkingUS)
  names(walkingUSDF)<-names(combData2)
#create final data frame by binding the data frames containing the means
combData3<-rbind(standingDF,sittingDF,layingDF,walkingDF,walkingDSDF,walkingUSDF)
#creating output table as txt file 
write.table(combData3, file="UCI_HAR_project.txt", row.name=FALSE)
  