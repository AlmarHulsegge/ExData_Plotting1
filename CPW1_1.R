data <- read.table("household_power_consumption.txt", sep = ";", stringsAsFactors = FALSE) 
colnames(data) <- c("Date", "Time", "Global_active_power","Global_reactive_power", "Voltage", "Global_intensity", 
                    "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

data$Date <- with (data, as.Date(Date, "%d/%m/%Y"))

datasubset <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

datasubset$Global_active_power <- as.numeric(datasubset$Global_active_power)

#Plot 1
par(mfcol = c(1,1)) #to make sure there is room for only one graph on the canvas
GAP <- datasubset$Global_active_power

hist(GAP, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", 
     main = "Global Active Power")

dev.copy(png, file = "plot1.png", width=480, height=480)
dev.off()
