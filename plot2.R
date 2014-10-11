## Course Project 1, Plot 2, 12 October 2014

## Load data, assuming working directory is the directory where zip file is located
unzip("exdata_data_household_power_consumption.zip")

## use colClasses to make read.table faster on the large file
top5rows <- read.table("household_power_consumption.txt", header = TRUE, nrows = 5, sep=";")
classes <- sapply(top5rows, class)
data1 <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na="?",
                    comment.char = "", nrows=2075259, colClasses = classes)

## Find the dates of interest (1 Feb 2007 to 2 Feb 2007)
my_dates <- as.Date(data1$Date, "%d/%m/%Y")
dates_needed <- c(grep("2007-02-01",my_dates,fixed=TRUE),
                  grep("2007-02-02",my_dates,fixed=TRUE))

## Subset the data for the dates of interest
data2<-data1[dates_needed,]

## Merge the date and time into one vector
datetime<-as.POSIXct(paste(data2$Date, data2$Time), format="%d/%m/%Y %H:%M:%S")

## Explicitly launch the graphics device
png(file="./plot2.png") 

## Make the line plot
plot(datetime, data2$Global_active_power, type="l", xlab="", # no x-axis label
     ylab="Global Active Power (kilowatts)") # customize the y-axis label

## Explicitly close the graphics device
dev.off() 