# Nitrate practical and assessment for introductoryR
# Austin Haffenden
# Gaps in text denoted by ... require completion of code 
# 30 Oct 14
#===============================================================================
# Overview: A water supplier is abstracting groundwater from boreholes and 
# wants to know the quality of the water before using it for supply. 

# The WHO threshold for nitrate concentrations allowed in drinking water is 
# 11.3 mg/l. 

# clear the workspace
...
# Assign the value of 11.3 to a variable called threshold  
...
#==================================================================
# Bring the data into R
#======================

# set your working directory 
...

# read in the data file "nitrate_data.csv"
data_in <- ...

# Tell R that the first column is a date. This is for plotting later.
# Make sure that you run this line of code!
data_in$date <- as.Date(data_in$date)

# inspect the head of the data file
...
# inspect the tail of the data file
...
# inspect the column names
...
# check the number of rows
...
# check the number of columns
...
#===============================================================================
# Tasks From the accompanying worksheet
#======================================
# Task 1. 
# What are the highest, the lowest and the average concentrations measured over 
# the entire time period in each of the boreholes (min, max, mean)? 
#
# summarise the data
...

# how would you get the min, max and mean value of borehole a1?
# min
...
# max
...
# mean
...
#===============================================================================
# Task 2. 
# A: Which boreholes show concentrations above the threshold? 
#    (HINT: you already have this information)
#    Write as a comment here: ...

# B: At which dates are threshold concentrations exceeded for these boreholes?
#    (HINT: use the information from part 2.A to subset the data and then you
#     can read off the date)
...

#===============================================================================
# # Task 3. 
# Assuming it is only economically feasible to treat the abstracted water if 75% 
# of the sampled water has concentrations below 6 mg/l - which boreholes should 
# we use for supply? (75% is the 3rd quartile) 
# Write a comment here: ... 

#===============================================================================
# Task 4. 
# On average does the data vary more in between different sample dates or more 
# for different locations? 
# (HINT: You can assess this by calculating the variance over borehole stations
# (columns) and over dates(rows). 
# Step 1: Use the apply function (look at the help file) and apply the variance 
#         function (google it) to data_in by borehole (columns) and then 
#         by dates (rows). 
#         This will give you the variance for each borehole and each date
# Step 2: Calculate the mean of these variances
# Code goes below

# Step 1: By column - borehole
...
# Step 1: By row - date
...

# Step 2: What is the average variance
# For boreholes (columns)
...
# For dates (row)
...
#===============================================================================
# Task 5. 
# What are the temporal trends in the groundwater concentrations for each 
# borehold? Are the concentrations generally rising or falling over the 
# observation period in boreholes: B2, D3, G1 and H3
# (HINT: we only require general trends so:
# Step 1: draw a scatter plot of the data points (for each borehole). Date should 
#         be the independent variable (x) and concentration the dependent (y)
#         You will need the plot() function. 
# Step 2: draw a regression line through the points to visualise the trend
#         You will need the functions: lm() and abline().
#         (MASSIVE HINT: look at the examples in abline's help. You can cut and 
#         paste these examples into your console or script to look at how they 
#         work) )

...