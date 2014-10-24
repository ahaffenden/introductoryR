# An introduction to statistical analysis adapted from 
# Chapter 4: Foundations for inference from:
#   OpenIntro Statistics - 2nd Edition by
#   David M. Diez, Christopher D. Barr, Mine Cetinkaya-Rundel
#=================================================================
# Section headings relate to slides from:
# Introduciton to statistical inference.pptx
# and book section headings
#======
# 21 Oct 14
#===========================================================================
# Slide: Coed-y-Brenin survey data
#=================================
rm(list=ls())
setwd("")

# All trees recorded in CyB7 in 2011
population <- 

# inspect the elements
head(population, 3)
tail(population, 1)
summary(population)

# Create histograms side by side to show
# population$DBH and population$height
# as per slide

#====================
# Sample of 100 trees from the population to represent data collection
sample1 <- population[sample(nrow(population), 100),]

# Plot these two histograms side by side to compare
# to the entire population

#==============================================
# Variability in estimates
#=========================

# Point estimates - sampling variation
# Create new sample: sample2

# compare the three samples that we now have in the workspace
summary(sample1)
summary(sample2)
summary(population)

#==============================================
# Point estimates are not exact
#=========================
# Running mean - sample1

# create empty data structure for running_mean1
running_mean1 <- c()

# calculate the means incrementaly with 
# each row added sequentially
for(i in 1:nrow(sample1)) {
  
  running_mean1 <- c(running_mean1, mean(sample1$DBH[1:i]) )
  
}

# plot the running mean
plot(running_mean1, type ="l", xlab = "No. samples", ylab = "Mean (cm)")

#========================
#Running mean - sample2

# create empty data structure for running_mean1
...

# calculate the means incrementaly for running_mean2 with 
# each row added sequentially
# you need to use running_mean2 and sample2
...

# now adding points not a new plot
points(running_mean2, type = "l", col = "red")

#==============================================
# Standard error of the sample mean
#===========================

# empty data structure for the sample mean histogram
sample_mean_dist <- c()

# calculate the sample mean for 1000 samples from our
# population - all of same sample size!
for(i in 1:1000) {
  
  sample_mean_dist <- c(sample_mean_dist,
                        mean(population[sample(nrow(population), 100),]$DBH) )
  
}

# plot the sample mean distribution
hist(sample_mean_dist, main = "", xlab = "Sample mean")

abline(v = mean(population$DBH))
abline(v = mean(sample_mean_dist))

# Then plot the means of our two samples
abline(v = mean(sample1$DBH), col = "red")
abline(v = mean(sample2$DBH), col = "red")
#===================================
# Standard error of population mean
#==================================
pop_se <- sd(population$DBH)/sqrt(100)

samp_se <- sd(sample1$DBH)/sqrt(100)

#==========================================================================
# Confidence intervals
#=====================
# An approximate 95% confidence interval

# data structure to hold number of samples,
# mean and upper and lower confidence intervals
mean_ci <- data.frame(sample_no = NA,
                      mean = NA,
                      ci_pos = NA,
                      ci_neg = NA)

# number of samples - using a variable means that if you 
# use this value lots of times you only need to modify it 
# once if you wish to change it
no_samples <- 25

# calculate  the new samples and store in the 
# new data structure
for(i in 1:no_samples) {
  
  temp_mean <- mean(population[sample(nrow(population), 100),]$DBH) 
  temp_sd <- sd(population[sample(nrow(population), 100),]$DBH) 
  temp_se <- temp_sd/sqrt(100)
  
  mean_ci[i, "sample_no"] <- i
  mean_ci[i, "mean"] <- temp_mean
  mean_ci[i, "ci_pos"] <- temp_mean + (1.96*temp_se)
  mean_ci[i, "ci_neg"] <- temp_mean - (1.96*temp_se)
  
}

# plot our mean points
plot(mean_ci$sample_no~mean_ci$mean, 
     xlim = c(min(mean_ci$ci_neg), max(mean_ci$ci_pos)),
     xlab = c("Sample means"),
     ylab = c("Sample number"))

# add the confidence intervals as lines
for(i in 1:nrow(mean_ci)) {
  
  lines( x= c(mean_ci[i,"ci_neg"], mean_ci[i,"ci_pos"]), y = c(i, i))
    
}

# add the true population mean for comparison
abline(v = mean(population$DBH), col = "red")
#===================================================================
# Hypothesis testing
#===================
# Bring in a new dataset that includes HWD tree species
# as well as DF
setwd("C:/Users/red74/Documents/GitHub/introductoryR/2. swirl_open_intro/")

data_in <- read.csv("CyB_data_1.csv", header = T, sep =",")
#================================
# Testing hypotheses using confidence intervals
#===========
# DBH
#====

# subset the data
df_species <- subset(data_in, Species == "DF")
hwd_species <- subset(data_in, Species == "HWD")

df_sample_dbh <- df_species[sample(nrow(df_species), 50),]$DBH
hwd_sample_dbh <- hwd_species[sample(nrow(hwd_species), 50),]$DBH


# Check the mean point estimates for DBH
mean(df_sample_dbh)
mean(hwd_sample_dbh)

# Calculate the Confidence Intervals for the mean of df_sample_dbh as we 
# did earlier

#=============
# Tree height
#============

...

#===========================================================================