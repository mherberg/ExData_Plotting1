library(data.table)

data <- data.table::fread("household_power_consumption.txt") 

## subset data from 2007-02-01 and 2007-02-02
data <- subset(data, Date == "1/2/2007" | Date =="2/2/2007")

# change data classes
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# create new POSIXlt time column
DateTime <- strptime(paste(data$Date, data$Time, sep=" "), "%Y-%m-%d %H:%M:%S")
data <- cbind(data, DateTime)

## Construct the plot and save it to a PNG file
## with a width of 480 pixels and a height of 480 pixels
## type is plot
## title is empty
## x label is empty (is Weekdays)
## y label "Global Active Power (kilowatts)"
png("plot2.png", width = 480, height = 480)
plot(
        data$DateTime,
        data$Global_active_power,
        type = "l",
        xlab = "Day",
        ylab = "Global Active Power (kilowatts)"
)
dev.off()

