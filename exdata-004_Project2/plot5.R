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

# plot the fifth chart to answer the question:
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

library(ggplot2)
library(data.table)

## Convert into data.table
NEI.DT = data.table(NEI)
SCC.DT = data.table(SCC)

motor.vehicle.scc = SCC.DT[grep("[Mm]obile|[Vv]ehicles", EI.Sector), SCC]

motor.vehicle.emissions.baltimore = NEI.DT[SCC %in% motor.vehicle.scc, sum(Emissions), 
                                           by = c("year", "fips")][fips == "24510"]
setnames(motor.vehicle.emissions.baltimore, 3, "Emissions")

png(filename = "plot5.png", width = 480, height = 480, units = "px")

g = ggplot(motor.vehicle.emissions.baltimore, aes(year, Emissions))
g + geom_point(color = "red") + geom_line(color = "green") + labs(x = "Year") + 
    labs(y = expression("Total Emissions, PM"[2.5] * " (tons)")) + 
    labs(title = "Total Emissions from Motor Vehicle Sources in Baltimore City")

dev.off()

