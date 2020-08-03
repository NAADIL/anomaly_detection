library(AnomalyDetection)
library(hrbrthemes)
library(tidyverse)
library(extrafont)
library(dplyr)
library(lubridate)

data <- read.csv("NORMAL_HLY_sample_csv.csv")

data_use <- select(data, DATE, HLY.TEMP.NORMAL)
data_use$DATE <- as.character(data$DATE)
data_use$DATE <- ymd_hm(data_use$DATE)
data_use$HLY.TEMP.NORMAL[5] <- 500

res <- ad_ts(data_use, max_anoms = 0.02, direction='both')

glimpse(res)
## Observations: 131
## Variables: 2
## $ timestamp <dttm> 1980-09-25 16:05:00, 1980-09-29 06:40:00, 1980-09-29 21:44:00, 1980-09-30 17:46:00, 1980-09-30 1...
## $ anoms     <dbl> 21.3510, 193.1036, 148.1740, 52.7478, 49.6582, 35.6067, 32.5045, 30.0555, 31.2614, 30.2551, 27.38...

# for ggplot2
ggplot() +
        geom_line(
                data=data_use, aes(DATE, HLY.TEMP.NORMAL), 
                size=0.125, color="lightslategray"
        )  +
        geom_point(
                data=res, aes(timestamp, anoms), color="#cb181d", alpha=1/3
        ) +
        scale_x_datetime(date_labels="%b\n%Y") +
        scale_y_comma() +
        theme_ipsum_rc(grid="XY")
