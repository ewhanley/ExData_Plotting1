## get data
dir.create("./data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/electricPowerConsumption.zip")

## unzip data
unzip("./data/electricPowerConsumption.zip", exdir = "./data")

## load data into R
powerConsumption <- read.table("./data/household_power_consumption.txt", 
        header = TRUE, sep = ";", na.strings = "?")

## subset data to only include data from 2007-02-01 and 2007-02-02
powerConsumption$Date <- as.Date(powerConsumption$Date, format = "%d/%m/%Y")
febPower <- subset(powerConsumption, Date >= "2007-02-01" & Date <= "2007-02-02")

## combine date and time into single POSIXct column
febPower$DateTime <- as.POSIXct(paste(febPower$Date, febPower$Time), 
        format="%Y-%m-%d %H:%M:%S")

## create histogram of global active power
png(file = "plot1.png")
hist(febPower$Global_active_power, col = "red", main = "Global Active Power", 
       xlab = "Global Active Power (kilowatts)")
dev.off()

