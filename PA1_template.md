# Reproducible Research: Peer Assessment 1

The following libraries were used in this effort.


```r
options(scipen=1, digits=2)
require(dplyr)
```

```
## Loading required package: dplyr
## 
## Attaching package: 'dplyr'
## 
## The following object is masked from 'package:stats':
## 
##     filter
## 
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
require(ggplot2)
```

```
## Loading required package: ggplot2
```

```r
require(lubridate)
```

```
## Loading required package: lubridate
```

```r
require(reshape2)
```

```
## Loading required package: reshape2
```

## Loading and preprocessing the data
In keeping with the project instructions, the following code loads and provides the initial processing of the data.  No processing was required beyond loading the data into a data frame.  


```r
if(!file.exists("./data")) {dir.create("./data")}
unzip("activity.zip", exdir="./data")
df <- read.csv("./data/activity.csv") 
```

## What is mean total number of steps taken per day?
The data were initially grouped by the *date* and the number of *steps* totalled for each day.  The resulting data were stored in a new data frame and the *date* column was changed from a factor to an date. The column names were changed for esthetic reasons.  

The distribution of the total number of steps per day is shown in the histogram below.


```r
cdf <- df %>% group_by(date) %>% summarise(steps = sum(steps))
cdf$date <- ymd(cdf$date)
names(cdf) <- c("Date","Steps")
g <- ggplot(cdf, aes(x = Date, y = Steps)) +
    geom_histogram(stat = "identity")
print(g)
```

![](PA1_template_files/figure-html/daily_steps-1.png) 

```r
mn <- mean(cdf$Steps, na.rm = TRUE)
md <- median(cdf$Steps, na.rm = TRUE)
```

The analysis of the total number of steps per day showed the **mean** to be 10766.19 and the **median** to be 10765.

## What is the average daily activity pattern?


```r
cdf <- df %>% group_by(interval) %>% mutate(ic = ntile(interval, 288))
sdf <- cdf %>% group_by(ic) %>% summarise(steps = mean(steps))
names(sdf) <- c("Interval", "Steps")
g <- ggplot(sdf, aes(x = Interval, y = Steps)) +
    geom_line(stat = "identity")
print(g)
```

```
## Warning: Removed 2 rows containing missing values (geom_path).
```

![](PA1_template_files/figure-html/interval_steps-1.png) 

## Imputing missing values



## Are there differences in activity patterns between weekdays and weekends?
