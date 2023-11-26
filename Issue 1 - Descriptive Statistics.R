#Importingdata
#To import data from an Excel file (.xlsx) into R,I will use the readxl package
install.packages("readxl")
excel_file <- "C:\\Users\\muniu\\OneDrive\\Documents\\kmeans-hotel-segmentation\\HotelDataset1.xlsx"
# Load the readxl package
library(readxl)
# Read the Excel file
Hoteldata <- read_excel(excel_file)
# Print the first few rows of the data frame
head(Hoteldata)
#Number of unique values in each column
unique_counts <- sapply(Hoteldata, function(x) length(unique(x)))
print(unique_counts)


#Descriptive statistics
# Load necessary libraries
install.packages("dplyr")
install.packages("summarytools")
install.packages("Hmisc")
library(dplyr)
library(summarytools)
library(Hmisc)
# Display the structure of your dataset
str(Hoteldata)
#install and load the "psych" package to use the describe function
install.packages("psych")
library(psych)
# Assuming Hoteldata is your data frame
describe(Hoteldata)
# Display summary statistics for categorical columns
summary_categorical <- describe(Hoteldata)
print(summary_categorical)

# Measures of Central Tendency for numeric columns
mean_values_numeric <- sapply(Hoteldata[, c("Price", "ReviewsCount", "Rating")], mean, na.rm = TRUE)
median_values_numeric <- sapply(Hoteldata[, c("Price", "ReviewsCount", "Rating")], median, na.rm = TRUE)

# Function to calculate the mode for a numeric vector
calculate_mode <- function(x) {
  x <- na.omit(x)
  if (length(x) == 0) return(NA)  # Return NA if there is no mode
  unique_values <- unique(x)
  counts <- numeric(length(unique_values))
  
  for (i in seq_along(unique_values)) {
    counts[i] <- sum(x == unique_values[i])
  }
  
  mode_value <- unique_values[which.max(counts)]
  as.numeric(mode_value)
}

numeric_columns <- Hoteldata[, c("Price", "ReviewsCount", "Rating")]
mode_values_numeric <- sapply(numeric_columns, calculate_mode)

# Display measures of Central Tendency for numeric columns
central_tendency_numeric <- data.frame(Mean = mean_values_numeric, Median = median_values_numeric, Mode = mode_values_numeric)
print(central_tendency_numeric)
#Install "psych" package to use the describe fuction
install.packages("psych")
#Load "psych" package
library(psych)
# Range
data_range <- range(Hoteldata$Price)
# Quartiles
q1 <- quantile(Hoteldata$Price, 0.25)
q2 <- quantile(Hoteldata$Price, 0.50)
q3 <- quantile(Hoteldata$Price, 0.75)
#Measures of distribution
library(dplyr)
# Summary statistics for numerical variables
summary_stats <- Hoteldata %>%
  select(Price, ReviewsCount, Rating) %>%
  summary()
# Histograms for numerical variables
hist_price <- hist(Hoteldata$Price, main = "Distribution of Price", xlab = "Price")
hist_reviews <- hist(Hoteldata$ReviewsCount, main = "Distribution of ReviewsCount", xlab = "ReviewsCount")
hist_rating <- hist(Hoteldata$Rating, main = "Distribution of Rating", xlab = "Rating")

# Boxplots for numerical variables
boxplot_price <- boxplot(Hoteldata$Price, main = "Boxplot of Price")
boxplot_reviews <- boxplot(Hoteldata$ReviewsCount, main = "Boxplot of ReviewsCount")
boxplot_rating <- boxplot(Hoteldata$Rating, main = "Boxplot of Rating")

# Density plots for numerical variables
density_price <- density(Hoteldata$Price)
plot(density_price, main = "Density Plot of Price", xlab = "Price")

#Measures of relationship
# Check for missing values in 'Price' and 'Rating'
missing_values <- sum(is.na(Hoteldata$Price) | is.na(Hoteldata$Rating))

if (missing_values > 0) {
  print("Warning: There are missing values in 'Price' or 'Rating'. Handling missing values.")
}

# Remove rows with missing values
Hoteldata_no_missing <- na.omit(Hoteldata)

library(dplyr)
# Calculate Pearson correlation between 'Price' and 'Rating'
correlation_price_rating <- cor(Hoteldata_no_missing$Price, Hoteldata_no_missing$Rating)

# Print the correlation coefficient
print(correlation_price_rating)

#Correlation Coefficient: -0.1575

#This value indicates the strength and direction of the relationship between the "Price" and "Rating" variables.

#Interpretation:

#  Strength: The absolute value of the correlation coefficient is less than 0.3, indicating a weak correlation.

#Direction: The negative sign of the correlation coefficient (-0.1575) suggests a negative correlation. 
#This means that as the "Price" of hotels tends to increase, the "Rating" tends to decrease, and vice versa.

#Conclusion:

#  There is a weak negative correlation between the "Price" and "Rating" variables in the "Hoteldata" dataset.