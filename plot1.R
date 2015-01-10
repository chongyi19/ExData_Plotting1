#this function is to generate plot1.png as required
plot1 <-function (){
                #download the dataset if not found in the working directory
                if (!file.exists("exdata-data-household_power_consumption.zip")){
                                url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                                download.file(url, destfile="exdata-data-household_power_consumption.zip",method="curl")
                }
                #unzip the dataset and read in
                unzip("exdata-data-household_power_consumption.zip")
                data<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")
                #subset a 2-day period from the original dataset
                data2<-data[(as.Date(as.character(data$Date),format="%d/%m/%Y")=="2007-02-01")|(as.Date(as.character(data$Date),format="%d/%m/%Y")=="2007-02-02"),]
                #Draw the histogram as required, copy to a png file with required name, turn off device and save to working directory
                hist(data2$Global_active_power,xlab="Gobal Active Power (kilowatts)",ylab="Frequency",col=2, main="Global Active Power",ylim=range(0:1200))
                dev.copy(png,file="plot1.png",width=480,height=480,unit="px")
                dev.off()
}