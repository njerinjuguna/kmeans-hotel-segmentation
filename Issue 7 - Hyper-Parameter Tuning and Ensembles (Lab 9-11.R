              # Hyper-Parameter Tuning and Ensembles (Lab 9-11)

library(caret)
set.seed(123)  # for reproducibility
# Assuming your data frame is named 'hoteldata'
set.seed(123)  # for reproducibility
trainIndex <- createDataPartition(Hoteldata$Price, p = 0.8, 
                                  list = FALSE, 
                                  times = 1)
train_data <- Hoteldata[trainIndex, ]
test_data  <- Hoteldata[-trainIndex, ]
library(randomForest)
# Random Forest 
model <- train(Price ~ ., data = train_data, method = "rf")

# Hyperparameter Tuning
grid <- expand.grid(mtry = seq(2, 10, by = 1))
set.seed(123)
tune_result <- train(Price ~ ., data = train_data, method = "rf", tuneGrid = grid)
best_model <- tune_result$best.model
