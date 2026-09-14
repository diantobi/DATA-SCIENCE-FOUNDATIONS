#Revision

#Load Data
bhps <- read.csv("http://bit.ly/2ybNWDk")

#Load packages
library(tidyverse)

#Data Modification
bhps$region <- as.factor(bhps$region)
bhps$academic_qual <- as.factor(bhps$academic_qual)


#Explore Data
summary(bhps)

table(bhps$region)

#mean age by gender
#option 1
mean(bhps$age[bhps$female == 1])
mean(bhps$age[bhps$female == 0])

#option 2
bhps %>% group_by (female) %>%
  summarise(
    count = n(),
    mean_age = mean(age),
    std_age = sd(age)
    )


#Plot age
hist(bhps$age)

ggplot(data = bhps, aes(x=academic_qual, y=age)) +
  geom_boxplot() +
  xlab("Academic Qualification") +
  ylab("Age") +
  ggtitle("Academic Qualification by Age")

#Difference between median age for men and women)
median_fe <- median(bhps$age[bhps$female==1])
median_male <- median(bhps$age[bhps$female==0])
median_male- median_fe

#option 2
bhps %>% group_by(female) %>% summarize(med = median(age)) %>% pull(med) %>% diff()


#Gapminder Analysis 
