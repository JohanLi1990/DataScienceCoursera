library(plyr)
library(dplyr)
library(ggplot2)
PM25 <- readRDS("summarySCC_PM25.rds")
Source <- readRDS("Source_Classification_Code.rds")

PM25$type <- factor(PM25$type)
PM25$year <- factor(PM25$year)

Emission_year_type <- group_by(PM25, year, type)
Emission_summary <- summarise(Emission_year_type, sum_emission = sum(Emissions))
# Then plot for the graph
png("plot3.png", bg = "white", height = 600, width = 600)
g <- ggplot(Emission_summary, aes(year, sum_emission))
g <- g+geom_point()+ facet_grid(.~ type)
print(g)
dev.off()




