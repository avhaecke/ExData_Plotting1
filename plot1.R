
# Load data
data = read.table(file = "household_power_consumption.txt", sep = ";", na.strings = "?", header=TRUE)

# Convert date and time
library('lubridate')
data$date2 = dmy(data$Date)
data$time2 = hms(data$Time)

# select data of interest
library('dplyr')

start_date = ymd("2007-02-01")
end_date = ymd("2007-02-02")
interval = start_date %--% end_date
data_within_time_interval = data %>% filter(date2 %within% interval)

# Combine date and time fields
data_within_time_interval$date_and_time = paste(data_within_time_interval$Date, data_within_time_interval$Time)
data_within_time_interval$date_and_time2 = dmy_hms(data_within_time_interval$date_and_time)

# Plot 1
with(data_within_time_interval, hist(x = Global_active_power,xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col = "red"))
