x <- read.fwf(file=url("http://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"),
              skip=4,
              widths=c(12, 7,4, 9,4, 9,4, 9,4))
sum(x["V4"])
