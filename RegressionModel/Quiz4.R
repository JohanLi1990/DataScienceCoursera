#Quiz 4

# Question 1
shuttle$usebin <- as.numeric(shuttle$use == "auto") 
shuttle$windbin <- as.numeric(shuttle$wind == "head")
fit1 <- glm(usebin ~ windbin, data = shuttle,  family = "binomial")
summary(fit1)
exp(coef(fit1))
#Intercept)     windbin 
#1.3272727   0.9686888 

#Question 2
fit2 <- glm(usebin ~ windbin + factor(magn), data = shuttle,  family = "binomial")
summary(fit2)
exp(coef(fit2))
# (Intercept)            windbin factor(magn)Medium    factor(magn)Out factor(magn)Strong 
# 1.4851533          0.9684981          1.0000000          0.6841941          0.9376181 

#Question 3
fit3<- glm(1-usebin ~ windbin, data = shuttle,  family = "binomial")
summary(fit3)
#They reverse sign, if use 1 - outcome 

#Question 4
data(InsectSprays)
fit4 <- glm(count ~ factor(spray) - 1, data = InsectSprays, family = "poisson")
summary(fit4)
exp(coef(fit4)[1])/ exp(coef(fit4)[2])
# factor(spray)A 
# 0.9456522 

#Question 5
# How can estimate change due to offset?? No way!

#Question 6
x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)
knot <- c(0)
splineterm <- sapply(knot, function(knot)(x > knot) * (x - knot))
xmat <- cbind(1, x, splineterm)
fit6 <- glm(y~xmat - 1)
summary(fit6)
# Coefficients:
#     Estimate Std. Error t value Pr(>|t|)    
# xmat  -0.18258    0.13558  -1.347    0.215    
# xmatx -1.02416    0.04805 -21.313 2.47e-08 ***
#     xmat   2.03723    0.08575  23.759 1.05e-08 ***
