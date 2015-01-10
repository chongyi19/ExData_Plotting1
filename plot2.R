#this function is to generate plot2.png as required
plot2 <-function (){
                #download the dataset if not found in the working directory
                if (!file.exists("exdata-data-household_power_consumption.zip")){
                                url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                                download.file(url, destfile="exdata-data-household_power_consumption.zip",method="curl")
                }
                #unzip the dataset and read in
                unzip("exdata-data-household_power_consumption.zip")
                data<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")
                #subset a 2-day period
                data2<-data[(as.Date(as.character(data$Date),format="%d/%m/%Y")=="2007-02-01")|(as.Date(as.character(data$Date),format="%d/%m/%Y")=="2007-02-02"),]
                #convert the Date and Time format and form a new variable called daytime
                daytime<-paste(as.character(as.Date(as.character(data2$Date),format="%d/%m/%Y")),as.character(data2$Time))
                data2$daytime<-as.POSIXct(daytime)
                #plot the required figure on the screen
                plot(data2$daytime,data2$Global_active_power,ylab="Global Active Power (kilowatts)",xlab="",type="l")
                #copy the figure to a png file with required file name, and turn off device to save to working directory
                dev.copy(png,file="plot2.png",width=480,height=480,unit="px")
                dev.off()
}