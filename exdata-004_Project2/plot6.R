###############################################################################################
## Start of Common Code
## This black doownloads the dataset, unzips it, and loads it into variables we can work with
## It is the same in each of the plot files...
###############################################################################################
#Change the working directory
setwd("~/Google Drive/code/exdata-004/courseProject2")

datapath <- "./data"

if (!file.exists(datapath)) {
    dir.create(datapath)
}

nei_file <- paste(datapath, "/summarySCC_PM25.rds", sep = "")
scc_file <- paste(datapath, "/Source_Classification_Code.rds", sep = "")

if (!file.exists(nei_file) || !file.exists(scc_file)) {
    zipfile <- "data.zip"
    download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", zipfile, method = "curl", quiet = TRUE)
    unzip(zipfile, exdir = "data")
}
# read data to data frames (may take a few minutes)
NEI <- readRDS(nei_file)
SCC <- readRDS(scc_file)
###############################################################################################
###### End of Common Code
###############################################################################################

# plot the sixth chart to answer the question:
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle 
#  sources in Los Angeles County, California (fips == "06037"). 
#  Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)
library(data.table)

## Convert into data.table
NEI.DT = data.table(NEI)
SCC.DT = data.table(SCC)

motor.vehicle.emissions = NEI.DT[SCC %in% motor.vehicle.scc, sum(Emissions), 
                                 by = c("year", "fips")]
setnames(motor.vehicle.emissions, 3, "Emissions")

png(filename = "plot6.png", width = 480, height = 480, units = "px")

g = ggplot(motor.vehicle.emissions[fips == "24510" | fips == "06037"], aes(year, Emissions))
g + geom_point() + geom_line(aes(color = fips)) + 
    scale_color_discrete(name = "Location", breaks = c("06037", "24510"), 
                         labels = c("Los Angeles County", "Baltimore City")) + 
    labs(x = "Year") + 
    labs(y = expression("Total Emissions, PM"[2.5] * " (tons)")) + 
    labs(title = "Annual Motor Vehicle Emissions")


dev.off()

