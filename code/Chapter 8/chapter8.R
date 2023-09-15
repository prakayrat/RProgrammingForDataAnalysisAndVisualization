# Chapter 8

## การสร้าง forest
set.seed(2023)
set <- sample(nrow(iris), 0.7*nrow(iris))
training_set <- iris[set, ]
test_set <- iris[-set, ]

head(training_set)
head(test_set)

dim(training_set)
dim(test_set)

library(randomForest)
iris_forest <- randomForest(Species ~ ., data = training_set,
                            ntree = 500, importance = TRUE)
print(iris_forest)

## ตรวจสอบ forest
names(iris_forest)

round(iris_forest$importance, 2)

## พล็อต error
plot(iris_forest, col = c("orange", "green", "red", "black"))
legend("topright",
       legend = c(levels(iris$Species), "OOB"),
       lty =c("dashed", "dotted", "dotdash", "solid"),
       col = c("orange", "green", "red", "black"),
       cex = 1)

### 100 ต้นแรก
plot(iris_forest,
     col = c("orange", "green", "red", "black"),
     xlim = c(1,100))
legend("topright", legend = c(levels(iris$Species), "OOB"),
       lty = c("dashed", "dotted", "dotdash", "solid"),
       col = c("orange", "green", "red", "black"), cex = 1)

## พล็อต importance
round(importance(iris_forest), 2)
varImpPlot(iris_forest, main = "Variable importance")

library(ggplot2)
qplot(Petal.Width, Petal.Length,
      data = iris, color = Species)

qplot(Sepal.Width, Sepal.Length,
      data=iris, color = Species)

library(scatterplot3d)
colors <- c("blue", "green", "red")
colors <- colors[as.numeric(iris$Species)]
with(iris, scatterplot3d(Species, 
                         Sepal.Width, Sepal.Length,
                         color=colors))


colors <- c("blue", "green", "red")
colors <- colors[as.numeric(iris$Species)]
with(iris, scatterplot3d(Species,
                         Petal.Width, Petal.Length,
                         color=colors))

## การทำนาย
pred <- predict(iris_forest, test_set[,-5])
table_iris_forest <- table(test_set$Species, pred)
table_iris_forest

accuracy_Test <- sum(diag(table_iris_forest)) / sum(table_iris_forest)
accuracy_Test

## ชุดข้อมูล glass 
glass_uci <- read.csv("glass.data", header = FALSE)
head(glass_uci)

colnames(glass_uci) <- c("Id", "RI", "Na", "Mg", "Al", "Si",
                         "K", "Ca", "Ba", "Fe",
                         "Type")
head(glass_uci)

unique(glass_uci$Type)

library(plyr)
glass_uci$Type <- mapvalues(glass_uci$Type,
                            from=c(1,2,3,5,6,7),
                            to=c("b_f","b_nf","v_f","cont","tbl","lamp"))

str(glass_uci)

glass_uci$Type<-as.factor(glass_uci$Type)
str(glass_uci$Type)

## สำรวจข้อมูล
barplot(table(glass_uci$Type),
        col = gray.colors(6))

## แบ่งชุดข้อมูล training และ test
library(caTools)
set.seed(2023)
glass_uci$Split <- sample.split(glass_uci$Type, SplitRatio=0.7)
training_set <- subset(glass_uci, glass_uci$Split == TRUE)
test_set <- subset(glass_uci, glass_uci$Split == FALSE)

dim(training_set)
dim(test_set)

## การเติบโตของ Random Forest
library(randomForest)
glass_forest <- randomForest(Type ~ RI + Na + Mg + Al + Si +
                               K + Ca + Ba + Fe,
                             data=training_set,
                             ntree=500,
                             importance=TRUE)
glass_forest

round(glass_forest$importance, 2)

## Visualizing ผลลัพธ์
varImpPlot(glass_forest)

plot(glass_forest)
err <- glass_forest$err.rate
oob_err <- err[nrow(err), "OOB"]
par(xpd = TRUE)
legend(x = "bottomright",
       legend = colnames(err),
       fill = 1:ncol(err),
       cex = .8)

## การทำนาย
glass_pred <- predict(glass_forest, newdata = test_set)
table(glass_pred, test_set$Type)


