#Reading the data from the zipped folder (assumed to be saved in working directory)
file.path<-"exdata-data-household_power_consumption.zip"
f.name<-"household_power_consumption.txt"
data <- read.table(unz(file.path,f.name),sep=";",header=TRUE,
                   stringsAsFactors=FALSE,check.names=FALSE)
rm(file.path,f.name)


#Subset the data to only include the desired dates
data<-data[which(data$Date%in%c("1/2/2007","2/2/2007")),]

#CONVERTING COLUMN CLASSES TO CORRECT FORMAT
data$Date<-as.Date(data$Date,format="%d/%m/%Y")
data$Time<-paste(data$Date,data$Time)
data$Time<-strptime(data$Time,format="%Y-%m-%d %H:%M:%S")
data$Global_active_power<-as.numeric(data$Global_active_power)
data$Global_reactive_power<-as.numeric(data$Global_reactive_power)
data$Voltage<-as.numeric(data$Voltage)
data$Global_intensity<-as.numeric(data$Global_intensity)
data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
data$Sub_metering_3<-as.numeric(data$Sub_metering_3)


#Plot4
png("plot4.png",height=480,width=480,unit="px")
par(mfrow=c(2,2))

#Top left plot
plot(data$Time,data$Global_active_power,type="l",xlab="",ylab="Global Active Power")

#Top right plot
plot(data$Time,data$Voltage,type="l",xlab="datetime",ylab="Voltage")

#Bottom left plot
plot(data$Time,data$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(data$Time,data$Sub_metering_2,col="red")
lines(data$Time,data$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"),bty='n',cex=0.95)

#Bottom right plot
plot(data$Time,data$Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type="l")

dev.off()
