# หนังสือ R Programming สำหรับการวิเคราะห์และแสดงข้อมูลด้วยภาพ
# ผศ.ประกายรัตน์ วิเศษสงวน และ อ.อมรวิทย์ วิเศษสงวน
# พิมพ์ครั้งที่ 2 กันยายน 2566

# บทที่ 6  แนะนำ Machine Learning 

# Chapter 6
## UC Irvine Machine Learning Repository
iris_uci <- read.csv("iris.data", header = FALSE,
                     col.names = c("sepal_l", "sepal_w", "petal_l",
                                   "petal_w", "species"))
head(iris_uci)

## Cleaning up
### 1)
iris_uci[35,] 
iris[38, 2:3]

### 2)
library(plyr)
iris_uci$species <- mapvalues(iris_uci$species, from =
                                c("Iris-setosa","Iris-versicolor","Iris-virginica"),
                              to=c("setosa","versicolor","virginica"))
head(iris_uci)

## สำรวจข้อมูล
summary(iris_uci)

par(mfrow = c(2, 2))
for(i in 1:4){hist(iris_uci[,i], xlab = colnames(iris_uci[i]),
                   cex.lab = 1.2, main = "")}


## Base R graphics
pairs(iris_uci[1:4],
      lower.panel = NULL,
      cex = 1.5,
      cex.labels = 1.5, 
      pch = c(20, 8, 6)[as.factor(iris_uci$species)])

par(xpd=NA)
legend("bottomleft", legend=levels(as.factor(iris_uci$species)),
       pch=c(20, 8, 6), bty="n")


## ggplot version

library(ggplot2)
library(GGally)
ggpairs(iris_uci, aes(color = species))

library(ggplot2)
library(GGally)
plot.matrix <- ggpairs(iris_uci, aes(color = species))

for(i in 1:5) {
  for(j in 1:5) {
    plot.matrix[i, j] <- plot.matrix[i, j] +
      scale_color_grey() +
      scale_fill_grey()
  }
}
plot.matrix


