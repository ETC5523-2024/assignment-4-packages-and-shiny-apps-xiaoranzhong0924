#' Launch the U.S. Federal Holidays Explorer Shiny Application
#'
#' This function launches the Shiny application for exploring U.S. Federal Holidays.
#' It includes visualizations and information about current and proposed federal holidays.
#'
#' @export
#' @importFrom shiny shinyApp
#' @return No return value, called for side effects
#'
#' @examples
#' if (interactive()) {
#'   launch_app()
#' }
launch_app <- function() {
  # Load required libraries
  library(shiny)
  library(tidyverse)
  library(plotly)
  library(DT)
  library(kableExtra)
  library(lubridate)
  library(bslib)
  library(fontawesome)
  library(wesanderson)
  library(RColorBrewer)
  
  # Define UI and server functions (your existing code here)
  ui <- fluidPage(
    # Your existing UI code
  )
  
  server <- function(input, output) {
    # Your existing server code
  }
  
  # Run the application
  shinyApp(ui = ui, server = server)
}