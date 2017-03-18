library(dplyr)
library(lubridate)

## set working directory with all data as working directory in my case (OS: Windows 10) : 

setwd("C:\\Users\\£ukasz\\Documents\\R_projects\\Coursera\\Course4\\Week1\\Assigment")

## download file from required location

file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(file_url, "assigment_data.zip",  method = "curl")

## assign name oof the file to variable
filename <- unzip("assigment_data.zip", list = TRUE)[1,1]
unzip("assigment_data.zip")

## below part do all manipulation on the data
## 1. read data from file
## 2. change entries in Data column into Date format
## 3. select only required part of data
## 4. create additional column  with date and time in POSIXct format

data <- read.table(filename, sep = ";" , header = TRUE, na.strings = "?") %>% 
        mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>% 
        filter(Date >= ("2007-02-01") & Date <= ("2007-02-02")) %>%
        mutate (Fulldate = ymd_hms(mapply(paste, Date, Time, SIMPLIFY = TRUE))) 

## As windows settings are not English I'm temporairly setting all R settings to English.

Sys.setlocale("LC_ALL","English")

## this par is creating the chart  in png file (plot4.png)
 
png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")

par(mfrow = c(2, 2))

## chart 1
plot(data$Fulldate, data$Global_active_power, lty = 1, type = "l", xlab = "", ylab = "Global Active Power")

##chart 2
plot(data$Fulldate, data$Voltage, lty = 1, type = "l", xlab = "datetime", ylab = "Voltage")

## chart 3 
with(data, plot(Fulldate, Sub_metering_1, lty = 1, type = "l", col = "Black", xlab = "", ylab = "Energy sub metering"))
with(data, lines(Fulldate, Sub_metering_2, lty = 1, col = "Red"))
with(data, lines(Fulldate, Sub_metering_3, lty = 1, col = "Blue"))
legend(x= "topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 1, bty = "n", col = c("Black", "Red", "Blue"))

## chart 4

with (data, plot(Fulldate, Global_reactive_power, lty = 1, type = "l", xlab = "datetime"))

dev.off() 

## Setting all R settings back to Polish
Sys.setlocale("LC_ALL","Polish")