# Getting and Cleaning Data: Course Project
This is my coursework for Getting and Cleaning Data...

## About the raw data
The dataset is available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). A full description of this data can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The features (561 of them) are unlabeled and can be found in the x_test.txt. 
The activity labels are in the y_test.txt file.
The test subjects are in the subject_test.txt file.

The same holds for the training set.

### Prerequisites for this script:
1. The dataset must be downloaded and extracted
2. the UCI HAR Dataset must be availble in a folder called `UCI_HAR_Dataset`


## About the script and the tidy dataset
The script `run_analysis.R` which will merge the test and training sets together to create a tidy dataset in `tidy.txt`

## Code Book
The `CodeBook.md` file explains the transformations performed and the resulting data and variables.

## Repository Information
`.gitignore` will prevent adding the original dataset `UCI_HAR_DATASET` and the `tidy.txt` to the repository to prevent the user from going over data limits on github.