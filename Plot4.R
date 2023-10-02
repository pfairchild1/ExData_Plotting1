pacman::p_load(rio,
               here,
               tidyverse,
               janitor,
               stringr,
               ggplot2,
               lubridate)

df <- import("C:/Users/pfairchild/Desktop/household_power_consumption.txt")

df_clean <- df %>% 
  subset(Date == "1/2/2007" | Date == "2/2/2007")
rm(df)

df_clean$Date <- as.Date(df_clean$Date, '%d/%m/%Y')

datetime <- paste(as.Date(df_clean$Date), df_clean$Time)

df_clean$Datetime <- as.POSIXct(datetime)


png(filename = "plot4.png",
    width = 480, 
    height = 480, 
    units = "px")

#Setting up parameters
par(mfrow=c(2,2))

#Plot 1
plot(df_clean$Datetime, df_clean$Global_active_power, type = 'l', ylab = "Global Active Power (kilowatts)", xlab = "", xaxt = "n")
axis.POSIXct(1, df_clean$Datetime, format = "%a")

#Plot 2
plot(df_clean$Datetime, df_clean$Voltage, type = "l", ylab = "Voltage", xlab = "datetime", xaxt = "n")
axis.POSIXct(1, df_clean$Datetime, format = "%a")

#Plot 3
with(df_clean, {
  plot(Sub_metering_1~Datetime, type = 'l', col = "black", ylab = "Energy sub metering", xlab = "", xaxt = "n")})

lines(df_clean$Sub_metering_2~df_clean$Datetime, type = "l", col = "red")
lines(df_clean$Sub_metering_3~df_clean$Datetime, type = "l", col = "blue")

axis.POSIXct(1, df_clean$Datetime, format = "%a")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty = 1)


#Plot 4
plot(df_clean$Datetime, df_clean$Global_reactive_power, type = 'l', xaxt = "n", ylab = "Global_reactive_power", xlab = "datetime")
axis.POSIXct(1, df_clean$Datetime, format = "%a")

dev.off()
