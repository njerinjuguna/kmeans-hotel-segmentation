#Basic Visualization
#Univariate and multivariate plots are essential for exploring the distribution 
#of individual variables and relationships between multiple variables in datasets.
# Histogram for 'Price'
hist_price <- hist(Hoteldata$Price, main = "Distribution of Price", xlab = "Price")
# Boxplot for 'Rating'
boxplot_rating <- boxplot(Hoteldata$Rating, main = "Boxplot of Rating")

# Remove missing values from 'ReviewsCount'
Hoteldata_no_missing <- na.omit(Hoteldata$ReviewsCount)

# Create density plot for 'ReviewsCount'
density_reviews <- density(Hoteldata_no_missing)

# Create density plot for 'ReviewsCount'
density_reviews <- density(Hoteldata_no_missing)

plot(density_reviews, main = "Density Plot of ReviewsCount", xlab = "ReviewsCount")