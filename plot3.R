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


png(filename = "plot2.png",
    width = 480, 
    height = 480, 
    units = "px")

with(df_clean, {
  plot(Sub_metering_1~Datetime, type = 'l', col = "black", ylab = "Energy sub metering", xlab = "", xaxt = "n")})

lines(df_clean$Sub_metering_2~df_clean$Datetime, type = "l", col = "red")
lines(df_clean$Sub_metering_3~df_clean$Datetime, type = "l", col = "blue")

axis.POSIXct(1, df_clean$Datetime, format = "%a")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty = 1)

dev.off()
