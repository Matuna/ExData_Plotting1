library(stringr)
# Load data into R, file name must be "household_power_consumption"

p1<-read.table("household_power_consumption.txt",header=TRUE,sep=";")

p1$Date<-as.Date(p1$Date,format="%d/%m/%Y")

# Take information corresponding to 2007-02-01 to 2007-02-02 using the ISO
# standard for dates 2014-07-13

p1<-p1[p1$Date >= as.Date("2007-02-01",format="%Y-%m-%d")
       &p1$Date <= as.Date("2007-02-02",format="%Y-%m-%d"),]

# In order to incorporate time into the date we first combine date and time
# vars then change them to POSIXct

p1<-cbind(p1,strptime(paste(p1$Date,p1$Time),format="%Y-%m-%d %H:%M:%S"))
names(p1)[10]<-"DateTime"

# set variables as numeric for plotting extra spaces must be eliminated in order
# to convert to numeric appropriately

p1$Global_active_power<-as.numeric(str_trim(p1$Global_active_power))

# Set up plot

# In order to get the labels in english

Sys.setlocale("LC_TIME", "C")

plot(p1$DateTime,p1$Global_active_power,
     ylab="Global Active Power (killowatts)",xlab="",type="l")
dev.copy(png,file="plot2.png",width=480,height=480)
#dev.off()
#dev.off()
