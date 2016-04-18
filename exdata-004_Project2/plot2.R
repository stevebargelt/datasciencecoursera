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

# plot the second chart to answer the question:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 

NEI.24510 <- NEI[which(NEI$fips == "24510"), ]
total.emissions.baltimore <- with(NEI.24510, aggregate(Emissions, by = list(year), sum))
colnames(total.emissions.baltimore) <- c("year", "Emissions")

png(filename = "plot2.png", width = 480, height = 480, units = "px")

plot(total.emissions.baltimore, type = "b", pch = 18, col = "green", 
     ylab = expression("Total PM"[2.5] * " Emission (tons)"),
     xlab = "Year", main = "Annual Emissions - Baltimore")

dev.off()



