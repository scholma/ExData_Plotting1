## Download zip file
fileurl1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl1, "file1.zip", mode = "wb")

## Read dataframe, specifying seperator and header
hpc <- read.table(unz("file1.zip", "household_power_consumption.txt"), sep=";", header = T)

## Change Date class 
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")

## Take subset from original data based on 2 dates
hpc2 <- hpc[hpc$Date == "2007-02-01" | hpc$Date == "2007-02-02",]

## Change classes Global Active Power and time 
hpc2$Global_active_power <- as.numeric(as.character(hpc2$Global_active_power))
hpc2$Time <- as.character(hpc2$Time)

## Create Date Time field and convert to POSIXlt
hpc2$DT <- paste(hpc2$Date, hpc2$Time)
hpc2$DT <- strptime(hpc2$DT, "%Y-%m-%d %H:%M:%S")

## convert submetering 1 and 2 to numeric (3 is already numeric)
hpc2$Sub_metering_1 <- as.numeric(as.character(hpc2$Sub_metering_1))
hpc2$Sub_metering_2 <- as.numeric(as.character(hpc2$Sub_metering_2))

## convert Voltage and Global Reactive Power to numeric
hpc2$Voltage <- as.numeric(as.character(hpc2$Voltage))
hpc2$Global_reactive_power <- as.numeric(as.character(hpc2$Global_reactive_power))

## Open png graphic device, create graph and close device
png(file = "plot4.png")
par(mfcol = c(2,2))
plot(hpc2$DT,hpc2$Global_active_power, type ="l", xlab = "", ylab = "Global Active Power (kilowatts)")
plot(hpc2$DT,hpc2$Sub_metering_1, type = "l", col ="Black", xlab = "", ylab = "Energy sub metering")
lines(hpc2$DT,hpc2$Sub_metering_2, type = "l", col = "Red")
lines(hpc2$DT,hpc2$Sub_metering_3, type = "l", col = "Blue")
legend(x="topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("Black", "Red", "Blue"), lwd = 1, bty="n")
plot(hpc2$DT,hpc2$Voltage, type ="l", xlab = "datetime", ylab = "Voltage")
plot(hpc2$DT,hpc2$Global_reactive_power, type ="l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()