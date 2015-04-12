# R Script to produce plot2.png
#
# Author:  David Guinivere
#
# This script assumes the raw data file is named hcp.txt which 
# contains 9 variables and 2,075,259 observations.
#
plot2 <- function () {
        # Read in the data
        hpc <- read.table("hpc.txt",header=TRUE,sep=";")
        # Now reduce to just the 2/1/2007 and 2/2/2007 data we will be using
        hpc<-hpc[which((hpc$Date=="1/2/2007")|(hpc$Date=="2/2/2007")),]
        # Isolate the Global_active_power variable into its own vector
        gap <- hpc$Global_active_power
        gap <- suppressWarnings(as.numeric(levels(gap))[gap])
        # Create vector with the date and time pasted together
        datecol <- paste(hpc$Date, hpc$Time)
        # Format the string values into POSIXct values
        dt <- strptime(datecol, "%d/%m/%Y %H:%M:%S")
        # Plot the Global_active_power (gap)  vs  Date/Time (dt)
        plot(dt, gap, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")
        # Create the plot2.png file
        png("plot2.png")
        plot(dt, gap, type="l", xlab = "", ylab = "Global Active Power (kilowatts)")
        dev.off()
}  