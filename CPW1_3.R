data <- read.table("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE) 
colnames(data) <- c("Date", "Time", "Global_active_power","Global_reactive_power", "Voltage", "Global_intensity", 
                    "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

data$Date <- with (data, as.Date(Date, "%d/%m/%Y"))

datasubset <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

datetime <- paste(as.Date(datasubset$Date), datasubset$Time)
datasubset$datetime <- as.POSIXct(datetime)

#Plot 3
par(mfcol = c(1,1)) #to make sure there is room for only one graph on the canvas
SM1 <- datasubset$Sub_metering_1
SM2 <- datasubset$Sub_metering_2
SM3 <- datasubset$Sub_metering_3
dt <- datasubset$datetime

plot(SM1~dt, type="l", xlab="", ylab="Energy sub metering")
lines(SM2~dt,col='Red')
lines(SM3~dt,col='Blue')
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file = "plot3.png", width=480, height=480)
dev.off()
