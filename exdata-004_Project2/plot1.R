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

# plot the first chart to answer the question:
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?

total.emissions <- with(NEI, aggregate(Emissions, by = list(year), sum))
colnames(total.emissions) <- c("year", "Emissions")
total.emissions$Emissions <- round(total.emissions$Emissions / 1000000, 2) #convert to millions of tons

png(filename = "plot1.png", width = 480, height = 480, units = "px")

plot(total.emissions, type = "b", pch = 18, col = "green", 
     ylab = expression("Total PM"[2.5] * " Emission (millions of tons)"),
     xlab = "Year", main = "Annual Emissions - United States")

dev.off()



