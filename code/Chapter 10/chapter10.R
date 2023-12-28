# หนังสือ R Programming สำหรับการวิเคราะห์และแสดงข้อมูลด้วยภาพ
# ผศ.ประกายรัตน์ วิเศษสงวน และ อ.อมรวิทย์ วิเศษสงวน
# พิมพ์ครั้งที่ 2 กันยายน 2566

# บทที่ 10  จัดกลุ่มด้วย K-Means Clustering 

# Chapter 10
## การวิเคราะห์
head(iris)

set.seed(2023)
iris_kmeans <- kmeans(iris[,3:4], centers=3, nstart=15)  

## เข้าใจผลลัพธ์
iris_kmeans

iris_kmeans$cluster
iris_kmeans$tot.withinss
sum(iris_kmeans$withinss)
table(iris_kmeans$cluster, iris$Species)

## Visualizing คลัสเตอร์
library(ggplot2)
ggplot(iris, aes(x = Petal.Length, y = Petal.Width, 
                   color = as.factor(iris_kmeans$cluster))) +
  geom_point(size = 3) +
  scale_color_manual(name = "Cluster",
                     values = c("grey","blue","green")) +
  geom_point(shape = 1, size = 3, color = "black")

## ค้นหาจำนวนคลัสเตอร์ 
totwss <- NULL
for (i in 2:15) {
  totwss <- append(totwss, kmeans(iris[,3:4], centers=i)$tot.withinss)
}
plot(x = 2:15, y = totwss,
     type = "b",
     xlab = "Clusters",
     ylab = "Total Within SS")


## ชุดข้อมูล glass
glass <- read.csv("glass.data", header = FALSE)
colnames(glass) <- c("Id", "RI", "Na", "Mg", "Al", "Si",
                     "K", "Ca", "Ba", "Fe", "Type")
head(glass)

library(plyr)
glass$Type <- mapvalues(glass$Type, from = c(1, 2, 3, 5, 6, 7),
                          to = c("b_f", "b_nf", "v_f",
                                 "cont", "tbl", "lamp"))
head(glass)

table(glass$Type)

## วิเคราะห์ K-Means
cols <- c(2, 4:5)
set.seed(2023)
glass_kmeans <- kmeans(glass[,cols], centers = 6, nstart = 15)
glass_kmeans

table(glass_kmeans$cluster, glass$Type)

## แสดงข้อมูลด้วยภาพของการจัดกลุ่ม
library(factoextra)
fviz_cluster(glass_kmeans, data = glass[, cols])

totwss <- NULL
cols <- c(2, 4:5)
for (i in 2:15) {
  totwss <- append(totwss,
                   kmeans(glass[,cols],
                          centers = i)$tot.withinss)
}
plot(x = 2:15, y = totwss,
     type = "b",
     xlab = "Clusters", ylab = "Total Within SS")


set.seed(2023)
glass_kmeans <- kmeans(glass[,cols], centers = 3, nstart = 15) 
glass_kmeans



