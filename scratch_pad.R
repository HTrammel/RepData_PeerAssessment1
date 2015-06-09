require(dplyr)
require(ggplot2)
require(lubridate)


if( ! file.exists( "./data" ) ) { dir.create("./data") }

sourceFile <- "activity.zip"
if( file.exists( sourceFile ) ) { unzip(sourceFile, exdir="./data") }

outFile  <- "./data/activity.csv"
if ( exists("DF") == FALSE ) { DF <- read.csv(outFile) }

ok <- complete.cases(DF)
df <- DF[ok,]
df$date <- ymd(df$date)

cdf <- aggregate(df$steps, by=list(df$date), sum)
names(cdf) <- c("Date","Steps")

g <- ggplot(cdf, aes(x = Date, y = Steps)) +
    geom_histogram(stat = "identity", colour = 'red')
print(g)

