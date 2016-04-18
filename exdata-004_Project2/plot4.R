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

# plot the fourth chart to answer the question:
# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

library(ggplot2)
library(data.table)

## Convert into data.table
NEI.DT = data.table(NEI)
SCC.DT = data.table(SCC)

coal.scc = SCC.DT[grep("Coal", SCC.Level.Three), SCC]

coal.emissions = NEI.DT[SCC %in% coal.scc, sum(Emissions), by = "year"]
setnames(coal.emissions, 2, "Emissions")

png(filename = "plot4.png", width = 480, height = 480, units = "px")

g = ggplot(coal.emissions, aes(year, Emissions))
g + geom_point(color = "red") + geom_line(color = "green") + labs(x = "Year") + 
    labs(y = expression("Total Emissions, PM"[2.5] * " (tons)")) + labs(title = "Emissions from Coal Combustion for the US")

dev.off()