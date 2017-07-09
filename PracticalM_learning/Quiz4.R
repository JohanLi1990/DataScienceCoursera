setwd("~/Documents/DataScienceCoursera/PracticalM_learning")
# Q1
library(ElemStatLearn)
data(vowel.train)
data(vowel.test)
# Set the variable y to be a factor variable in both the training and test set
vowel.train$y <- factor(vowel.train$y)
vowel.test$y <- factor(vowel.test$y)
# Then set the seed to 33833
set.seed(33833)
# Fit (1) a random forest predictor relating the factor variable y to the remaining variables and
library(caret)
mod_rf <- train(y ~., data = vowel.train, method = "rf")
md_gbm <- train(y ~., data = vowel.train, method = "gbm")
# fit to test
predrf <- predict(mod_rf, vowel.test)
predgbm <- predict(md_gbm, vowel.test)
confusionMatrix(predrf, vowel.test$y)$overall[1] #0.6017
confusionMatrix(predgbm, vowel.test$y)$overall[1] #0.534632

agreedIndex <- predrf == predgbm
confusionMatrix(predrf[agreedIndex], vowel.test$y[agreedIndex]) #0.6438

# Q2
library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

set.seed(62433)
mod_rf <- train(diagnosis ~., data = training, method = "rf")
mod_gbm <- train(diagnosis ~., data = training, method ="gbm", verbose = FALSE)
mod_lda <- train(diagnosis ~., data = training, method = "lda", verbose = FALSE)

predrf <- predict(mod_rf, testing)
predgbm <- predict(mod_gbm, testing)
predlda <- predict(mod_lda, testing)

combined_pred <- data.frame(predrf, predgbm, predlda, diagnosis = testing$diagnosis)
mod_combined <- train(diagnosis ~., data = combined_pred, method = "rf", verbose = FALSE)
pred_combined <- predict(mod_combined, testing)
#Accuracy stacked
mod_combined_analysis <- confusionMatrix(testing$diagnosis, pred_combined)
mod_combined_analysis$overall["Accuracy"] #0.805

#Accuracy mod_rf
mod_rf_analysis <- confusionMatrix(testing$diagnosis, predrf)
mod_rf_analysis$overall["Accuracy"] #0.7682927

#Accuracy of gbm
mod_gbm_analysis <- confusionMatrix(testing$diagnosis, predgbm)
mod_gbm_analysis$overall["Accuracy"] #0.793

#Q3
set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

set.seed(233)
mod_fit<-train(CompressiveStrength~., data = training, method = "lasso")
plot.enet(mod_fit$finalModel,  xvar="penalty", use.color=TRUE) #cement


#Q4
library(lubridate) # For year() function below
dat = read.csv("gaData.csv")
training = dat[year(dat$date) < 2012,]
testing = dat[(year(dat$date)) > 2011,]
tstrain = ts(training$visitsTumblr)

library(forecast)
modBats <- bats(tstrain)
forecastObjec <- forecast(modBats, level=95, h=nrow(testing))
betweenVal <- sum(testing$visitsTumblr > forecastObjec$lower &  testing$visitsTumblr < forecastObjec$upper)
betweenVal/nrow(testing) #96.2%

#Q5
set.seed(3523)

library(AppliedPredictiveModeling)

data(concrete)

inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]

training = concrete[ inTrain,]

testing = concrete[-inTrain,]

set.seed(325)
library(e1071)
library(caret)
library(forecast)
modfit <- svm(CompressiveStrength ~., data = training)
predfit <- predict(modfit, testing)
modfit_analysis <- accuracy(testing$CompressiveStrength, predfit) 
modfit_analysis #6.72
