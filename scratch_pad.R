require(dplyr)
require(ggplot2)


if( ! file.exists( "./data" ) ) { dir.create("./data") }

sourceFile <- "activity.zip"
if( file.exists( sourceFile ) ) { unzip(sourceFile, exdir="./data") }

outFile  <- "./data/activity.csv"
if ( exists("DF") == FALSE ) { DF <- read.csv(outFile) }

ok <- complete.cases(DF)
cln_df <- DF[ok,]
names(cln_df) <- c("steps","date.measure","interval")
cdf <- tapply(X = cln_df$steps, INDEX = cln_df$date.measure, FUN = sum, simplify = FALSE)
d <-unlist(cdf, use.names = T)
n <- names(d)
df <- data.frame(d, n, stringsAsFactors = F)




# h <- ggplot(df, aes(y=steps)) +
#     geom_histogram()
# print (h)