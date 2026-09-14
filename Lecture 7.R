#### LECTURE 7#####


# Load the Data -----------------------------------------------------------
students <- read.csv("http://bit.ly/486t0PK")


# Explore the Data --------------------------------------------------------
summary(students)
table(students$method)
aggregate(. ~ method, data = students, mean)

boxplot(score ~ method, data = students, 
        main = "Exam scores by teaching style",
        ylab = "scores",
        xlab = "Teaching style",
        col = c("blue", "green"))

boxplot(hours ~ method, data = students, 
        main = "Hours studied by teaching style",
        ylab = "Hours",
        xlab = "Teaching style",
        col = c("blue", "green"))


# Inference ---------------------------------------------------------------

# 1. Compare mean scores
# H0 = mean_score(lecture) = mean_score(interactive)
# H1 = mean_score(lecture) != mean_score(interactive)
t1<- t.test(score ~ method, data = students, alternative = "two.sided")
t1
# p-v al < alpha = 5% ----- #REJECT THE NULL

# 2. Compare study hours
# H0 = mean_hrs(lecture) = mean_hrs(interactive)
# H1 = mean_hrs(lecture) < mean_hrs(interactive)
t2 <- t.test(hours ~ method, data = students, alternative = "less")
t2
# REJECT THE NULL


# Confidence Intervals ----------------------------------------------------
t3 <- t.test(GPA ~ method, data = students, alternative = "two.sided")
t3$conf.int

gpa <- students$GPA[students$method == "Lecture"]
n <- length(gpa)
mean_x <- mean(gpa)
sd_x <- sd(gpa)
error <- qt(0.975, df = n-1) * sd_x / sqrt(n)

CI <- cbind(mean_x-error, mean_x + error)
CI


# Check for Normality -----------------------------------------------------

# H0 = The data are normally distributed
# H0 = The data are not normally distributed

shapiro.test (students$score[students$method == "Lecture"])
