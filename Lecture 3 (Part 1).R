#Exploring Data

past <- read.csv("http://bit.ly/2ybNWDk")
head(past)
tail(past)

#Summarize the data
summary(past)

gapminder <- read.csv("http://bit.ly/2GxjYOB")
head(gapminder)
tail(gapminder)
library(tidyverse)

#Summarize the data
summary(gapminder)

table(gapminder$country)

gapminder$continent <- as.factor(gapminder$continent)
gapminder$country <- as.factor(gapminder$continent)

summary(gapminder)

#create a new variable
gapminder <- gapminder %>% mutate(high_gdp = ifelse(gdpPercap>4000, 1,0))

#Select new variable
gapminder_1 <- gapminder%>% select(country, pop, high_gdp)

#summarize by group
gapminder %>% group_by(country) %>%
  summarise(
    count = n(),
    mu = mean (pop),
    med = median(pop),
    sigma = sd(pop),
    iqr_p = IQR(pop),
    min_p = min(pop),
    max_p = max(pop),
    Q1P = quantile(pop, 0.25),
    Q2P = quantile(pop,0.5),
    Q3P = quantile(pop, 0.75)
    )
    
summary(gapminder)
    
      