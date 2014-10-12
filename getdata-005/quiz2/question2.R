acs <- read.csv("./data/getdata-data-ss06pid.csv")

sqldf("select pwgtp1 from acs where AGEP < 50")
test1 <- unique(acs$AGEP)
test2 <- sqldf("select distinct AGEP from acs")
