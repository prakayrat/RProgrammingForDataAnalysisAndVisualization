# Chapter 1

## เริ่มต้นเขียนโปรแกรม
x <- c(5, 10, 15, 20, 25, 30)
x

ls()
sum(x)
mean(x)

## ฟังก์ชัน
a <- seq(10, 50, 5)
a

b <- seq(to=50, by=5, from=10)
b

## User-Defined Functions
hypotenuse <- function(a, b) {
  c <- sqrt(a^2 + b^2)
  return(c)
}
hypotenuse(5, 7)

## Vectors
x <- c(5, 10, 15, 20, 25, 30)
colors <- c("tan", "lavender", "coral", "yellow")
w <- c(T, F, F, T, T, F)

colors[2]
colors[2, 3]
colors[c(2, 4)]

## Numerical vectors
y <- seq(20, 40, 4)
y

y <- seq(20, 40)
y

y <- 20:40
y

s <- c(5, 8, 4, 3)
s_repeated <- rep(s, 3)
s_repeated

vector <- c(1, 2, 3, 4)
s_repeated <- rep(s, vector)
s_repeated

a <- c(3, 4, 5)
a

a <- append(a, 6)
a

a <- c(3, 4, 5)
a <- c(a, 6)
a

a <- c(9, a)
a

length(a)

## Metrices
num_matrix <- seq(5, 100, 5)
num_matrix

dim(num_matrix) <- c(5, 4)
num_matrix

t(num_matrix)

num_matrix2 <- matrix(seq(5, 100, 5), nrow=5)
num_matrix2

num_matrix3 <- matrix(seq(5, 100, 5), nrow=5, byrow=T)
num_matrix3

num_matrix3[5, 4]

num_matrix3[3, ]

num_matrix3[, 2]

## Lists
names <- c("tan", "lavender", "coral", "yellow")
ages <- c(17, 15, 14, 22)
info <- list(Name=names, Age=ages)
info

info$Name

info$Name[4]

info$Name[info$Age > 16]

## Data frames
names <- c("tan", "lavender", "coral", "yellow")
ages <- c(17, 15, 14, 22)
height <- c(172, 164, 166, 181)
weight <- c(95, 67, 55, 99)
gender <- c("M", "F", "F", "M")

str(gender)
gender_factor <- factor(gender)
gender_factor

data <- data.frame(names, ages, height, weight, gender)
data

data[3, 4]

data[4, ]

data[, 2]

data[, 2:3]

data$height

mean(data$height)

mean(data$height[data$gender_factor == "F"])

with(data, mean(height[gender_factor == "F"]))

nrow(data)

ncol(data)

aptitude <- c(35, 20, 32, 22)
data2 <- cbind(data, aptitude)
data2

## for loops
x <- c(2, 3, 4, 5, 6)
y <- NULL

for(i in 1:length(x)) {
  if(x[i] %% 2 == 0) {y[i] = "EVEN"}
  else {y[i] = "ODD"}
}
y

