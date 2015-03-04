## set up strings resources
fname <- "household_power_consumption"
zipname <- paste0(fname, ".zip")
txtname <- paste0(fname, ".txt")

## download and extract data (no matter what script is called first)
if (! file.exists(txtname)) {
    if (! file.exists(zipname)) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip",
                      zipname)
    }
    unzip(zipname)
}

## read the file
data <- read.csv(txtname, header = TRUE, sep = ";", na.strings = "?", 
                 check.names = FALSE)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

## get data subset
piece <- data[ which(data$Date == "2007-02-01" | data$Date == "2007-02-02"), ]
piece$Time <- as.POSIXct( paste(piece$Date, piece$Time) )
rm(data)

## make plot assignment and save to device
png("plot2.png")
with(piece, plot(Time, 
                 Global_active_power, 
                 type = "l", 
                 ylab = "Global Active Power (kilowatts)", 
                 xlab = ""))
dev.off()
