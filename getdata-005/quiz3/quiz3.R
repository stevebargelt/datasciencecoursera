setwd("~/Google Drive/code/getdata-005/quiz3")

datapath <- "./data"
filename <- "housing.csv"

if (!file.exists(datapath)) {
    dir.create(datapath)
}

pathandfilename <- paste(datapath, "/", filename, sep="")
if (!file.exists(pathandfilename)) {
    fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    download.file(fileUrl,destfile="./data/housing.csv",method="curl")
}
data <- read.csv(pathandfilename)


data[which((data$ACR == 3 & data$AGS == 6)),]

data[(data$ACR == 3 & data$AGS == 6)),]

agricultureLogical <- ifelse(data$ACR == 3 & data$AGS == 6, TRUE, FALSE)

which(agricultureLogical) 


