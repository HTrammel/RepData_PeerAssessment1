require(dplyr)
require(ggplot2)
require(lubridate)

unzip("activity.zip", exdir="./data")
df <- read.csv("./data/activity.csv") 
g <- ggplot(df, aes(x = interval, y = steps)) +  geom_line(stat = "identity")
print(g)

# idf <- df %>% group_by(interval) %>% mutate(sm = mean(steps, na.rm = TRUE))
# g <- ggplot(idf, aes(x = interval, y = steps)) +  geom_line(stat = "identity")
# print(g)
# 
# 
# sdf <- idf %>% group_by(interval) %>% summarise(istp = mean(steps, na.rm = TRUE))
# names(sdf) <- c("Interval", "Steps")
# g <- ggplot(sdf, aes(x = Interval, y = Steps)) +  geom_line(stat = "identity")
# print(g)
# # mx <- sdf %>% arrange(desc(Steps)) %>% top_n(1) %>% select(Interval)
# 
