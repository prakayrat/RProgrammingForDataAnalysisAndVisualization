# Chapter 3

## Base R
### Histograms
library(datasets)
head(airquality)

hist(airquality$Temp)

hist(airquality$Temp, xlab = "Temperature (Degrees Fahrenheit)",
     main = "Temperatures in New York City May 1 - Sep 30, 1973")

hist(airquality$Temp, xlab = "Temperature (Degrees Fahrenheit)",
     main = "Temperatures in New York City May 1 - Sep 30, 1973",
     breaks = 4)

### Density plots
hist(airquality$Temp, xlab = "Temperature (Degrees Fahrenheit)",
     main = "Temperatures in New York City May 1 - Sep 30, 1973",
     probability = TRUE)

lines(density(airquality$Temp))

density(airquality$Temp)

### Bar plots
library(MASS)
head(Cars93[1:3])

table(Cars93$Type)
barplot(table(Cars93$Type))

barplot(table(Cars93$Type), ylim = c(0,25),
        xlab = "Type", ylab = "Frequency",
        axis.lty = "solid",
        space=.5)

### Grouping the bars
library(datasets)
females <- HairEyeColor[, , 2]
females

color.names <- c("brown", "blue", "#8e7618", "green")

t(females)
barplot(t(females), beside = T, ylim = c(0,70),
        xlab = "Hair Color", ylab = "Frequency of Eye Color",
        col = color.names,
        axis.lty="solid")
legend("top", rownames(t(females)),
       cex=0.8,
       fill=color.names, title="Eye Color")

### Pie graphs
library(MASS)
pie(table(Cars93$Type), radius = 0.9,
    col = c("purple", "violetred1", "green3", "cornsilk", "cyan", "grey"))
table(Cars93$Type)

### Scatterplots
library(datasets)
plot(airquality$Ozone, airquality$Temp,
     pch = 16,
     xlab = "Ozone (ppb)", ylab = "Temperature (degrees F)",
     main = "Temperature vs Ozone")

### Scatterplot matrix
library(datasets)
Ozone_Temp_Wind <- subset(airquality, select = c(Ozone, Temp, Wind))
head(Ozone_Temp_Wind)

pairs(Ozone_Temp_Wind, pch = 4)

### Box plots
library(datasets)
boxplot(Temp ~ Month, data = airquality, xaxt = "n")
axis(1, at = 1:5, labels = c("May", "Jun", "Jul", "Aug", "Sep"))

## ggplot2
library(ggplot2)
library(datasets)
ggplot(airquality, aes(x = Temp))

ggplot(airquality, aes(x = Temp)) +
  geom_histogram()

### Histograms
ggplot(airquality, aes(x = Temp)) +
  geom_histogram(bins = 10, color = "black", fill = "grey80") +
  theme_bw() +
  labs(x = "Temperature (Fahrenheit)", y = "Frequency",
       title = "Temperatures in the airquality Data Frame")

### Bar plots
library(MASS)
ggplot(Cars93, aes(x = Type)) +
  geom_bar() +
  labs(y = "Frequency", title = "Car Type and Frequency in Cars93")

### Grouping bar plots
Type_Origin <- subset(Cars93, select = c(Type, Origin))
ggplot(Type_Origin, aes(x = Type, fill = Origin)) +
  geom_bar(position = "dodge", color = "black") +
  scale_fill_grey(start = 0.5, end = 1)

ggplot(Type_Origin, aes(x = Type)) +
  geom_bar(position = "dodge", color = "black",
           aes(fill = Origin))

### Stacked bar plot
library(datasets)
females <- HairEyeColor[, , 2]
females

str(females)

females_df <- data.frame(females)
head(females_df)

str(females_df)

library(ggplot2)
ggplot(females_df, aes(x = Hair, y = Freq, fill = Eye)) +
  geom_bar(position = "dodge", color = "black",
           stat = "identity") +
  scale_fill_grey(start = 0, end = 1)

### Scatterplots
library(MASS)
ggplot(Cars93, aes(x = Price, y = Length)) +
  geom_point()

ggplot(Cars93, aes(x = Price, y = Length, color = Origin)) +
  geom_point(size = 3) +
  scale_color_grey(start = 0, end = 0.5)

library(datasets)
library(tidyr)

airquality_noNA <- drop_na(airquality)
meanOzone <- mean(airquality_noNA$Ozone)
OzoneLevel <- NULL

for(i in 1:nrow(airquality_noNA)) {
  if (airquality_noNA$Ozone[i] <= meanOzone) 
    {OzoneLevel[i] <- "Low level"}
  else
  {OzoneLevel[i] <- "High level"}
  }

df <- cbind(airquality_noNA, OzoneLevel)
head(df)

library(ggplot2)
ggplot(df, aes(x = Wind, y = Temp, color = OzoneLevel)) +
  geom_point(size = 2) +
  scale_color_hue(h = c(10,200))


### 3-Dimensional scatterplot
library(scatterplot3d)
with(airquality,
     scatterplot3d(Temp ~ Wind + Ozone, pch = 19))

### Scatterplot matrix
library(datasets)
library(tidyr)
airquality_noNA <- drop_na(airquality)
subset_a <- subset(airquality_noNA, 
                   select = c(Ozone, Wind, Temp, Solar.R))

library(ggplot2)
library(GGally)
ggpairs(subset_a)

### Box plots
ggplot(airquality, aes(x=as.factor(Month), y=Temp)) +
  geom_boxplot()

ggplot(airquality, aes(x = as.factor(Month), y = Temp)) +
  geom_boxplot() +
  geom_point() +
  labs(y = "Temperature", x = "Month") +
  scale_x_discrete(labels = c("May", "Jun", "Jul", "Aug", "Sep"))

