# R Script to produce plot1.png
#
# Author:  David Guinivere
#
# This script assumes the raw data file is named hcp.txt which 
# contains 9 variables and 2,075,259 observations.
#
plot1 <- function () {
        # Read in the data
        hpc <- read.table("hpc.txt",header=TRUE,sep=";")
        # Now reduce to just the 2/1/2007 and 2/2/2007 data we will be using
        hpc<-hpc[which((hpc$Date=="1/2/2007")|(hpc$Date=="2/2/2007")),]
        # Isolate the Global_active_power variable into its own vector
        gap <- hpc$Global_active_power
        gap <- suppressWarnings(as.numeric(levels(gap))[gap])
        # Plot the histogram and creat plot1.png
        hist(gap, col="red", main = "Global Active Power", 
             xlab = "Global Active Power (kilowatts)")
        png("plot1.png")
        hist(gap, col="red", main = "Global Active Power", 
             xlab = "Global Active Power (kilowatts)")
        dev.off()
}