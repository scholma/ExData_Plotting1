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

## Open png graphic device, create graph and close device
png(file = "plot2.png")
plot(hpc2$DT,hpc2$Global_active_power, type ="l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()