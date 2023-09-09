
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

# Plot 3
with(data_within_time_interval, plot(x = date_and_time2, y = Sub_metering_1, xlab = "", ylab = "Energy sub metering", type= "n"))
legend("topright", col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1)

with(data_within_time_interval, points(x = date_and_time2, y = Sub_metering_1,type= "l"))
with(data_within_time_interval, points(x = date_and_time2, y = Sub_metering_2,type= "l", col="red"))
with(data_within_time_interval, points(x = date_and_time2, y = Sub_metering_3,type= "l", col="blue"))

