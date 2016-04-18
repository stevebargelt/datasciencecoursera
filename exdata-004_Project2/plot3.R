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

# plot the third chart to answer the question:
# Of the four types of sources indicated by the type 
#  (point, nonpoint, onroad, nonroad) variable, which of these four 
#  sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008?

library(ggplot2)
library(plyr)
NEI.24510 <- NEI[which(NEI$fips == "24510"), ]
total.emissions.baltimore <- with(NEI.24510, aggregate(Emissions, by = list(year), sum))
colnames(total.emissions.baltimore) <- c("year", "Emissions")

total.emissions.baltimore.type <- ddply(NEI.24510, .(type, year), summarize, 
                                        Emissions = sum(Emissions))
total.emissions.baltimore.type$Pollutant_Type <- total.emissions.baltimore.type$type

png(filename = "plot3.png", width = 480, height = 480, units = "px")

qplot(year, Emissions, data = total.emissions.baltimore.type, group = Pollutant_Type, 
      color = Pollutant_Type, geom = c("point", "line"), 
      ylab = expression("Total PM"[2.5] * " Emission (tons)"),
      xlab = "Year", main = "Total Emissions in Baltimore by Type of Pollutant")


dev.off()
