fourth<-function()
{
  
  library(datasets)
  library(dbplyr)
  zipfile = "household_power_consumption.zip"
  file = "household_power_consumption.txt"
  URL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  
  
  ## Download the file if needed
  if (!file.exists(zipfile)){
    download.file(URL, zipfile, method="curl")
  }  
  
  ## Unzip the file unless it has been done already
  if (!file.exists(file)) { 
    unzip(zipfile)
  }
  
  # Read the file into a table but exclude the null values ('?')
  powerData<-read.table(file, header=TRUE, sep=";", dec=".", na.strings = '?')
  
  smallPowerData <- subset(powerData, as.character(powerData$Date)=="1/2/2007" | as.character(powerData$Date) =="2/2/2007")
  
  # Check if the folder exists. If not, create it
  if(!file.exists('figures')) dir.create('figures')
  
  
  # The timestanp is a combination of Day and Time. Before I join them, I must convdert the format
  smallPowerData$Date <- as.Date(smallPowerData$Date, format = '%d/%m/%Y')
  smallPowerData$DateTime <- as.POSIXct(paste(smallPowerData$Date, smallPowerData$Time))
  
  # Fourth plot
  png(filename = './figures/plot4.png', width = 480, height = 480, units='px')
  par(mfrow = c(2, 2))
  plot(smallPowerData$DateTime, smallPowerData$Global_active_power, xlab = '', ylab = 'Global Active Power (kilowatt)', type = 'l')
  plot(smallPowerData$DateTime, smallPowerData$Voltage, xlab = 'datetime', ylab = 'Voltage', type = 'l')
  plot(smallPowerData$DateTime, smallPowerData$Sub_metering_1, xlab = '', ylab = 'Energy sub metering', type = 'l')
  lines(smallPowerData$DateTime, smallPowerData$Sub_metering_2, col = 'red')
  lines(smallPowerData$DateTime, smallPowerData$Sub_metering_3, col = 'blue')
  legend('topright', col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd = 1)
  plot(smallPowerData$DateTime, smallPowerData$Global_reactive_power, xlab = 'datetime', ylab = 'Global_reactive_power', type = 'l', ylim = c(0, 0.5))
  
  dev.off()
}