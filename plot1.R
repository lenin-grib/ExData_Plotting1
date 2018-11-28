## read the data assuming file is saved to the working directory
full <- read.table("household_power_consumption.txt", header = T, sep = ";", 
                   colClasses = c("character", "character", "numeric", "numeric", 
                                  "numeric", "numeric", "numeric", "numeric", "numeric"), 
                   na.strings = "?")

## extract data only from the dates 2007-02-01 and 2007-02-02
data <- subset(full, Date == "1/2/2007" | Date == "2/2/2007")

## open png device
png("plot1.png")

## send a distribution of global active power values to png file
hist(data$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")

dev.off()
