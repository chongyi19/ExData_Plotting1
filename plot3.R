#this function is to generate plot3.png as required
plot3 <-function (){
                #download the dataset if not found in the working directory
                if (!file.exists("exdata-data-household_power_consumption.zip")){
                                url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                                download.file(url, destfile="exdata-data-household_power_consumption.zip",method="curl")
                }
                #unzip and read in the whole dataset
                unzip("exdata-data-household_power_consumption.zip")
                data<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")
                #subset the 2-day period to create a smaller dataset
                data2<-data[(as.Date(as.character(data$Date),format="%d/%m/%Y")=="2007-02-01")|(as.Date(as.character(data$Date),format="%d/%m/%Y")=="2007-02-02"),]
                #convert Date and Time format and form a new variable called daytime
                daytime<-paste(as.character(as.Date(as.character(data2$Date),format="%d/%m/%Y")),as.character(data2$Time))
                data2$daytime<-as.POSIXct(daytime)
                #create a png device for the figure
                png("plot3.png")
                #plot the figure with 3 colors for 3 Sub_metering, and add legend for illustration
                plot(data2$daytime,data2$Sub_metering_1,xlab="",ylab="Energy sub metering",ylim=range(0,38),type="n")
                lines(data2$daytime, data2$Sub_metering_1,col="black")
                lines(data2$daytime, data2$Sub_metering_2,col="red")
                lines(data2$daytime, data2$Sub_metering_3,col="blue")
                legend("topright",lwd=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=1)
                #turn off the device and save the png file in the working directory
                dev.off()
}