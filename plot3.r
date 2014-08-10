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

# set variables as numeric for plotting, extra spaces must be eliminated in order
# to convert to numeric appropriately

p1$Sub_metering_1<-as.numeric(str_trim(p1$Sub_metering_1))
p1$Sub_metering_2<-as.numeric(str_trim(p1$Sub_metering_2))
p1$Sub_metering_3<-as.numeric(str_trim(p1$Sub_metering_3))

# Set up plot

# In order to get the labels in english

Sys.setlocale("LC_TIME", "C")

plot(p1$DateTime,p1$Sub_metering_1,
     ylab="Energy Sub Metering",xlab="",type="l")
points(p1$DateTime,p1$Sub_metering_2,col="red",type="l")
points(p1$DateTime,p1$Sub_metering_3,col="blue",type="l")

# set Legend

legend("topright",legend=c("sub_metering_1","sub_metering_2","sub_metering_3"),
       col=c("black","red","blue"),lty=c(1,1),y.intersp=0.5,cex=0.75,text.width=45000)
       

dev.copy(png,file="plot3.png",width=480,height=480)
dev.off()
dev.off()