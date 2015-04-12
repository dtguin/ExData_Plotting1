# R Script to produce plot4.png
#
# Author:  David Guinivere
#
# This script assumes the raw data file is named hcp.txt which 
# contains 9 variables and 2,075,259 observations.
#
plot4 <- function () {
        # Read in the data
        hpc <- read.table("hpc.txt",header=TRUE,sep=";")
        # Now reduce to just the 2/1/2007 and 2/2/2007 data we will be using
        hpc<-hpc[which((hpc$Date=="1/2/2007")|(hpc$Date=="2/2/2007")),]
        # Rename some of the variables to make it easier to use
        names(hpc)[names(hpc)=="Global_active_power"] <- "gap"
        names(hpc)[names(hpc)=="Sub_metering_1"] <- "sm1"
        names(hpc)[names(hpc)=="Sub_metering_2"] <- "sm2"
        names(hpc)[names(hpc)=="Sub_metering_3"] <- "sm3"
        # Convert strring value to numeric
        hpc$gap <- suppressWarnings(as.numeric(levels(hpc$gap))[hpc$gap])
        hpc$sm1 <- suppressWarnings(as.numeric(levels(hpc$sm1))[hpc$sm1])
        hpc$sm2 <- suppressWarnings(as.numeric(levels(hpc$sm2))[hpc$sm2])
        # sm3 does not need converting
        # hpc$sm3 <- suppressWarnings(as.numeric(levels(hpc$sm3))[hpc$sm3])  
        # Create vector with the date and time pasted together
        datecol <- paste(hpc$Date, hpc$Time)
        # Format the string values into POSIXct values
        dt <- strptime(datecol, "%d/%m/%Y %H:%M:%S")
        # Add dt as a variable
        hpc$dt <- dt
        # Plot the Global_active_power (gap)  vs  Date/Time (dt)
        par(mfrow=c(2,2))
        with(hpc, {
                plot(dt, gap, type="l", ylab = "Global Active Power (kilowatts)")
                
                plot(dt, Voltage, type="l", xlab = "datetime", ylab = "Voltage")
                
                plot(hpc$dt, hpc$sm1, type='l', xlab="", ylab="Energy sub metering")
                points(hpc$dt, hpc$sm2, type='l', col="red")
                points(hpc$dt, hpc$sm3,type='l', col="blue")
                legend("topright", pch = "_", col = c("black", "red", "blue"),
                        legend = c("Sub-metering_1", "Sub-metering_2", "Sub-metering_3"))
                
                plot(dt, Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power")
        })
        # Create the plot3.png file
        png("plot4.png")
        par(mfrow=c(2,2))
        with(hpc, {
                plot(dt, gap, type="l", ylab = "Global Active Power (kilowatts)")
                
                plot(dt, Voltage, type="l", xlab = "datetime", ylab = "Voltage")
                
                plot(hpc$dt, hpc$sm1, type='l', xlab="", ylab="Energy sub metering")
                points(hpc$dt, hpc$sm2, type='l', col="red")
                points(hpc$dt, hpc$sm3,type='l', col="blue")
                legend("topright", pch = "_", col = c("black", "red", "blue"),
                       legend = c("Sub-metering_1", "Sub-metering_2", "Sub-metering_3"))
                
                plot(dt, Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power")
        })
        dev.off()
}  