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

# Bootstrap for mean
set.seed(123)
boot_means <- replicate(1000, mean(sample(Hoteldata$Price, replace = TRUE)))

# Confidence interval for the mean
mean_ci <- quantile(boot_means, c(0.025, 0.975))

# Bootstrap for median
set.seed(123)
boot_medians <- replicate(1000, median(sample(Hoteldata$Price, replace = TRUE)))

# Confidence interval for the median
median_ci <- quantile(boot_medians, c(0.025, 0.975))

# Bootstrap for standard deviation
set.seed(123)
boot_sds <- replicate(1000, sd(sample(Hoteldata$Price, replace = TRUE)))

# Confidence interval for the standard deviation
sd_ci <- quantile(boot_sds, c(0.025, 0.975))



install.packages("boot")




# Load necessary libraries
library(boot)

# Set seed for reproducibility
set.seed(123)

# Function to fit your model
bootstrap_function <- function(data, indices) {
  # Select data using the indices
  resampled_data <- data[indices, ]
  
  # Fit the model on the resampled data
  model_formula <- Rating ~ Type + Price + Place + ReviewsCount
  model <- lm(model_formula, data = resampled_data)
  
  # Return the model parameters or performance metric of interest
  return(coef(model))  # Returning coefficients for simplicity, you can modify this based on your needs
}

# Set the number of bootstrap samples
num_bootstraps <- 100

# Perform bootstrapping to create multiple training sets and train models
bootstrap_results <- boot(data = Hoteldata, statistic = bootstrap_function, R = num_bootstraps)

# Print summary of bootstrapping results
summary(bootstrap_results)

