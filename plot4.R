setwd("~/Exp_data_Analysis")
library(dplyr)
powerCon<-tbl_df(read.table("./household_power_consumption.txt", nrows=70560, sep=";", header=TRUE, na.strings=c("?")))
powerCon$Date <- as.Date(powerCon$Date, format = "%d/%m/%Y")
powerCon$timetemp <- paste(powerCon$Date, powerCon$Time)
powerCon$Time <- strptime(powerCon$timetemp, format = "%Y-%m-%d %H:%M:%S")
startdate<- as.Date("2007-02-01")
enddate<-as.Date("2007-02-02")
powerCon1<- powerCon[which(powerCon$Date >= startdate & powerCon$Date <= enddate),] #Subset to get obs for the 2 dates.
dim(powerCon1) #2880 10

par(mfrow = c(2,2))
with (powerCon1, {
  plot(Time,Global_active_power, ylab="Global Active Power (kilowatts)", xlab = "",type = "l")
  plot(Time,Voltage, xlab = "datetime", type = "l")
  plot(Time, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
  with(subset(powerCon1), lines(Time,Sub_metering_2, col="red"))
  with(subset(powerCon1), lines(Time,Sub_metering_3, col="blue"))
  legend("top",lty = 1, col = c("black","red","blue"), 
         legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.5, bty = "n") 
  plot(Time,Global_reactive_power, xlab = "datetime", type = "l")
})

dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()
## Cannot spend too much time sorting out the legend box