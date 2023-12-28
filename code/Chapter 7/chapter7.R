# หนังสือ R Programming สำหรับการวิเคราะห์และแสดงข้อมูลด้วยภาพ
# ผศ.ประกายรัตน์ วิเศษสงวน และ อ.อมรวิทย์ วิเศษสงวน
# พิมพ์ครั้งที่ 2 กันยายน 2566

# บทที่ 7  ตัดสินใจด้วย Decision Tree 

# Chapter 7

head(iris)

## การเติบโตของ tree ใน R
library(rpart)
iris_tree <- rpart(Species ~ Sepal.Length + Sepal.Width +
                     Petal.Length + Petal.Width,
                   iris,
                   method = "class")
iris_tree

## การวาด tree ใน R
library(rpart.plot)
prp(iris_tree, type = 2,
    extra = "auto", nn = TRUE,
    branch = 1, varlen = 0, yesno = 2)

## mtcars Decision Tree ใน R
library(rpart)
mtcars_tree <- rpart(mpg ~ disp, mtcars,
                     method = "anova")
mtcars_tree

library(rpart.plot)
rpart.plot(mtcars_tree, cex = 1, extra = 101)

## การแบ่งชุดข้อมูล training และ test
set.seed(2023)
library(caTools)
df <- iris

df$Split <- sample.split(df$Species, SplitRatio = 0.7)

training <- subset(df, df$Split == TRUE)
test <- subset(df, df$Split == FALSE)

nrow(training)
nrow(test)

library(rpart)
iris_tree <- rpart(Species ~ Sepal.Length + Sepal.Width +
                     Petal.Length + Petal.Width,
                   training,
                   method = "class")
iris_tree

library(rpart.plot)
prp(iris_tree, type = 2,
    extra = 101, nn = TRUE, branch = 1,
    varlen = 0, yesno = 2, box.palette = "auto")


predict_iris_training <- predict(iris_tree, training, type = 'class')
table_iris_training <- table(training$Species, predict_iris_training)
table_iris_training

accuracy_Test <- sum(diag(table_iris_training)) / sum(table_iris_training)
accuracy_Test

## การประเมิน model performance
predict_iris_test <- predict(iris_tree, test, type = 'class')
table_iris_test <- table(test$Species, predict_iris_test)
table_iris_test

accuracy_Test <- sum(diag(table_iris_test)) / sum(table_iris_test)
accuracy_Test

## ชุดข้อมูล Car evaluation
car_uci <- read.csv("car.data", header=FALSE)
head(car_uci)

colnames(car_uci) = c("buying","maintenance","doors","persons","lug_boot",
                      "safety","evaluation")
head(car_uci)

## Data exploration
table(car_uci$evaluation)
barplot(table(car_uci$evaluation), col=grey.colors(5))

## Building and drawing the tree
library(rpart)
car_tree <- rpart(evaluation ~ ., car_uci,
                  method = "class")
library(rpart.plot)
prp(car_tree, cex = 1, varlen = 0, branch = 0,
    box.palette = "RdYlGn")

printcp(car_tree)



