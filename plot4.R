#this function is to generate plot4.png as required
plot4 <-function (){
                #download the data if not found in the working directory
                if (!file.exists("exdata-data-household_power_consumption.zip")){
                                url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                                download.file(url, destfile="exdata-data-household_power_consumption.zip",method="curl")
                }
                #unzip and read in the whole dataset
                unzip("exdata-data-household_power_consumption.zip")
                data<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")
                #subset the 2-day period data from the orignal dataset
                data2<-data[(as.Date(as.character(data$Date),format="%d/%m/%Y")=="2007-02-01")|(as.Date(as.character(data$Date),format="%d/%m/%Y")=="2007-02-02"),]
                #add a new variable dealing with Date and Time format
                daytime<-paste(as.character(as.Date(as.character(data2$Date),format="%d/%m/%Y")),as.character(data2$Time))
                data2$daytime<-as.POSIXct(daytime)
                #open png device and set 4 panels position
                png("plot4.png")
                par(mfrow=c(2,2),mar=c(4,4,2,2))
                #plot first and second panel                
                plot(data2$daytime,data2$Global_active_power,ylab="Global Active Power",xlab="",type="l")
                plot(data2$daytime,data2$Voltage,ylab="Voltage",xlab="datetime",type="l")
                #plot third panel with different colors corresponding to different Sub-metering, and add legend  
                plot(data2$daytime,data2$Sub_metering_1,xlab="",ylab="Energy sub metering",ylim=range(0,38),type="n")
                lines(data2$daytime, data2$Sub_metering_1,col="black")
                lines(data2$daytime, data2$Sub_metering_2,col="red")
                lines(data2$daytime, data2$Sub_metering_3,col="blue")
                legend("topright",lwd=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=1)
                #plot fourth panel
                plot(data2$daytime,data2$Global_reactive_power,ylab="Global_reactive_power",xlab="datetime",ylim=range(0,0.5),type="l")
                #turn off the device and save the generated png figure into working directory
                dev.off()              
}