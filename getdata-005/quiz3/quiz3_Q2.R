install.packages("jpeg")
library(jpeg)

#Change the working directory
setwd("~/Google Drive/code/getdata-005/quiz3")

# Change these three variables
datapath <- "./data"
filename <- "jeff.jpg"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
######

if (!file.exists(datapath)) {
    dir.create(datapath)
}

pathandfilename <- paste(datapath, "/", filename, sep="")

if (!file.exists(pathandfilename)) {
    download.file(fileUrl, destfile=pathandfilename, method="curl")
}

data <- readJPEG(pathandfilename, native=TRUE)

quantile(data,probs=c(0.3,0.80))


