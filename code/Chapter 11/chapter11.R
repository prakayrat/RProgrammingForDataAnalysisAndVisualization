# หนังสือ R Programming สำหรับการวิเคราะห์และแสดงข้อมูลด้วยภาพ
# ผศ.ประกายรัตน์ วิเศษสงวน และ อ.อมรวิทย์ วิเศษสงวน
# พิมพ์ครั้งที่ 2 กันยายน 2566

# บทที่ 11  ทำนายข้อมูลด้วย Neural Networks 

# Chapter 11
## สร้าง Neural Networks
library(nnet)
set.seed(2023)
head(iris)

library(caTools)
set <- sample.split(iris$Species, SplitRatio = .70)
iris_train <- subset(iris, set == TRUE)
iris_test <- subset(iris, set == FALSE)

dim(iris)
dim(iris_train)
dim(iris_test)

# create a model
iris_nn <- nnet(Species ~ Petal.Length + Petal.Width,
                iris_train, size = 4)

## พล็อตเครือข่าย
library(NeuralNetTools)
plotnet(iris_nn)

## ประเมินเครือข่าย
predictions <- predict(iris_nn, iris_test,
                       type = "class")
table(iris_test$Species, predictions)


## banknotes
## พล็อตและสร้าง Neural Networks
df <- read.csv("data_banknote_authentication.txt", header = FALSE)
colnames(df) <- c("Variance", "Skewness", "Kurtosis",
                  "Entropy", "Class")

head(df)

library(ggplot2)
ggplot(df, aes(x = Kurtosis, y = Entropy, color = Class)) +
  geom_point()

ggplot(df, aes(x = Skewness, y = Entropy, color = Class)) +
  geom_point() + geom_smooth()

ggplot(df, aes(x = Skewness, y = Kurtosis, color = Class)) +
  geom_point() + geom_smooth()

str(df$Class)

df$Class <- as.factor(df$Class)
str(df$Class)


library(caTools)
set <- sample.split(df$Class, SplitRatio = .70)
df_train <- subset(df, set == TRUE)
df_test <- subset(df, set == FALSE)

dim(df)
dim(df_train)
dim(df_test)


library(nnet)
set.seed(2023)
df_nn <- nnet(Class ~ ., df_train, size = 3)

library(NeuralNetTools)
plotnet(df_nn)

pred <- predict(df_nn, df_test,
                type = "class")
table(df_test$Class, pred)


## Project: Dress
library("readxl")
df <- read_excel("Attribute DataSet.xlsx")
head(df)

df <- as.data.frame(df)
head(df)

dim(df)

length(unique(df$Dress_ID))
length(df$Dress_ID)

library(dplyr)
df1 <- table(df$Dress_ID)
dress_dup <- df[df$Dress_ID %in% names(df1[df1>1]),] %>%
  arrange(Dress_ID)
head(dress_dup)


cols <- c(1,4)
dress <- df[, -cols]
head(dress)

library(tidyverse)
dress <- drop_na(dress)
dim(dress)



