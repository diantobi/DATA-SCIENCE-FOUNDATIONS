# This is a vector of length 1
25
#Length of `this vector is
length(25)
#Let's create a new vector called "num_vec" that takes numeric values. Once we have created it, let's print what it is, and find its length
num_vec <- c(1,2,3,4)
length(num_vec)
b <- c(1,2, "HELLO", 4, "HOW", "ARE", "YOU?")
class(b)
length(b)
friend_ages <- c(25L, 37L, 22L, 30L)
friend_ages
class(friend_ages)
numeric_ages <- c(25, 37, 22, 30)
class(numeric_ages)
numeric_ages+2
numeric_ages^2
numeric_ages-45
sum(numeric_ages)
sum(numeric_ages)/length(numeric_ages)
mean(numeric_ages)
one_to_ten <- seq(1:10)
1:1
seq_by_2 <- seq(from = 0L, to = 100L, by = 2L)
seq_by_2 <- seq(from = 0L, to = 100L, by = 2L)
View(seq_by_2)
seq_by_2
# Let's repeat one_to_ten sequence 3 times
rep(one_to_ten, times = 3)
# Let's repeat each element of this vector by 3 times
#Time for Matrix
rep(one_to_ten, each = 3)
vec1 <- 1:5
vec2 <- rep(9, 5)
# combine by columns
mat1 <- cbind(vec1, vec2)
mat1
sqrt(mat1)
a <- matrix(c(1, 2, 3, 4), ncol = 2, nrow = 2)
a
a <- matrix(c(1, 2, 3, 4), ncol = 2, nrow = 2)
mat_ev <- matrix(c(1, 2, 3, 4, 5, 6, 7, 8, 9), ncol=3, nrow=3)
mat_ev
mat_eva <- matrix(c(1, 2, 3, 4, 5, 6, 7, 8), ncol=2, nrow=4)
mat_eva
#Time for dataframe
df <- data.frame(1:5, c("A", "B", "C", "D", "E"))
df
df <- data.frame(number = 1:5, character = c("A", "B", "C", "D", "E"))
df
colnames(df)
rownames(df)
str(df)
t <- list('A', c(1, 3, 4), df)
t
str(t)
#time for indexing
df$number
df$character
df$number[3:5]
df$number[2:4]
df$character[2:5]
friend_names <- c("Amy", "Robert", "Andy", "Ida", "Dian", "Tobi")
friend_names[c(1, 3)]
friend_names[c(4, 5)]
friend_names[3:6]
friend_names[c(1, 5)]
friend_names[-c(1, 3)]
friend_names[-c(1, 3, 6)]
df_extended <- data.frame(numbers = 1:5, characters = c("A", "B", "C", "D", "E"), age = c(10,20,45,23,61), hair = c("Long", "Short", "Long", "Long", "Short"))
df_extended
df_extended[2:4, c(1,2,4)]
df_extended[c(1,5), c(1,3,4)]
friend_names[c(TRUE, FALSE, TRUE, FALSE, TRUE, TRUE)]
friend_names == "Amy"
friend_names == c("Amy", "Dian", "Tobi")