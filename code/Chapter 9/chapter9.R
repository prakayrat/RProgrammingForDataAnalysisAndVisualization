# Chapter 9
## การใช้ subset
df <- iris
head(df)
dim(df)

set_vers <- subset(df, Species != "virginica")
dim(set_vers)

ggplot(set_vers, aes(x=Petal.Length, y=Petal.Width, color=Species)) +
  geom_point()

ggplot(set_vers, aes(x = Petal.Length, y = Petal.Width,
                     color = Species)) +
  geom_point(size = 4) +
  scale_color_manual(values = c("black", "lightblue")) +
  geom_point(shape = 1, size = 4, color = "blue") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())


## Separability
vers_virg <- subset(df, Species != "setosa")
ggplot(vers_virg, aes(x = Petal.Length, y = Petal.Width,
                        color = Species)) +
  geom_point()

## ทำงานกับ e1071
table(vers_virg$Species)

### 1)
write.csv(vers_virg, "vers_virg2")
df <- read.csv("vers_virg2", header = TRUE, sep = ",")
table(df$Species)

### 2)
set.seed(2023) 
library(caTools)
set <- sample.split(df$Species, SplitRatio = .75)
training_set <- subset(df, set == TRUE)
test_set <- subset(df, set == FALSE)

dim(training_set)
dim(test_set)

library(ggplot2)
library(GGally)
ggpairs(training_set[, c(4,5,6)],
        ggplot2::aes(colour = Species, alpha = 0.4))

### 3)
library(e1071)
str(training_set$Species)

vers_virg_svm <- svm(as.factor(Species) ~ Petal.Length + Petal.Width, 
                     data = training_set,
                     method = "C-classification",
                     kernel = "linear")
vers_virg_svm

### 4)
plot(vers_virg_svm, data = training_set[, c(4, 5, 6)],
     formula = Petal.Width ~ Petal.Length, svSymbol = "X",
     slice = list(Sepal.Width = 3, Sepal.Lengt = 4))
head(training_set)

### 5)
pred = predict(vers_virg_svm, df)
tab = table(Predicted = pred, Actual = df$Species)
tab

1-sum(diag(tab)/sum(tab))

pred_training <- predict(vers_virg_svm, training_set)
mean(pred_training == training_set$Species)

pred_test <- predict(vers_virg_svm, test_set)
mean(pred_test == test_set$Species)

## kernel = "radial"
vers_virg_svm <- svm(as.factor(Species) ~ Petal.Length+Petal.Width, 
                     data = training_set,
                     method = "C-classification",
                     kernel="radial")

plot(vers_virg_svm, data = training_set[, c(4, 5, 6)],
     formula = Petal.Width ~ Petal.Length,
     dataSymbol = "O",
     svSymbol = "X",
     symbolPalette = palette(c("grey95", "grey0")),
     color.palette = grey.colors)

pred = predict(vers_virg_svm, df)
tab = table(Predicted = pred, Actual = df$Species)
tab

1-sum(diag(tab)/sum(tab))

## ทำงานกับ kernlab
library(kernlab)
kern_svm <- ksvm(as.factor(Species) ~ Petal.Width + Petal.Length,
                   training_set,
                   kernel = "vanilladot")
kern_svm

pred_training <- predict(kern_svm, training_set)
mean(pred_training == training_set$Species)

pred_test <- predict(kern_svm, test_set)
mean(pred_test == test_set$Species)

plot(kern_svm, data=training_set,
     formula=Petal.Width ~ Petal.Length)