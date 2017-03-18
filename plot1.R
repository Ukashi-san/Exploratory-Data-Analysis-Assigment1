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

## this par is creating the chart  in png file (plot1.png)
 
png(filename = "plot1.png",width = 480, height = 480, units = "px", pointsize = 12, bg = "white")
hist(data$Global_active_power, col = "Red", main  = "Global Active Power", xlab = "Global active power (kilowatts)")
dev.off()