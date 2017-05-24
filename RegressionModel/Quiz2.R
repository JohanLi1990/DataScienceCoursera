#Question 1
x <- c(0.61, 0.93, 0.83, 0.35, 0.54, 0.16, 0.91, 0.62, 0.62)
y <- c(0.67, 0.84, 0.6, 0.18, 0.85, 0.47, 1.1, 0.65, 0.36)
fit<-lm(y~x)
coefTable <- coef(summary(fit))
p<-coefTable[2,4] #0.05296439

#Question 2
#estimates of residual standard deviation
summary(fit)$sigma #0.2229981


#Question 3
# fit a linear regression model of weight (predictor) on mpg (outcome). 
#Get a 95% confidence interval for the expected mpg 
#at the average weight. What is the lower endpoint ?
fit2 <- lm(mpg ~ wt, mtcars)
x <- mtcars$wt
y <- mtcars$mpg
fit2 <- lm(y~x)
predict(fit2, newdata = data.frame(x = mean(x)), interval = ("confidence"))
#20.09062 18.99098 21.19027

#Question 4
#1000lbs shit

#Question 5
predict(fit2, newdata = data.frame(x = 3), interval = ("prediction"))
#27.57355

#Question 6
#predict(fit2, newdata = data.frame(x = x/2), interval = ("confidence")) not true
fit3 <- lm(mpg ~ I(wt/2), mtcars)
sumCoef <- summary(fit3)$coef
(sumCoef[2,1] + c(-1, 1) * qt(.975, df = fit3$df) * sumCoef[2, 2])
#[1] -12.97262  -8.40527

#Question 9
sum(resid(fit2)^2)/sum((y-mean(y))^2)
#in this case the question is asking two scenes, one when only considering intercept as predictor, 
#so Ybar, another is slope, so Yhat. 

#Question 10
sum(resid(fit2))
fit3<-lm(y~x-1)
sum(resid(fit3))



