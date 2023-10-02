pacman::p_load(rio,
               here,
               tidyverse,
               janitor,
               stringr,
               ggplot2)

df <- import("C:/Users/pfairchild/Desktop/household_power_consumption.txt")
 


df_clean <- df %>% 
  subset(Date == "1/2/2007" | Date == "2/2/2007")

rm(df)

Global_active_power <- df_clean$Global_active_power

Global_active_power <- as.numeric(Global_active_power)

png(filename = "plot1.png",
    width = 480, 
    height = 480, 
    units = "px")

hist(Global_active_power, col = "red", main = paste("Global Active Power"), xlab = "Global Active Power (kilowatts)")

dev.off()
