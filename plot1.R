setwd("~/Exp_data_Analysis")
library(dplyr)

## calculated the number of rows to download after looking at the first few rows of data.

powerCon<-tbl_df(read.table("./household_power_consumption.txt", nrows=70560, sep=";", header=TRUE, na.strings=c("?")))
powerCon$Date <- as.Date(powerCon$Date, format = "%d/%m/%Y")
powerCon$timetemp <- paste(powerCon$Date, powerCon$Time)
powerCon$Time <- strptime(powerCon$timetemp, format = "%Y-%m-%d %H:%M:%S")
startdate<- as.Date("2007-02-01")
enddate<-as.Date("2007-02-02")
powerCon1<- powerCon[which(powerCon$Date >= startdate & powerCon$Date <= enddate),] #Subset to get obs for the 2 dates.
dim(powerCon1) #2880 10

hist(powerCon1$Global_active_power, main = "Global Active Power",xlab="Global Active Power(kilowatts)",col = "red")
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
