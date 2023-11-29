
library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)

# Sample hotel dataset (replace this with your actual dataset)
set.seed(123)
Hoteldata <- data.frame(
  Name = paste0("Hotel", 1:100),
  Type = sample(c("Budget", "Mid-range", "Luxury"), 100, replace = TRUE),
  Price = sample(50:300, 100),
  ReviewsCount = sample(10:200, 100),
  Rating = runif(100, min = 3, max = 5)
)

# Define UI
ui <- dashboardPage(
  dashboardHeader(title = "Customer Analytics Dashboard"),
  dashboardSidebar(
    selectInput("hotel_type", "Select Hotel Type", choices = unique(Hoteldata$Type)),
    sliderInput("price_range", "Select Price Range", min = 0, max = 300, value = c(0, 300)),
    sliderInput("reviews_range", "Select Reviews Count Range", min = 0, max = 200, value = c(0, 200))
  ),
  dashboardBody(
    fluidRow(
      box(
        title = "Personalized Offers and Recommendations",
        plotOutput("personalized_plot")
      )
    ),
    fluidRow(
      box(
        title = "User Experience Metrics",
        plotOutput("experience_plot")
      )
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Add server logic for different plots and visualizations
  output$personalized_plot <- renderPlot({
    filtered_data <- Hoteldata %>%
      filter(Type == input$hotel_type & Price >= input$price_range[1] & Price <= input$price_range[2] &
               ReviewsCount >= input$reviews_range[1] & ReviewsCount <= input$reviews_range[2])
    
    ggplot(filtered_data, aes(x = Price, y = ReviewsCount, color = Type)) +
      geom_point() +
      labs(title = "Personalized Offers and Recommendations",
           x = "Price", y = "Reviews Count", color = "Hotel Type") +
      theme_minimal()
  })
  
  output$experience_plot <- renderPlot({
    filtered_data <- Hoteldata %>%
      filter(Type == input$hotel_type & Price >= input$price_range[1] & Price <= input$price_range[2] &
               ReviewsCount >= input$reviews_range[1] & ReviewsCount <= input$reviews_range[2])
    
    ggplot(filtered_data, aes(x = Rating, y = ReviewsCount, shape = Type)) +
      geom_point() +
      labs(title = "User Experience Metrics",
           x = "Rating", y = "Reviews Count", shape = "Hotel Type") +
      theme_minimal()
  })
}

# Run the Shiny app
shinyApp(ui, server)
