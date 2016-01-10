##STEP1: download, create the file, set date variables amd subset

##set your Coursera Working Directory
setwd("")
# Download and unzip the dataset:
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "hpc.zip", method="curl")
unzip("hpc.zip")
# now import your file and create a table
hpc<-read.table("household_power_consumption.txt", 
                header = TRUE, sep = ";", stringsAsFactors = FALSE)
# create a variable using strptime that represent Date and Time together
hpc$datetime <- strptime(paste(hpc$Date, hpc$Time, sep=" "), 
                         "%d/%m/%Y %H:%M:%S")
# set the Date column as DATE to subset our dataset
hpc$Date <- as.Date(hpc$Date, format="%d/%m/%Y")
# do subset for two days
subset<-subset(hpc, subset=(Date=="2007-02-01" | Date=="2007-02-02"))

## STEP2: create all the figures

#Plot 4
par(mfrow=c(2,2), mar=c(4,4,1,1))

with(subset, plot(datetime, Global_active_power, type = "l",
                  ylab = "Global Active Power", xlab = "",
                  cex.lab=0.8,cex.axis=0.8))

with(subset, plot(datetime, Voltage, type = "l",cex.lab=0.8,
                  cex.axis=0.8))

with(subset, plot(datetime, Sub_metering_1, type = "n", 
                  xlab = "", ylab = "Energy sub metering", cex.lab=0.8,
                  cex.axis=0.8))
lines(subset$datetime, subset$Sub_metering_1, col="black")
lines(subset$datetime, subset$Sub_metering_2, col="red")
lines(subset$datetime, subset$Sub_metering_3, col="blue")
legend("topright", lty = 1, lwd = 2, col = c("black","blue","red"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       cex = 0.7, bty = "n")

with(subset, plot(datetime, Global_reactive_power, type = "l",
                  cex.lab=0.8,cex.axis=0.8))


dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
