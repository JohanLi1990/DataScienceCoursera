library(plyr)
library(dplyr)
library(ggplot2)
PM25 <- readRDS("summarySCC_PM25.rds")
Source <- readRDS("Source_Classification_Code.rds")

PM25$year <- factor(PM25$year)

pattern1 <- "motor vehicle | vehicle"
a1 <- grep(pattern1, Source$Short.Name, ignore.case = TRUE)
Source_MV <- Source$SCC[a1]
Source_MV <- as.character(Source_MV)

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

Baltimore_MV <- filter(temp_df_old, fips == "24510")
Baltimore_MV <- group_by(Baltimore_MV, year)
MV_summary <- summarise(Baltimore_MV, MV_emission = sum(Emissions))
png("plot5.png", bg = "white", height = 600, width = 600)
qplot(year, MV_emission, data = MV_summary, size = I(4), main = "Baltimore_MV")
dev.off()
