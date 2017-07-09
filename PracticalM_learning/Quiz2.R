#Quiz 2
# Q1
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
# Correct Answer:
# adData = data.frame(diagnosis,predictors)
# trainIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
# training = adData[trainIndex,]
# testing = adData[-trainIndex,]


# Q2
data(concrete)
library(caret)
set.seed(1000)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]
