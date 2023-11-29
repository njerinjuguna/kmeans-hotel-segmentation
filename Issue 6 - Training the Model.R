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

            #cross validation
library(caret)
numeric_cols <- c("Price", "ReviewsCount", "Rating")
Hoteldata_numeric <- Hoteldata[, numeric_cols]
set.seed(123)  # for reproducibility
ctrl <- trainControl(method = "cv", number = 10)
model <- train(Price ~ ReviewsCount + Rating, data = Hoteldata_numeric, method = "lm", trControl = ctrl)
print(model)

            #Model training for classification)
library(caret)

# Assuming your dataset is already loaded and named Hoteldata

# Data preprocessing
Hoteldata_for_model <- Hoteldata[, c("Price", "ReviewsCount", "Rating", "Type")]

# Using caret's createDataPartition for stratified sampling
set.seed(123)
trainIndex <- createDataPartition(y = Hoteldata_for_model$Type, p = 0.8, list = FALSE)
train_data <- Hoteldata_for_model[trainIndex, ]
test_data <- Hoteldata_for_model[-trainIndex, ]





# Train the classification model (logistic regression as an example)
model <- train(Type ~ Price + ReviewsCount + Rating, 
               data = train_data, 
               method = "multinom",  # Assuming "Type" has more than two classes
               trControl = trainControl(method = "cv", number = 10))


                #Model performance comparison using resamples
# Load necessary libraries
library(caret)


Hoteldata_for_model <- Hoteldata[, c("Price", "ReviewsCount", "Rating", "Type")]

# Using createResample for stratified sampling
set.seed(123)
resample_idx <- createDataPartition(y = Hoteldata_for_model$Type, p = 0.8, list = FALSE)
train_data_res <- Hoteldata_for_model[resample_idx, ]
test_data_res <- Hoteldata_for_model[-resample_idx, ]

install.packages("randomForest")
# Train multiple models
model_logistic <- train(Type ~ Price + ReviewsCount + Rating, data = train_data_res, method = "multinom", trControl = trainControl(method = "cv", number = 10))
model_tree <- train(Type ~ Price + ReviewsCount + Rating, data = train_data_res, method = "rpart", trControl = trainControl(method = "cv", number = 10))

# Check for missing values
summary(train_data_res)



# Combine models into a list
models_res <- list(logistic = model_logistic, tree = model_tree)

# Compare model performance
model_resamples <- resamples(models_res)

# Display summary
summary(model_resamples)

# Visualize performance
bwplot(model_resamples)