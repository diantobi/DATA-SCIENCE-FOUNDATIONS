#########REGRESSSION PART 2


#############LOad the packages
library(tidyverse)
install.packages("stargazer")
install.packages("car")
library(stargazer)

######load the data
mydata <- read.csv ("regression_auto.csv")

######Correlation
mydata1 <- mydata %>% select(mpg, weight, price, foreign)
cor(mydata1)

#####Linear Regression
####Simple regression
######mpg = B0 + B1weight + e
model1 <- lm(mpg ~ weight, data = mydata)
summary(model1)

model2 <- lm(mpg ~ weight + price + foreign, data = mydata1)
summary(model2)


####Conditions
#####Linearity:
par(mfrow = c(1,2))
plot(model2$residuals ~ mydata$weight)
plot(model2$residuals ~ mydata$price)

#####Normality
hist(model2$residuals)
qqnorm(model2$residuals)
qqline(model2$residuals)

####Homoskedasticity
plot(model2$residuals ~  model2$fitted)

######independent residuals
plot(model2$residuals)

#multicollinearity
car::vif(model2)

