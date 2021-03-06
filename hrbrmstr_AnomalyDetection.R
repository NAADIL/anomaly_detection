library(AnomalyDetection)
library(hrbrthemes)
library(tidyverse)
library(extrafont)
font_import()
loadfonts(device = "win")

data(raw_data)

res <- ad_ts(raw_data, max_anoms=0.02, direction='both')

glimpse(res)
## Observations: 131
## Variables: 2
## $ timestamp <dttm> 1980-09-25 16:05:00, 1980-09-29 06:40:00, 1980-09-29 21:44:00, 1980-09-30 17:46:00, 1980-09-30 1...
## $ anoms     <dbl> 21.3510, 193.1036, 148.1740, 52.7478, 49.6582, 35.6067, 32.5045, 30.0555, 31.2614, 30.2551, 27.38...

# for ggplot2
raw_data$timestamp <- as.POSIXct(raw_data$timestamp)

ggplot() +
        geom_line(
                data=raw_data, aes(timestamp, count), 
                size=0.125, color="lightslategray"
        )  +
        geom_point(
                data=res, aes(timestamp, anoms), color="#cb181d", alpha=1/3
        ) +
        scale_x_datetime(date_labels="%b\n%Y") +
        scale_y_comma() +
        theme_ipsum_rc(grid="XY")
