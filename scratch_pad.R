require(dplyr)
require(ggplot2)
require(lubridate)
require(reshape2)

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


intv_df <- df %>% group_by(interval) %>% summarise(steps = mean(steps, na.rm = TRUE))
g2 <- ggplot(intv_df, aes(x = interval, y = steps)) +
    geom_line(stat = "identity", colour = "red", size = 1) +
    ggtitle("Average Number of Steps per Interval") +
    xlab("Interval") +
    ylab("Number of Steps")
print(g2)
mx <- intv_df %>% arrange(desc(steps)) %>% top_n(1) %>% select(interval)


na_cnt <- sum(is.na(df$steps))
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


wk_df <- na_df %>%
    mutate(weekend = ifelse(weekdays(date, abbreviate = TRUE) %in% c("Sun","Sat"), 
                            "weekend",
                            "weekday"))
wk_df$weekend <- as.factor(wk_df$weekend)
wk_df <- wk_df %>% group_by(weekend, interval) %>% summarise(steps = mean(steps, na.rm = TRUE))


g4 <- ggplot(wk_df, aes(x = interval, y = steps)) +
    geom_line(stat = "identity") +
    facet_grid(weekend ~ .) +
    ggtitle("Average Number of Steps per Interval") +
    xlab("Interval") +
    ylab("Number of Steps")
print(g4)
