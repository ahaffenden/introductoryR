# Introduction to R using the Hull air pollution data 2003 - 2008. 
# Austin Haffenden 03Oct12
# Modified: 14Oct14
#==========================================================================
# Introduction
#============
# This script is a guided investigation Hull air pollution data dating from
# 2003 to 2008. The data is in micro grams per cubic metre (µg m-3)
# The tasks set are:
#=====
# 1.  Use the air pollution data calculate the following for ozone levels 
#     from the 2003 and 2008 data:
#     a. Mean
#     b. Mode
#     c. Median
#     d. Minimum
#     e. Maximum
#     f. Standard deviation
#================
# 2. Illustrate the ozone data for 2003 and 2008 using a histogram:
#     a) Determine an appropriate class interval. The easiest method to 
#       define the class intervals is to find the minimum and maximum 
#       values and then calculate the range of 5-7 equally sized class
#       intervals.
#================
# 3. Use a statistical test to decide if there is a significant difference 
#    in the average pollutant levels measured in 2003 and 2008.
#================
# 4. Using your results answer the following questions:
#     a) Have air quality levels improved for the pollutant?
#     b) Have there been any exceedances over the National Standards?
#        (see: http://aqma.defra.gov.uk/aqma/objectives.php)
#================
# 5. Carry out the same analysis on the other pollutant data
#==========================================================================
# R Introduction:
# 
# Before we can carry out the analysis we need to bring the data into R
#================
# clear the workspace (memory) of data so that there isn't any confusion
rm(list=ls() )

# You can either copy and paste the line or highlight it and press Ctrl-R
   
# find out what the current working directory is
getwd()

# Tell R where to look for the data we are going to use
# set the working directory to where the data is saved following ONE of 
# these two conventions:
# setwd("C:/path/to/your/file") # forward slashes instead of backslashes
# setwd("C:\\path\\to\\your\\file) # two backslashes instead of one
setwd("C:/Users/red74/Documents/Teaching/ESC40007_Spatial_Geoscience/data")

# read in the data to a data structure called "data_in"
data_in <- read.csv("hull_air_pollution_data_2003_2008.csv")

# This is an excel file saved as a .csv file. It has been modified
# in the following ways:
#   1. surplus column headings have been deleted so the top row is the 
#      variable names
#   2. the variable names have been changed so that r accepts them (no 
#      gaps or random characters)
#   3. numbers have been converted to their full lengths
#   4. I have added a row for the 29/02/2008 (even though this doesn't exist) filled with NA
#      so that the 2003 and 2008 data are the same length
#   5. blank spaces have been replaced by "NA" which R accepts as a null 
#      value (not the same as 0)
#=================
# Missing values
# Denoted by NA or NaN - not the same
x <- c( 1,    2,    NA,   10,   3)
is.na(x)
# [1] FALSE FALSE  TRUE FALSE FALSE
is.nan(x)
# [1] FALSE FALSE FALSE FALSE FALSE

x <- c( 1,    2,    NaN,  NA,   4)
is.na(x)
# [1] FALSE FALSE  TRUE  TRUE FALSE
is.nan(x)
# [1] FALSE FALSE  TRUE FALSE FALSE
x <- 0/0
# [1] NaN
#==================================
# inspect the data by calling the name of the data structure we assigned it 
# to: data_in
data_in # this prints the whole file to screen

# you can see here that instead of regular rows and columns we have 
# continuous data with the addition of "\t". Why is this?

data_in <- read.csv("hull_air_pollution_data_2003_2008.csv", 
                    sep="\t", header = T) # re-reads in the data allowing 
                                          # for "\t"

# inspect the data again 
data_in # prints the whole file to screen. It should now be in regular rows. 
        # Shout if it isn't!

# print the first six lines to screen by passing the name of the 
# data_structure to the function head()
head(data_in) 

# compare this with the csv file just to be sure. 
# Excel is not good for .csv files. I prefer to use OpenOffice.org. 
# However in this case use Excel but do not save or modify the open file 
# in any way just in case we need to reload the data - maybe make it read
# only before opening it

# inspect the details of function head() using the command 
# help(function name) which can be accessed for most functions. 
# How would we inspect the first 10 rows of data_in? The first 20 lines?
help(head)

tail(data_in) # prints the last six lines to screen 
              # compare this with the original data file

nrow(data_in) # the number of rows in the data structure
              # compare with data file

names(data_in) # column headers - compare these with the data file
#==========================================================================
# Now that the data is in to R and correctly formatted we can start the 
# analysis
#==========================================================================
# Task 1.Using the air pollution data calculate the following for ozone 
# levels from the 2003 and 2008 data:
#   a. Mean
#   b. Mode
#   c. Median
#   d. Minimum
#   e. Maximum
#   f. Standard deviation
#==========================================================================
# The in built summary function provides: Min, 1st quartile, Median, Mean, 
# 3rd quartile, Max
summary(data_in)

# This gives you the summary data for all the variables (column names in the
# data structure). If we only want the value for the ozone data we need to 
# select its column. We can do this in several ways:

# 1. We can use the variable (column) name like this:
head(data_in[,"ozo_03"]) # here we have nested the head() function from 
                         # earlier with a command accessing the column we
                         # want

# 2. We can use the column name like this:
head(data_in$ozo_03)

# 3. We can us the column number- count manually
head(data_in[,7])

#======
# what is happening when we input:
head(data_in[1,"ozo_03"])

# so to get the summary data only for ozo_03
summary(data_in[,"ozo_03"])

# This is one of the strengths of R: you can carry out operations on 
# multiple data at the same time
#=======================
# Mode, Median and Standard Deviation are not standard in built R 
# functions. We will need to  import seperate functions from a library 
# (Package). To find which library you need it is usually sufficient to 
# do a Google search. Search now for "Standard deviation 
# R" (without ""). The top link should be: 
# http://stat.ethz.ch/R-manual/R-patched/library/stats/html/sd.html
#
# Click on it. This gives a description of the function and the package 
# it is from {stats}. # {stats} denotes that it is a library called 'stats'.
# This page layout also shows that it is an official piece of R documentation. 
# NOTE: Stats package is no included as a base package in R
# If we click on the index link at the bottom of the page it takes 
# us to the documentation page for the stats library. Scrolling down we can 
# find that there is also a function for "median" (though not for mode)
#======================
# First lets check that the package "stats" is not already installed
installed.packages()

# If the package is already installed (it should be) you would not 
# normally need to complete the next steps 
# but it will be useful to go through them anyway. 
#======================
# There are (at least) two ways to install packages.

# 1. Download from the command prompt. 
# select the download location:
chooseCRANmirror()
# tell R which package to download. This downloads the "Stats" package and any other packages that it
# relies on: dependencies = TRUE
install.packages("stats", dependencies = TRUE)

# 2. Is to use the menu bar at the top of the RGui. What is the RGui?
# Select: Packages -> Set CRAN mirror -> 
#         UK (Bristol, London or St Andrews) -> OK
# Select the package from the list - as you can see for the "stats" 
# package we need to install it manually. This may be for a variety 
# of reasons e.g.: because it is no longer supported or actively developed 
# or because it is included in current versions of R (as stats is). 

# Now we have the package installed we need to load the library into 
# the workspace. Essentially this informs R that we want to use the
# functions in this package
library(stats)

# Next calculate the Median value
median(data_in$ozo_03, na.rm=TRUE)

# calculate the standard deviation
sd(data_in$ozo_03, na.rm=TRUE)

# To find the mode we need to install a different package called "modeest"
# Check it isn't already installed...

# If necessary install it...

# Load the library to the workspace...

# get the mode for the variable (column) that we want
mfv(data_in$ozo_03) # mfv = most frequent value(s).  

#==========================================================================
# Task 2. Illustrate the ozone data for 2003 and 2008 using a histogram:
#     a) Determine an appropriate class interval. The easiest method to 
#        define the class intervals is to find the minimum and maximum 
#        values and then calculate the range of 5-7 equally sized class 
#        intervals.
#==========================================================================

# To plot the years individually we can use the hist() function. This is in 
# built and R will select classes for us unless we specify them (which we
# will do in a minute)

# Plot the 2003 data
hist(data_in$ozo_03)

# Plot the 2008 data
hist(data_in$ozo_08)
#==========================================================================
# to plot both data sets on the same graph is a little more tricky and 
# requires us to install another package. This time it is the package 
# "plotrix" and it uses the function multhist(). Or you can look at the
# ggplot package. Rather than do that today we will keep it simple. 
# But try it on your own. 
#==========================================================================
# For the purposes of this exercise We will plot two histograms, one on top 
# of the other, for comparison. 

# This command divides the graphics window into 2 rows, 1 column 
# (use c(1,1) to return it to normal)
par(mfrow=c(2, 1))

# We can then plot our two graphs as before
hist(data_in$ozo_03)

hist(data_in$ozo_08)

# What is wrong with leaving it like this? Can we compare the data in this 
# form?
#=======================
# To add the breaks that we want
# Divide the data into seven classes we can get the min and max from summary
summary(data_in$ozo_03) # (2.083 - 103.8)
summary(data_in$ozo_08) # (2.222 - 131.8)

#(131.8 - 2.083) / 6 = 21.6195 

# If we round down to 20 and leave the last class as a catch all 
# (this is the 7th element) We can specify the breakpoints with a vector. 
# It needs to be number of breaks(n = 6) plus 1
breaks <- seq(2, 142, 20) # sequence of numbers from 2 to 142 in steps of 20.
                          # why 142?
breaks # inspect the element

# We can then plot our two graphs as before
hist(data_in$ozo_03, breaks = breaks)

hist(data_in$ozo_08, breaks = breaks)
#================================================
# To add the bin labels to the x axis
# This repeats the code and builds incrementally

# Re-plot the histograms without an x axis: xaxt="n"
hist(data_in$ozo_03, breaks = breaks, xaxt="n")

hist(data_in$ozo_08, breaks = breaks, xaxt="n")

# Specify the x_labels
x_labels <-c( "2-22", "23-42", "43-62", "63-82", "83-102", "103-122", "123<")

# Where to place the labels
ax_breaks <- seq(12, 132, 20)

# Add the labels to the graph (1 denotes x-axis, at is the position, labels 
# are the labels). tick = F means that tick lines aren't drawn for us. 
axis(1, at=ax_breaks, labels = x_labels, tick = F)
#====================================
# Add one common title to the plot
#======

# Re-plot the histograms without an x axis
hist(data_in$ozo_03, breaks = breaks, xaxt="n", main = "Histograms to compare Ozone levels in Hull \n between 2003 (top) and 2008 (bottom)")

hist(data_in$ozo_08, breaks = breaks, xaxt="n", main = "")

# Specify the x_labels - we have already specified these so normally would
# only need to respecify if we change them.How would you check if they
# have been specified
#x_labels <-c( "2-22", "23-42", "43-62", "63-82", "83-102", "103-122", "123<")

# Where to place the labels - likewise already specified
#ax_breaks <- seq(12, 132, 20) # Is this right?

# Add the labels to the graph - we need to do this every time
axis(1, at=ax_breaks, labels = x_labels, tick = F)

#====================================
# Change the x-axis values
#======

# Re-plot the histograms without an x axis
hist(data_in$ozo_03, breaks = breaks, xaxt="n", main = "Histograms to compare Ozone levels in Hull \n between 2003 (top) and 2008 (bottom)", xlab = "Ozone levels 2003 (ugm-3)")

hist(data_in$ozo_08, breaks = breaks, xaxt="n", main = "", xlab = "Ozone levels 2008 (ugm-3)")

# Specify the x_labels - already specified
# x_labels <-c( "2-22", "23-42", "43-62", "63-82", "83-102", "103-122", "123<")

# Where to place the labels - already specified
# ax_breaks <- seq(12, 132, 20) # Is this right?

# Add the labels to the graph (1 denotes x-axis, at is the position, labels is?)
axis(1, at=ax_breaks, labels = x_labels, tick = F)

#====================================
# Standardise the Y axis values
#======

# Re-plot the histograms without an x axis
hist(data_in$ozo_03, breaks = breaks, xaxt="n", 
     main = "Histograms to compare Ozone levels in Hull \n 
             between 2003 (top) and 2008 (bottom)", 
     xlab = "Ozone levels 2003 (ugm-3)", 
     ylim = c(0, 130))

hist(data_in$ozo_08, breaks = breaks, xaxt="n", 
     main = "", 
     xlab = "Ozone levels 2008 (ugm-3)", 
     ylim = c(0, 130))

# Specify the x_labels - already specified
# x_labels <-c( "2-22", "23-42", "43-62", "63-82", "83-102", "103-122", "123<")

# Where to place the labels  - already specified
# ax_breaks <- seq(12, 132, 20) # Is this right?

# Add the labels to the graph (1 denotes x-axis, at is the position, labels is?)
axis(1, at=ax_breaks, labels = x_labels, tick = F)

#==========================================================================
#==========================================================================
# Task 3. Use a statistical test  to decide if there is a significant 
#         difference between the mean pollutant levels measured in 2003 
#         and 2008.
#===============
# Test the data for normality
# Ozone 2003
shapiro.test(data_in$ozo_03)
# Ozone 2008

# If the data is normally distributed we use the t.test
t.test(data_in$ozo_03, data_in$ozo_08)
# If the data is non-normally distributed we use the Mann-Whitney U Test
wilcox.test(data_in$ozo_03, data_in$ozo_08)

#=====================================
# Another strength of R...once the data is in the workspace (the R Console) 
# then it is accessible for whatever you want to do to it. 
# Look how easy that statistical test was!
#===========================================================================
# 4. Using your results answer the following questions:
#     a) Have air quality levels improved for the pollutant?
#     b) Have there been any exceedances over the National Standards?
#        (see: http://aqma.defra.gov.uk/aqma/objectives.php)
mean(data_in$ozo_03, na.rm = T)
# [1] 43.904
mean(data_in$ozo_08, na.rm = T)
# [1] 55.69445

