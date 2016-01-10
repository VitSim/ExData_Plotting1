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

#Plot 2
with(subset, plot(datetime, Global_active_power, type = "l",
                  ylab = "Global Active Power (kilowatts)", xlab = "" ))
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
