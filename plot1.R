first<-function()
{
  

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

  # first plot
 
  png(filename = './figures/plot1.png', width = 480, height = 480, units='px')
  
  # plot figure
  with(smallPowerData, hist(Global_active_power,xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red"))
  
  # close device
  dev.off()
  
}