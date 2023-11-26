#ANOVA on 'Rating' based on 'Type' 
anova_result <- aov(Rating ~ Type, data = Hoteldata)

# Print ANOVA summary
summary(anova_result)
#Interpretation:
#•	The p-value (Pr(>F)) for 'Type' is 0.314, which is greater than significance level of 0.05.
#•	Since the p-value is greater than 0.05, I do not reject the null hypothesis. 
#There is not enough evidence to conclude that there are significant differences in 
#'Rating' among the groups defined by the 'Type' variable.
#In summary, based on this ANOVA test, there is no significant difference in 
#'Rating' among the different 'Type' groups.