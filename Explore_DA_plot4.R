library(plyr)
library(dplyr)
library(ggplot2)
PM25 <- readRDS("summarySCC_PM25.rds")
Source <- readRDS("Source_Classification_Code.rds")

pattern1 <- "(.*coal.*comb.*)|(.*comb.*coal.*)"
a1 <- grep(pattern1, Source$Short.Name, ignore.case = TRUE)
Source_Coal <- Source$SCC[a1]
Source_Coal <- as.character(Source_Coal)

PM25$year <- factor(PM25$year)

temp_df_old <- NULL
endnum <- length(a1)
for (i in 1:endnum) {
  temp_df <- filter(PM25, SCC == Source_Coal[i])
  if (!is.null(temp_df_old)) {
    temp_df_old <- rbind(temp_df, temp_df_old)
  }
  else
  {
    temp_df_old <- temp_df
  }
  
}

temp_df_old <- group_by(temp_df_old, year)
coal_summary <- summarise(temp_df_old, Coal_emission = sum(Emissions))
png("plot4.png", bg = "white", height = 600, width = 600)
qplot(year, Coal_emission, data = coal_summary, size = I(4))
dev.off()

# the for loop above costs almost a minute to execute, 
# I would appreciate if you can suggest a more efficent method of subsetting. 




