####HYPOTHESIS TESTING####
nc <- read.csv("http://bit.ly/31adfCe")
head(nc)


data = na.omit(nc) #omit missing values
table(data$habit)

smoker      <- data$gained[data$habit=="smoker"]
nonsmoker   <- data$gained[data$habit=="nonsmoker"]
t.test(smoker, nonsmoker, alternative="two.sided", conf.level = 0.95)