
library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)

# Sample customer dataset (replace this with your actual dataset)
set.seed(123)
CustomerData <- data.frame(
  Customer_ID = 1:100,
  Age = sample(18:70, 100, replace = TRUE),
  Income = sample(30000:90000, 100, replace = TRUE),
  Spending_Score = sample(1:100, 100)
)

# Define UI
ui <- dashboardPage(
  dashboardHeader(title = "Customer Segmentation Dashboard"),
  dashboardSidebar(
    sliderInput("age_range", "Select Age Range", min = 18, max = 70, value = c(18, 70)),
    sliderInput("income_range", "Select Income Range", min = 30000, max = 90000, value = c(30000, 90000))
  ),
  dashboardBody(
    fluidRow(
      box(
        title = "Customer Segmentation",
        plotOutput("segmentation_plot")
      )
    )
  )
)

# Define server logic
server <- function(input, output) {
  output$segmentation_plot <- renderPlot({
    filtered_data <- CustomerData %>%
      filter(Age >= input$age_range[1] & Age <= input$age_range[2] &
               Income >= input$income_range[1] & Income <= input$income_range[2])
    
    ggplot(filtered_data, aes(x = Income, y = Spending_Score, color = factor(Age))) +
      geom_point() +
      labs(title = "Customer Segmentation",
           x = "Income", y = "Spending Score",
           color = "Age Group") +
      theme_minimal()
  })
}

# Run the Shiny app
shinyApp(ui, server)

