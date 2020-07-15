# reading and preparing the data
getwd()
dat <- read.table("./data/household_power_consumption.txt", sep = ";", header = TRUE)
datos <- subset(dat, Date == "1/2/2007" | Date == "2/2/2007")

datos$Date <- as.Date(datos$Date, "%d/%m/%Y")
datos$Time <- strptime(datos$Time, "%H:%M:%S")

dim(datos)[1] /2
datos[1441,]
?format
datos[1:1440, "Time"] <- format(datos[1:1440, "Time"], "2007-02-01 %H:%M:$S")
datos[1440:2880, "Time"] <- format(datos[1440:2880, "Time"], "2007-02-02 %H:%M:$S")
datos$Global_active_power <- as.numeric(datos$Global_active_power)
datos$Global_reactive_power <- as.numeric(datos$Global_reactive_power)
datos$Voltage <- as.numeric(datos$Voltage)
datos$Global_intensity <- as.numeric(datos$Global_intensity)
datos$Sub_metering_1 <- as.numeric(datos$Sub_metering_1)
datos$Sub_metering_2 <- as.numeric(datos$Sub_metering_2)

# Plot 4
par(mfrow = c(2,2))

with(datos, {
        plot(datos$Time, datos$Global_active_power, type="l", xlab="",
             ylab="Global Active Power")
        plot(datos$Time, datos$Voltage, type="l", xlab="datetime", ylab="Voltage")
        plot(datos$Time, datos$Sub_metering_1, type = "l", xlab = "",
             ylab = "Energy Sub metering")
        with(datos, lines(datos$Time, datos$Sub_metering_2, col = "red"))
        with(datos, lines(datos$Time, datos$Sub_metering_3, col = "blue"))
        legend("topright", pch = "_", col = c("black", "red", "blue"),
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               cex = 0.4)
        plot(datos$Time, datos$Global_reactive_power,
             type="l", xlab="datetime", ylab="Global_reactive_power")
})
