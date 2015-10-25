library(plyr)
library(dplyr)
library(ggplot2)
library(gridExtra)
PM25 <- readRDS("summarySCC_PM25.rds")
Source <- readRDS("Source_Classification_Code.rds")

pattern1 <- "motor vehicle | vehicle"
a1 <- grep(pattern1, Source$Short.Name, ignore.case = TRUE)
Source_MV <- Source$SCC[a1]
Source_MV <- as.character(Source_MV)

# Try to get all the motor vehicle sources
temp_df_old <- NULL
endnum <- length(a1)
for (i in 1:endnum) {
  temp_df <- filter(PM25, SCC == Source_MV[i])
  if (!is.null(temp_df_old)) {
    temp_df_old <- rbind(temp_df, temp_df_old)
  }
  else
  {
    temp_df_old <- temp_df
  }
  
}

# Try to select from the sources which are located in Baltimore and Los Angels
Baltimore_all <- filter(temp_df_old, fips == "24510")
LosAngles_all <- filter(temp_df_old, fips == "06037")

# bind them together
Balt_los_all <- rbind(Baltimore_all, LosAngles_all)
Balt_los_all$year <- factor(Balt_los_all$year)
Balt_los_all$fips <- factor(Balt_los_all$fips)

Balt_los_all <- group_by(Balt_los_all, fips, year)
Balt_los_summary <- summarise(Balt_los_all, Emission_sum = sum(Emissions))


png("plot6.png", bg = "white", height = 1200, width = 800)
g<- ggplot(data = Balt_los_summary, aes(year, Emission_sum)) + geom_point(size = I(5))+ facet_grid(. ~ fips)
print(g)
dev.off()
