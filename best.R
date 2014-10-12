best <- function(state, outcome) {
    ## Read outcome data
    
    outcomeList <- read.csv("rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
    
    ## Check that state and outcome are valid
    outcome <- paste("Hospital.30-Day.Death..Mortality..Rates.From", gsub(" ","\\.", outcome), sep = ".")
    print(outcome)
    ## Return hospital name in that state with lowest 30-day death
    
    
    ## rate
}