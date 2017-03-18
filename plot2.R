library(dplyr)
library(lubridate)

## set working directory with all data as working directory in my case (OS: Windows 10) : 

setwd("C:\\Users\\£ukasz\\Documents\\R_projects\\Coursera\\Course4\\Week1\\Assigment")

## download file from required location

file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(file_url, "assigment_data.zip",  method = "curl")

## assign name of the file to variable
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

## this part is creating the chart  in png file (plot2.png)
png(filename = "plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")      
plot(data$Fulldate, data$Global_active_power, lty = 1, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off() 

## Setting all R settings back to Polish
Sys.setlocale("LC_ALL","Polish")
