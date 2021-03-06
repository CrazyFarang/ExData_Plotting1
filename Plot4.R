fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./data")){dir.create("./data")}  #If there is no Data directory in working directory create one
download.file(fileUrl,"./Data/Power.zip")       #download archive file from given URL. Downloaded 6/5/2014 3:34 PM
unzip("./Data/Power.zip")                       #unzip archive file in Data folder in working directory
d<-read.table("./Data/household_power_consumption.txt",header=TRUE,sep=";", stringsAsFactors=FALSE)     #read the file
dim(d)          #rows=2075259     columns=9
dim(subset(d,d$Date=="?"))    #there are no missing values in Date column
dim(subset(d,d$Time=="?"))    #there are no missing values in Time column
#convert DateTime and Date into Date variables
d$DateTime<-as.POSIXct(paste(d$Date, d$Time), format="%d/%m/%Y %H:%M:%S")      #concatenate date and time in new variable DateTime of type POSIXct
d$Date<-as.Date(as.character(d$Date),"%d/%m/%Y")       #convert character variable in Date
#subset according the condition
data<-subset(d,d$Date>=as.Date("2007-02-01") & d$Date<=as.Date("2007-02-02"))
dim(data)    #rows=2880    columns=10 (9 initial + DateTime)
#convert variables in numeric 
data$Global_active_power<-as.numeric(data$Global_active_power)
data$Voltage<-as.numeric(data$Voltage)
data$Global_reactive_power<-as.numeric(data$Global_reactive_power)
data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
data$Sub_metering_3<-as.numeric(data$Sub_metering_3)
#plot4 save it to Plot4.png file in local repository folder in the working directory
#NOTE: Images are done with TRANSPARENT BACKGROUND like the ones given as example in the forked repository!!!
png(file="./ExData_Plotting1/Plot4.png",width = 480, height = 480, units = "px",bg = "transparent")
par(mfrow=c(2,2))
plot(data$DateTime,data$Global_active_power,type="l",ylab="Global Active Power",xlab="")
plot(data$DateTime,data$Voltage,type="l",ylab="Voltage",xlab="datetime")
plot(data$DateTime,data$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="",col="black")
lines(data$DateTime,data$Sub_metering_2,col="red")
lines(data$DateTime,data$Sub_metering_3,col="blue")
legend("topright", col = c("black", "red","blue"), legend =names(data)[7:9],lty=c(1,1,1),bty="n")
plot(data$DateTime,data$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
dev.off()
