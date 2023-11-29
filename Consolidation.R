# Load required libraries
library(plumber)

library(caret)
install.packages("httpuv")
# Read the script content
script_content <- readLines("Consolidation.R", warn = FALSE)

# Define a function to handle requests
handle_request <- function(req, res) {
  if (req$method == "GET") {
    # Evaluate the script content for each GET request
    eval(parse(text = paste(script_content, collapse = "\n")), envir = list(hoteldata = hoteldata))
    res$status <- 200
    res$headers$set("Content-Type", "application/json")
    res$body <- '{"message": "Script executed successfully"}'
  } else {
    res$status <- 405
    res$body <- '{"error": "Method not allowed"}'
  }
}

# Start the server
server <- httpuv::startServer("0.0.0.0", port = 8000, list(GET = handle_request))
httpuv::browseURL("http://127.0.0.1:8000")
