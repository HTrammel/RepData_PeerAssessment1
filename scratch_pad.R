require(dplyr)
require(ggplot2)
require(lubridate)

unzip("activity.zip", exdir="./data")
df <- read.csv("./data/activity.csv") 
cdf <- df %>% group_by(interval) %>% mutate(ic = ntile(interval, 288))
sdf <- cdf %>% group_by(ic) %>% summarise(steps = mean(steps))
names(sdf) <- c("Interval", "Steps")
g <- ggplot(sdf, aes(x = Interval, y = Steps)) +
    geom_line(stat = "identity")
#print(g)

