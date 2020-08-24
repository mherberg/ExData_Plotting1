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
## type is 4 plot, 2x2
## plot 1,1 is plot2
## plot 1,2 is plot3
## plot 2,1 is new datetime x Voltage
## plot 2,1 is new datetime x Global_reactive_power
## plot the 4 graphs
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

plot(
        data$DateTime,
        data$Global_active_power,
        type = "l",
        xlab = "",
        ylab = "Global Active Power"
)

plot(
        data$DateTime,
        data$Voltage,
        type = "l",
        xlab = "datetime",
        ylab = "Voltage"
)

plot(
        data$DateTime,
        data$Sub_metering_1,
        type = "l",
        xlab = "",
        ylab = "Energy sub metering"
)
lines(data$DateTime,
      data$Sub_metering_2,
      type = "l",
      col = "red")
lines(data$DateTime,
      data$Sub_metering_3,
      type = "l",
      col = "blue")
legend(
        c("topright"),
        c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        lty = 1,
        lwd = 2,
        col = c("black", "red", "blue")
)

plot(
        data$DateTime,
        data$Global_reactive_power,
        type = "l",
        xlab = "datetime",
        ylab = "Global_reactive_power"
)
dev.off()