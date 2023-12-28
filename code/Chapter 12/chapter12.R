# หนังสือ R Programming สำหรับการวิเคราะห์และแสดงข้อมูลด้วยภาพ
# ผศ.ประกายรัตน์ วิเศษสงวน และ อ.อมรวิทย์ วิเศษสงวน
# พิมพ์ครั้งที่ 2 กันยายน 2566

# บทที่ 12  การประมวลผลชุดข้อมูลขนาดใหญ่ 

# Chapter 12

## ชุดข้อมูล Online Retail
### ปรับ format คอลัมน์ “InvoiceDate ” ใหม่
### คัดลอกข้อมูลตามที่หนังสือบอก

retailonline <- read.csv("clipboard",
                         header = TRUE,
                         sep = "\t")

colnames(retailonline)

retailonline$Amount <- retailonline$Quantity * retailonline$UnitPrice
colnames(retailonline)

head(retailonline[, -c(2,3)])

### 1)
firstPart <- unique(retailonline[, c(1,7,5)])
head(firstPart)

### 2)
secondPart <- aggregate(list(Amount=retailonline$Amount),
                        by=list(InvoiceNo=retailonline$InvoiceNo),
                        FUN=sum)
head(secondPart)

### 1) + 2)
dataRFM <- merge(firstPart, secondPart, by = "InvoiceNo")
head(dataRFM)

dataRFM <- na.omit(dataRFM)
dim(dataRFM)

### เปลี่ยนชนิดของข้อมูล ให้เหมาะสม
str(dataRFM$InvoiceDate)
library(lubridate)
dataRFM$InvoiceDate <- ymd(dataRFM$InvoiceDate)

## มาวิเคราะห์กัน

library(didrooRFM)
RFM <- findRFM(dataRFM, recencyWeight = 4,
               frequencyWeight = 4,
               monetoryWeight = 4)

head(RFM[, c(1:4)])
head(RFM[, c(5:7)])
head(RFM[, c(1, 8:10, 16)])

tClass <- table(RFM[, 16])
tClass

barplot(tClass, ylim = c(0,1200), col = rainbow(10))

head(RFM[, c(14, 16)])

## ข้อมูลระดับประเทศ
colnames(retailonline)

retail_nodup <- retailonline[!duplicated(retailonline$CustomerID), c(7, 8)]
head(retail_nodup)

colnames(RFM)

RFMCountry <- merge(RFM[, c(1, 8:10, 16)], retail_nodup, by = "CustomerID")
colnames(RFMCountry)

head(RFMCountry)

colnames(RFMCountry) <- c("ID", "Money", "Frequency",
                          "Recency", "Class", "Country")
head(RFMCountry)

table(RFMCountry$Country, RFMCountry$Class)

barplot(table(RFMCountry$Country, RFMCountry$Class),
        col=rainbow(20))


## K-Means clustering
totwss <- NULL
for (i in 2:15) {
  totwss <- append(totwss, kmeans(RFM[, 8:10], centers = i)$tot.withinss)
}
plot(x = 2:15, y = totwss, type = "b",
       xlab = "clusters", ylab = "Total within SS")

## ตรวจสอบ RFM
library(dplyr)
df <- RFM %>%
  select(MonetoryScore, FrequencyScore, RecencyScore)
glimpse(df)

kmeans(df, 11)

df_ClusterCenter <- round(kmeans(df, 11)$center)
df_ClusterCenter

## Project: CDNOW
url = "https://raw.githubusercontent.com/rtheman/CLV/master/1_Input/CDNOW/CDNOW_master.txt"
cdNow <- read.csv(url, header=FALSE, sep="")
colnames(cdNow) <- c("CustomerID", "InvoiceDate", "Quantity", "Amount")
head(cdNow)

dim(cdNow)

library(lubridate)
cdNow$InvoiceDate <- ymd(cdNow$InvoiceDate)
head(cdNow)

library(tibble)
cdNow <- rownames_to_column(cdNow, "InvoiceNumber")
head(cdNow)
