require(dplyr)
require(ggplot2)
require(lubridate)

unzip("activity.zip", exdir="./data")
df <- read.csv("./data/activity.csv") 

mdf <- df %>% group_by(interval) %>% mutate(sm = mean(steps, na.rm = TRUE))

nona_df <- mdf

nona_df$steps <- ifelse(is.na(nona_df$steps), nona_df$sm, nona_df$steps)
nona_df$date <- ymd(nona_df$date)
names(nona_df) <- c("Date","Steps")
g <- ggplot(nona_df, aes(x = Date, y = Steps)) +
    geom_histogram(stat = "identity")
print(g)