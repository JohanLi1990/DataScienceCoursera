# Q1
library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(ggplot2)
library(lattice)
library(caret)
library(rpart)

#Step 1: create data partition
training <- segmentationOriginal[segmentationOriginal$Case == "Train", ]
testing <- segmentationOriginal[segmentationOriginal$Case == "Test", ]

#Step 2:Cart Model, seed = 125, rpart
set.seed(125)
modFit<- train(Class~., method="rpart",data=training)

# Stpe 3 draw maps
library(rattle)
fancyRpartPlot(modFit$finalModel)


#Q2 
#Anser: Bias is larger, variance is smaller. K equals to sample size. 

#Q3
library(pgmm)
data(olive)
olive = olive[,-1]
modfit2<-train(Area ~., data = olive, method = "rpart")
predict(modfit2, newdata = as.data.frame(t(colMeans(olive))))

#Q4 
library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}
modfit3 <- train(chd ~ age + alcohol + obesity +tobacco + typea + ldl, data = trainSA, method = "glm", family = "binomial")
missClass(trainSA$chd,predict(modfit3))
# 0.273missClass(trainSA$chd,predict(modfit3, testSA))
missClass(testSA$chd,predict(modfit3, testSA))
#0.312


#Q5
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)
vowel.test$y <- as.factor(vowel.test$y)
vowel.train$y <- as.factor(vowel.train$y)
set.seed(33833)
modelRf <- randomForest(y ~ ., data = vowel.train, importance = FALSE)
order(varImp(modelRf), decreasing=T)