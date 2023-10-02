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

plot(df_clean$Datetime, df_clean$Global_active_power, type = 'l', ylab = "Global Active Power (kilowatts)", xlab = "", xaxt = "n")
axis.POSIXct(1, df_clean$Datetime, format = "%a")

dev.off()



