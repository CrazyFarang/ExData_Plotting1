d<-read.table("./Data/household_power_consumption.txt",header=TRUE,sep=";", stringsAsFactors=FALSE)
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
data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
data$Sub_metering_3<-as.numeric(data$Sub_metering_3)
#plot3 save it to Plot3.png file in local repository folder in the working directory
png(file="./ExData_Plotting1/Plot3.png",width = 480, height = 480, units = "px",bg = "transparent")
plot(data$DateTime,data$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="",col="black")
lines(data$DateTime,data$Sub_metering_2,col="red")
lines(data$DateTime,data$Sub_metering_3,col="blue")
legend("topright", col = c("black", "red","blue"), legend =names(data)[7:9],lty=c(1,1,1))
dev.off()
