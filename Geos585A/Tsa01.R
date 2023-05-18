# Tsa01: Time series analysis script 1, GEOS 585A
#
# Reads in time series matrix and store that and metadata in an .RData storage file.
# Goal is a list, tsa with following fields:
#   tsa$dataInFile: (string) file name of input data file
#   tsa$X: (matrix) time series matrix (tsm), with each time series as a column. Ids of the 
#     columns are stored in tsa$id (see below) 
#   tsa$time (vector) numeric, of the times that are in first column of the data file
#   tsa$timeVar (string) the time variable label for first column of the tsm (e.g., "Year")
#   tsa$id: (vector of strings): the ids of the time series; these read from first row of input
#     Vector is 1 shorter than number of columns in input file
#   tsa$units: (vector of strings): the units of those time series; these are read off the second
#     row of the input data file; should be same length as tsa$id
# Saves the list tsa in a file called xxx.RData, where xxx contains your last name (e.g., Meko01.RData),
#
#
# SPECIFICATION OF THE INPUT FILE
#
# Should be format  xlsx, csv or txt, where txt is tab-separated 
# Row 1 should be column headings, starting with the time variable (e.g., "Year") for column 1
# Row 2 should be units for the variables, with "null" for the year column
#   Column heading for data columns should be concise codes or names
#     -begin with a letter and contain only letters or numbers; no special characters, 
#      such as dashes, underscores, dollar signs
#     -no spaces in the headings
#     -length of no more than 12 characters
# Remaining rows should be the data. File should follow rules:
#   Missing data only leading and trailing -- not internal, and as blank, NaN or NA
#
# Time variable should increment by 1 row by row (e.g., 1 year, 1 month one second) and be 
# the same time variable for all series.
#
# Refer to Notes01.pdf for information about types of times series suitable for the course,
# suggested minimum overlap of series, etc.
#
#
#--- TIPS
#
# One obstacle will be properly reading the first two lines separate from the numeric data.
# See https://stackoverflow.com/questions/17797840/reading-two-line-headers-in-r
#
# This script uses a javascript object notation (json) file to specify names of input folders
# and files. The json file is assumed to have the name init01.json. You can tailor and store
# your own json file (e.g. "init01Meko.json") and copy it as "init01.json" to allow different
# setting for different data sets or users.

# Remove all variables except functions
rm(list = setdiff(ls(), lsf.str()))

# LOAD LIBRARIES

library(rjson) # for reading json input files
library(readxl)
library(openxlsx)


#--- JSON INPUT
#
# Names of folder and files are read in from a json file. User tailors that suit user.
# Data are read into a list X

myData <- fromJSON(file="init01.json") # read json file
naJSON <- -99999 # regard -99999 as NA; because json 
X <- myData
for (j in 1:length(X)){
  a <- names(X)[j]
  b <- paste(a,'<-X$',a,sep='')
  s <- paste(a,'<-',b)
  eval(parse(text=s))
}
rm(a,b,s)
library(readxl)

# Check if file exists
if (file.exists(datain_file)) {
  
  # Check file extension
  file_ext <- tools::file_ext(datain_file)
  
  # Check file format
  if (file_ext %in% c("xlsx", "txt", "csv")) {
    # File exists and is in the correct format
    
    # Read the file using appropriate function based on the format
    if (file_ext == "xlsx") {
      data <- read_excel(datain_file)
    } else {
      data <- read.table(datain_file, header = TRUE)  # Assuming txt or csv has headers
    }
    
    # Save row 1 to variable "ids"
    ids <- data[1, ]
    
    # Save row 2 to variable "units"
    units <- data[2, ]
    
    # Save the rest of the data as a matrix using variable "ts_data"
    tsa$X <- as.matrix(data[-c(1, 2), ])
    
    # Continue with the rest of the code
    
  } else {
    # File exists but is not in the correct format
    print("File exists but is not in the correct format.")
  }
  
} else {
  # File does not exist
  print("File does not exist.")
}






# Status
#
# List X has elements:
#   code_dir:  folder with any needed user-written functions
#   dataIn_dir: folder with input data 
#   outputDir:  folder that dataOut_file is to be written to
#   dataIn_file:  file with times (can be xlsx, csv or tsv)
#   dataOut_file: name of the output RData storage file


#--- FIND OUT WHICH TYPE OF FILE TIME SERIES ARE STORED IN
#
# Assume can be in an xlsx spreadsheet, a csv file or txt file, which is assumed to 
# be tab-separated
FileTypes <- c('xlsx','csv','txt')

# Let's assume file is xlsx
FileType <-FileTypes[1]


# CREATE EMPTY LIST tsa
# 
# List tsa will eventually have all the data and metadata

tsa <- vector(mode='list', length=6) # initialize empty list for tsa


#---- PULLING TIME SERIES, ETC.









# #
# # Want to not use the sheet names; just assume student has one sheet
# #file_path <- "C:/Users/15203/OneDrive/Documents/GitHub/geos585-R/Geos585A/GeosTrialData.xlsx"
# #data <- read_excel(file_path, sheet = "treeDataTreeRO1876R", n_max = 2)
# tsa$dataIn_file <- X$dataIn_file # store name of input file in the list tsa
# pf <- paste(X$dataIn_dir,X$dataIn_file,sep='')
# data <- read_excel(pf, n_max = 2)
# 
# row_1 <- data[1, ]
# row_2 <- data[2, ]


library(readxl)
#file_path <- "C:/Users/15203/OneDrive/Documents/GitHub/geos585-R/Geos585A/GeosTrialData.xlsx"
data1 <- read_excel(file_path, sheet = "treeDataTreeRO1876R", range = "A1:XFD150")
ids <- as.character(data1[1, ])
units <- as.character(data1[2, ])
ts_data <- as.matrix(data1[-c(1,2),])


 
