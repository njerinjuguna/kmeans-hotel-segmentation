#Data splitting is the practice of dividing dataset into two or more subsets:
  #one for training the model and another for evaluating its performance.
  # I will use the caret package to split my data. The createDataPartition 
  #function from caret helps create indices for data splitting.
  # Install and load the caret package if not already installed
  install.packages("caret")
library(caret)

# Set seed for reproducibility
set.seed(123)

# Specifying the proportion of data to be used for testing/validation (In this case; 80% training, 20% testing)
split_index <- createDataPartition(Hoteldata$Price, p = 0.8, list = FALSE)

# Create training set
training_data <- Hoteldata[split_index, ]

# Create testing set
testing_data <- Hoteldata[-split_index, ]

# Check dimensions of training set
dim(training_data)

# Check dimensions of testing set
dim(testing_data)
#Bootstrapping
#Bootstrapping is a resampling technique that involves repeatedly sampling with replacement from 
#a dataset to create multiple "bootstrap" samples. This can be useful for estimating the distribution 
#of a statistic, such as the mean or variance, and can be applied to assess the stability and 
#reliability of your model.
# Install and load the boot package
install.packages("boot")
library(boot)
# Specify the number of bootstrap samples
num_bootstraps <- 1000

# Set the seed for reproducibility
set.seed(123)

# Create a function that performs resampling and fits the model



