# หนังสือ R Programming สำหรับการวิเคราะห์และแสดงข้อมูลด้วยภาพ
# ผศ.ประกายรัตน์ วิเศษสงวน และ อ.อมรวิทย์ วิเศษสงวน
# พิมพ์ครั้งที่ 2 กันยายน 2566

# บทที่ 2  ทำงานกับ R packages 

# Chapter 2

## Heads and tails
library(datasets)
head(airquality)
tail(airquality)

## Missing data
mean(airquality$Ozone)
mean(airquality$Ozone, na.rm=TRUE)

## Subsets
Ozone_Month_Day <- subset(airquality,
                          select = c(Month, Day, Ozone))
head(Ozone_Month_Day)

OzoneAugust <- subset(airquality, Month == 8,
                      select = c(Month, Day, Ozone))
head(OzoneAugust)

## R formulas
analysis <- lm(Temp ~ Month, data=airquality)
summary(analysis)

s <- summary(analysis)
s$coefficients[2]
s$call

## tidyverse
library(tidyverse)

### tidyr
airquality1 <- drop_na(airquality)
head(airquality1)

head(airquality, 9)

### tibble
df <- data.frame("2018" = c(1000, 800, 860, 570, 155),
                  "2019" = c(1300, 1200, 1300, 380, 190),
                  "2020" = c(1300, 1500, 1400, 450, 210),
                  "2021" = c(1100, 1850, 1600, 465, 250), 
                  "2022" = c(1400, 2330, 1970, 580, 300))
rownames(df) <- c("Commercial Satellites Delivered", "Satellite Services",
                  "Satellite Ground Equipment", 
                  "Commercial Launches", "Remote Sensing Data")
df

colnames(df) <- c(2018,2019,2020,2021,2022)
df

df["Satellite Services", 2]
df[2, 2]

df <- rownames_to_column(df, var="Industry")
df

### reshape
df_long <- gather(df, Year, Million_dollars, 2:6)
df_long

spread(df_long, Year, Million_dollars)

### dplyr
filter(df_long, Industry == "Satellite Services")

filter(airquality, Day == 1)
