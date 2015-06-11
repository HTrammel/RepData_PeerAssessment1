require(dplyr)
require(ggplot2)
require(lubridate)

unzip("activity.zip", exdir="./data")
df <- read.csv("./data/activity.csv") 
idf <- df %>% group_by(interval) %>% mutate(ic = ntile(interval, 288))

cdf <- df %>% group_by(date) %>% summarise(steps = sum(steps))
cdf$date <- ymd(cdf$date)
names(cdf) <- c("Date","Steps")

sdf <- idf %>% group_by(ic) %>% summarise(istp = mean(steps))
names(sdf) <- c("Interval", "Steps")


l <- filter(df, is.na(steps))