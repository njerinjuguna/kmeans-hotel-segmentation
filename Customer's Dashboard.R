# Install and load necessary packages
install.packages(c("shiny", "shinydashboard", "ggplot2", "dplyr"))

library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)



# Define UI
ui <- dashboardPage(
  dashboardHeader(title = "Customer Analytics Dashboard"),
  dashboardSidebar(
    selectInput("hotel_type", "Select Hotel Type", choices = unique(Hoteldata$Type)),
    # Add more input controls as needed
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
  output$personalized_plot <- renderPlot({
    ggplot(subset(Hoteldata, Type == input$hotel_type), aes(x = Price, y = ReviewsCount, color = Type)) +
      geom_point()
  })
  
  output$experience_plot <- renderPlot({
    ggplot(subset(Hoteldata, Type == input$hotel_type), aes(x = Rating, y = ReviewsCount, shape = Type)) +
      geom_point()
  })
}

# Run the Shiny app
shinyApp(ui, server)
