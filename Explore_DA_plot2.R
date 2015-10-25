library(plyr)
library(dplyr)
PM25 <- readRDS("summarySCC_PM25.rds")
Source <- readRDS("Source_Classification_Code.rds")

PM25_year_Baltimore <- c(0,0,0,0)

Baltimore_all <- filter(PM25, fips == "24510")

for (i in 1:4)
{
  year_concerned <- 1999 + (i-1)*3
  emission_temp <- filter(Baltimore_all, year==year_concerned)
  PM25_year_Baltimore[i] <-  sum(emission_temp$Emissions)
}

png("plot2.png", bg = "white", height = 480, width = 480)
par(pch = 17)
plot(c(1999, 2002, 2005, 2008), PM25_year_Baltimore, type = "p",
     xlab = "year", ylab = "Emission (tones)", main = "Baltimore",
     col = "red", cex = 1.4)
dev.off()

