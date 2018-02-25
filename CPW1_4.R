data <- read.table("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE) 
colnames(data) <- c("Date", "Time", "Global_active_power","Global_reactive_power", "Voltage", "Global_intensity", 
                    "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

data$Date <- with (data, as.Date(Date, "%d/%m/%Y"))

datasubset <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

datetime <- paste(as.Date(datasubset$Date), datasubset$Time)
datasubset$datetime <- as.POSIXct(datetime)

datasubset$Global_active_power <- as.numeric(datasubset$Global_active_power)
datasubset$Global_reactive_power <- as.numeric(datasubset$Global_reactive_power)
datasubset$Voltage <- as.numeric(datasubset$Voltage)

#Plot 4 (composite of 4 different plots)
SM1 <- datasubset$Sub_metering_1
SM2 <- datasubset$Sub_metering_2
SM3 <- datasubset$Sub_metering_3
dt <- datasubset$datetime
GAP <- datasubset$Global_active_power
GRP <- datasubset$Global_reactive_power
Volt <- datasubset$Voltage

# create canvas for four plots, 2 rows and 2 columns 
par(mfcol = c(2,2))

### Plot Global Active Power (kilowatts) 
plot(GAP~dt, type="l", xlab="", ylab="Global Active Power", cex.lab=0.9)

### Plot Energy sub metering
plot(SM1~dt, type="l", ylab="Energy sub metering", xlab="", cex.lab=0.9)
lines(SM2~dt,col='Red')
lines(SM3~dt,col='Blue')
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),  bty='n', cex=0.8, inset=c(0.1,0))

## Plot Voltage
plot(Volt~dt, type="l", xlab="datetime", ylab="Voltage", cex.lab=0.9)

## Plot Global_reactive_power
plot(GRP~dt, type="l", xlab="datetime", ylab="Global_reactive_power", cex.lab=0.9)

dev.copy(png, file = "plot4.png", width=480, height=480)
dev.off()
