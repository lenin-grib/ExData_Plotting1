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
epc <- data %>% mutate(datetime = dmy_hms(paste(Date, Time))) %>% select(-c(Date, Time))

## open png device
png("plot4.png")

## set the layout for 4 plots
par(mfrow = c(2,2))

## render a plot of GAP values over time
with(epc, plot(datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

## render a plot of Voltage values over time
with(epc, plot(datetime, Voltage, type = "l"))

## render a plot of 3 sub metering levels over time
plot(epc$datetime, epc$Sub_metering_1, type = "l", xlab="", ylab = "Energy sub metering")
lines(epc$datetime, epc$Sub_metering_2, col = "red")
lines(epc$datetime, epc$Sub_metering_3, col = "blue")

## add a legend
legend("topright", legend = c("Sub_metering1", "Sub_metering2", "Sub_metering3"), 
       col = c("black", "red","blue"), lty = 1)

## render a plot of GRP values over time
with(epc, plot(datetime, Global_reactive_power, type = "l"))

dev.off()




