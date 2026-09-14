#Data Basics
# Check if package Tidyverse is already installed and if not it will install it
if("tidyverse" %in% rownames(installed.packages()) == FALSE) {install.packages("tidyverse")}

#Load library Tidyverse
library(tidyverse)


# Load the dataset
bhps <- read_csv("http://bit.ly/2ybNWDk")
bhps <- read.csv("http://bit.ly/2ybNWDk")
head(bhps)
str(bhps)
read_csv("1,2,3\n4,5,6", col_names = FALSE)

#Exporting Data
write.csv(bhps, file = "bhps.csv")

#Import back
bhps <- read.csv("bhps.csv")


#Data Transformation
