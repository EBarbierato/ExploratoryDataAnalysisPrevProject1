third<-function()
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
  
  # The timestanp is a combination of Day and Time. Before I join them, I must convdert the format
  smallPowerData$Date <- as.Date(smallPowerData$Date, format = '%d/%m/%Y')
  smallPowerData$DateTime <- as.POSIXct(paste(smallPowerData$Date, smallPowerData$Time))
  
  # Check if the folder exists. If not, create it
  if(!file.exists('figures')) dir.create('figures')
  
  # Third plot
  png(filename = './figures/plot3.png', width = 480, height = 480, units='px')
  plot(smallPowerData$DateTime, smallPowerData$Sub_metering_1, col = "black", xlab = '', ylab = 'Energy sub metering', type = 'l')
  lines(smallPowerData$DateTime, smallPowerData$Sub_metering_2, col = "red")
  lines(smallPowerData$DateTime, smallPowerData$Sub_metering_3, col = "blue")
  legend('topright', col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd = 1)
  
  
  dev.off()
 
}