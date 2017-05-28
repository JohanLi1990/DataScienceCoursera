#Question 1
data("mtcars")
fit_cars <- lm(mpg ~ factor(cyl) + wt, mtcars)
summary(fit_cars)$coef
#-6.0709

#Question 2
fit_noWT <- lm(mpg ~ factor(cyl), mtcars)
summary(fit_noWT)$coef

#Question 3
fit1<- fit_cars
fit2<- lm(mpg ~ factor(cyl) + wt + factor(cyl)*wt, mtcars)
summary(fit1)$coef
summary(fit2)$coef
#a better way is to use model comparing method. 
anova(fit1, fit2)
#p value = 0.1239 >0.05 so reject, so simpler model is true. 

#Question 4
fit4<-lm(mpg ~ I(wt * 0.5) + factor(cyl), data = mtcars)
summary(fit4)$coef


#Question 5
x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)
fit5<-lm(y~x)
hatvalues(fit5)
#0.9946

#Question 6
dfbetas(fit5)
#-133.82261293

#Question 7

