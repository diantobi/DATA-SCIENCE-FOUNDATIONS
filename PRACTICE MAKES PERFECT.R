#####DIAN HOUNKANRIN 3506800
##### PRACTICE TEST


# Load the data -----------------------------------------------------------
data1 <- read.csv("data1.csv")



# Question 1 --------------------------------------------------------------
median(data1$age)
#Median = 40

var(data1$age)
#variance = 322.7731

quantile(data1$age, 0.60)
#60th quantile = 46


# Question 2 --------------------------------------------------------------
cor(data1$age, data1$weekly.wage)
#correlation = -0.2496


# Question 3 --------------------------------------------------------------
mean(data1$age[data1$region == "london"])
#Mean age in London = 42.513


# Question 4 --------------------------------------------------------------
hist(x = data1$weekly.wage[data1$region == "scotland"],
     xlab = "Weekly wages",
     ylab = "Frequency")
#It is right skewed


# Question 5 --------------------------------------------------------------
londonwage <- (data1$weekly.wage[data1$region == "london"])
scotlandwage <- (data1$weekly.wage[data1$region == "scotland"])
t.test(londonwage, scotlandwage, alternative="two.sided", conf.level = 0.95)
#H0: mean(londonwage) = mean(scotlandwage)
#H1: mean(londonwage) != mean(scotlandwage)
#Reject the Null Hypothesis and conclude that the average weekly wages in london and 
#scotland are significantly different.


# Question 6 --------------------------------------------------------------
wagemodel <- lm(weekly.wage ~ age + region + degree + smoker + gender, data = data1)
summary(wagemodel)
data1$smoker<-factor(data1$smoker, levels = "no","yes")
levels(data1$smoker)
confint(wagemodel, level = 0.90)
table(data1$smoker)
#a one unit increase in age will decrease weeekly wages by 4.55 units, all other variables remaining constant.
#a one unit increase in age will decrease weeekly wages by 4.55 units, all other variables remaining constant.

#The R-squared is 0.20, which means the variability in the independent variables explain 20% 0f the variability in weekly wages.

#Ho: Bage = Bregion = Bdegree = Bsmoker = Bgender = 0
#H1: At least one B != 0 
#The model is significant at the 5% level as the p-value of the F-statistic 2.2e-16 is less than 0.05


