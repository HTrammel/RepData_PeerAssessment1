require(dplyr)
require(ggplot2)
require(lubridate)

if(!file.exists("./data")) {dir.create("./data")}
unzip("activity.zip", exdir="./data")
df <- read.csv("./data/activity.csv") 
df$date <- ymd(df$date)

dte_df <- df %>% group_by(date) %>% summarise(steps = sum(steps))
g1 <- ggplot(dte_df, aes(x = date, y = steps)) +
    geom_histogram(stat = "identity", fill = "red", colour = "red") +
    ggtitle("Mean Total Number of Steps per Day") +
    xlab("Date") +
    ylab("Number of Steps")
print(g1)
mn <- mean(dte_df$steps, na.rm = TRUE)
md <- median(dte_df$steps, na.rm = TRUE)


na_df <- df %>% group_by(interval) %>% mutate(mstep = mean(steps, na.rm = TRUE))
na_df$steps <- ifelse(is.na(na_df$steps), na_df$mstep, na_df$steps)
nona_df <- na_df %>% group_by(date) %>% summarise(steps = sum(steps))


g3 <- ggplot(nona_df, aes(x = date, y = steps)) +
    geom_histogram(stat = "identity", fill = "red", colour = "red") +
    ggtitle("Mean Total Number of Steps per Day") +
    xlab("Date") +
    ylab("Number of Steps")
print(g3)
na_mn <- mean(nona_df$steps)
na_md <- median(nona_df$steps)
