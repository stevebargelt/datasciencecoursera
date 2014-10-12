
datapath <- "./data"
filename <- "GDP.csv"
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"

filename2 <- "FEDSTATS.csv"
fileUrl2 <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

######

if (!file.exists(datapath)) {
    dir.create(datapath)
}

pathandfilename <- paste(datapath, "/", filename, sep="")
pathandfilename2 <- paste(datapath, "/", filename2, sep="")

if (!file.exists(pathandfilename)) {
    download.file(fileUrl, destfile=pathandfilename, method="curl")
}

if (!file.exists(pathandfilename2)) {
    download.file(fileUrl2, destfile=pathandfilename2, method="curl")
}

data <- read.csv(pathandfilename,skip=4, nrows = 190)
names(data)[names(data)=="X"] <- "CountryCode"
names(data)[names(data)=="X.1"] <- "GDPRank"

data2 <- read.csv(pathandfilename2)

mergedData <- merge(data, data2, by.x="CountryCode", by.y="CountryCode")

mergedData$GDPRank <- as.numeric(mergedData$GDPRank)
sort(mergedData$GDPRank, decreasing=TRUE)

mergedData <- mergedData[order(mergedData$GDPRank, decreasing = TRUE),]


## Question 4

mean(mergedData$GDPRank[mergedData$Income.Group == "High income: OECD"])
mean(mergedData$GDPRank[mergedData$Income.Group == "High income: nonOECD"])

## Question 5

qualtile()

