library(plyr)
library(dplyr)
PM25 <- readRDS("summarySCC_PM25.rds")
Source <- readRDS("Source_Classification_Code.rds")

# 1. subset the PM25 based on their year value
PM25_year <- c(0,0,0,0)
for (i in 1:4)
{
  year_concerned <- 1999 + (i-1)*3
  emission_temp <- filter(PM25, year==year_concerned)
  PM25_year[i] <-  sum(emission_temp$Emissions)
}

#lol it was easier to use dplyr, i wonder why i use the for loop instead, well 
# whats been done is done. 

png("plot1.png", bg = "white", height = 480, width = 480)
par(pch = 17)
plot(c(1999, 2002, 2005, 2008), PM25_year, type = "p",
     xlab = "year", ylab = "Emission (tones)", 
     col = "red", cex = 1.4)
dev.off()



