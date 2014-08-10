library(stringr)
# Load data into R, file name must be "household_power_consumption"

p1<-read.table("household_power_consumption.txt",header=TRUE,sep=";")

# Read Date column as date format

p1$Date<-as.Date(p1$Date,format="%d/%m/%Y")

# Take information corresponding to 2007-02-01 to 2007-02-02 using the ISO
# standard for dates 2014-07-13

p1<-p1[p1$Date >= as.Date("2007-02-01",format="%Y-%m-%d")
       &p1$Date <= as.Date("2007-02-02",format="%Y-%m-%d"),]

# set variables as numeric for plotting extra spaces must be eliminated in order
# to convert to numeric appropriately

p1$Global_active_power<-as.numeric(str_trim(p1$Global_active_power))

# Plot 1

hist(p1$Global_active_power,main="Global Active Power",col="red",
     xlab="Global Active Power (kilowatts)")
dev.copy(png,file="plot1.png",width=480,height=480)
dev.off()
dev.off()

