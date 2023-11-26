# Check for missing values in the entire dataset
missing_values <- colSums(is.na(Hoteldata))

# Display the columns with missing values (if any)
print(names(missing_values[missing_values > 0]))

# Identify numeric columns with missing values
numeric_cols_with_missing <- names(Hoteldata)[sapply(Hoteldata, is.numeric) & colSums(is.na(Hoteldata)) > 0]

# Mean imputation for each numeric column with missing values
for (col in numeric_cols_with_missing) {
  mean_val <- mean(Hoteldata[[col]], na.rm = TRUE)
  Hoteldata[[col]][is.na(Hoteldata[[col]])] <- mean_val
}
#The above code goes through each numeric column in your dataset that has missing values and replaces 
#those missing values with the mean value of the non-missing values in that column which is a common 
#strategy for imputing missing values in numeric columns, providing a simple way to fill in the gaps 
#in a given data.
