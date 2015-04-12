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


##Plot 1
png(file="plot1.png",width=480,height=480,units="px")
hist(data$Global_active_power,xlab="Global Active Power (kilowatts)",
     col="red",main="Global Active Power")
dev.off()
