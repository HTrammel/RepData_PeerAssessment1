require(dplyr)
require(ggplot2)
require(lubridate)

unzip("activity.zip", exdir="./data")
df <- read.csv("./data/activity.csv") 
wdf <- df %>% weekdays(date) %>% mutate(weekend = mean(steps, na.rm = TRUE))


cdf <- df %>% group_by(date) %>% summarise(steps = sum(steps))
cdf$date <- ymd(cdf$date)
names(cdf) <- c("Date","Steps")