## read the data assuming file is saved to the working directory
full <- read.table("household_power_consumption.txt", header = T, sep = ";", 
                   colClasses = c("character", "character", "numeric", "numeric", 
                                  "numeric", "numeric", "numeric", "numeric", "numeric"), 
                   na.strings = "?")

## extract data only from the dates 2007-02-01 and 2007-02-02
data <- subset(full, Date == "1/2/2007" | Date == "2/2/2007")
rm(full)

## load the lubridate package
library(lubridate)
library(plyr)
library(dplyr)

## replace Date and Time columns with correctly converted DateTime
epc <- data %>% mutate(Datetime = dmy_hms(paste(Date, Time))) %>% select(-c(Date, Time))

## open png device
png("plot2.png")

## render a plot of GAP values over time
with(epc, plot(Datetime, Global_active_power, type = "l", 
               ylab = "Global Active Power (kilowatts)"), xlab = "")

dev.off()
