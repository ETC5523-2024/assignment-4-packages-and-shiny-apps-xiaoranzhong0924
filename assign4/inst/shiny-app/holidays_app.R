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

# Step 1: Clean and process the 'federal_holidays' dataset
federal_holidays_clean <- federal_holidays %>%
  janitor::clean_names() %>%
  mutate(
    year_established = as.integer(year_established),
    date_established = lubridate::mdy(date_established),
    details = stringr::str_remove_all(details, "\\[\\d+\\]")
  )

# Step 2: Clean and process the 'proposed_federal_holidays' dataset
proposed_federal_holidays_clean <- proposed_federal_holidays %>%
  janitor::clean_names() %>%
  mutate(
    start_date = str_extract(date, "^[A-Za-z]+ \\d+"),
    end_date = str_extract(date, "\\d+$"),
    end_date = ifelse(is.na(end_date), start_date,
                      paste(str_extract(start_date, "^[A-Za-z]+"), end_date)),
    date_definition = stringr::str_remove_all(date_definition, "\\[\\d+\\]"),
    details = stringr::str_remove_all(details, "\\[\\d+\\]")
  ) %>%
  mutate(
    month = str_extract(start_date, "^[A-Za-z]+")  # Extract month from start date
  )

# Step 3: Categorize proposed holidays by theme
proposed_category <- proposed_federal_holidays_clean %>%
  mutate(category = case_when(
    str_detect(details, "Indigenous|Native|Cesar Chavez|Rosa Parks|Harriet Tubman|Malcolm X|Susan B. Anthony") ~ "Cultural Recognition",
    str_detect(details, "Environment|Earth|Climate") ~ "Environmental",
    str_detect(details, "Election|Voting|Democracy|Voter|President|Congress|Act") ~ "Political",
    str_detect(details, "Flag|September 11|Remembrance|Veterans|Memorial|Patriotic") ~ "Patriotic",
    TRUE ~ "Other"
  ))

# Define the 2024 Federal Holidays data (used in UI)
federal_holidays_2024 <- tibble(
  Holiday = c("New Year's Day", "Martin Luther King, Jr. Day", "Presidents Day",
              "Memorial Day", "Juneteenth", "Independence Day", "Labor Day",
              "Columbus Day", "Veterans Day", "Thanksgiving Day", "Christmas Day"),
  Date = c("January 1", "January 15", "February 19", "May 27", "June 19", "July 4",
           "September 2", "October 14", "November 11", "November 28", "December 25"),
  Day = c("Monday", "Monday", "Monday", "Monday", "Wednesday", "Thursday",
          "Monday", "Monday", "Monday", "Thursday", "Wednesday")
) %>%
  mutate(Month = str_extract(Date, "^[A-Za-z]+"))  # Extract the month

# UI
ui <- fluidPage(
  titlePanel(div(
    img(src = "https://upload.wikimedia.org/wikipedia/en/a/a4/Flag_of_the_United_States.svg", height = "30px"),
    " U.S. Federal Holidays Explorer"
  )),
  theme = bs_theme(
    bootswatch = "journal",
    primary = "#6B4226",
    secondary = "#BFAC76",
    success = "#659D32",
    info = "#D6CFCB",
    warning = "#A67C00",
    danger = "#BF1E2E",
    base_font = font_google("Roboto"),
    heading_font = font_google("Amatic SC")
  ),
  tags$head(
    tags$style(HTML("
      body {
        background-color: #f7f4e9;
        font-family: 'Roboto', sans-serif;
      }
      h1, h2, h3 {
        font-family: 'Amatic SC', cursive;
        font-weight: bold;
        color: #6B4226;
      }
      h3, p, .quick-fact, .panel-heading {
        color: #6B4226;
      }
      .panel {
        border-color: #6B4226;
        box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
      }
      .panel-heading {
        background-color: #6B4226;
        color: white;
      }
      .well {
        background-color: #f7f4e9;
        border: 1px solid #BFAC76;
        padding: 20px;
      }
      .quick-fact {
        text-align: center;
        padding: 10px;
        border: 1px solid #BFAC76;
        border-radius: 5px;
        background-color: #f9f5e7;
        margin-bottom: 15px;
      }
      .quick-fact img {
        width: 120px;
        margin-bottom: 10px;
      }
      .quick-fact h4 {
        font-size: 24px;
        margin-bottom: 5px;
      }
      .quick-fact p {
        font-size: 16px;
        line-height: 1.5;
      }
      .quick-fact-content {
        margin-top: 10px;
        font-size: 14px;
        text-align: justify;
      }
    "))
  ),

  # Use navset_pill_list for pill-style navigation
  navset_pill_list(
    # Home tab
    nav_panel("Home",
              fluidRow(
                column(4,
                       br(),
                       h2("About This App"),
                       p("Welcome to the U.S. Federal Holidays Explorer! This app is designed to provide insights into both current and proposed federal holidays in the United States."),
                       p("You can explore the historical background of holidays, analyze their distribution over time, and even see proposed holidays that aim to recognize key events and figures."),
                       br(),
                       img(src = "holidays.jpg", width = "100%", alt = "U.S. Federal Holidays Map")
                ),
                column(8,
                       h1("Welcome to the U.S. Federal Holidays Explorer"),
                       p("This app is your comprehensive guide to U.S. Federal Holidays. Through interactive tables, visualizations, and detailed descriptions, you can explore both the current and proposed federal holidays, their historical significance, and how they impact American life."),
                       br(),
                       wellPanel(
                         h3("Quick Insights"),
                         fluidRow(
                           column(4,
                                  tags$div(class = "quick-fact",
                                           img(src = "vintage_map.jpeg", alt = "Historical Insights"),
                                           h4("11 Official Holidays"),
                                           p("The U.S. recognizes 11 federal holidays in 2024, including New Year's Day, Martin Luther King Jr. Day, and Christmas."),
                                           tags$div(class = "quick-fact-content",
                                                    p("Federal holidays have evolved over time, reflecting the nation's changing values and priorities. Some holidays, like Memorial Day, commemorate the sacrifices of U.S. military personnel, while others, like Independence Day, celebrate the country's founding.")
                                           )
                                  )
                           ),
                           column(4,
                                  tags$div(class = "quick-fact",
                                           img(src = "image.jpeg", alt = "Proposals"),
                                           h4("Proposed Holidays"),
                                           p("Explore proposed holidays that aim to recognize important cultural, political, and environmental events."),
                                           tags$div(class = "quick-fact-content",
                                                    p("Several holidays, such as Earth Day and Indigenous Peoples' Day, have been proposed to reflect a growing awareness of environmental and social justice issues. These proposals highlight the evolving nature of federal holidays.")
                                           )
                                  )
                           ),
                           column(4,
                                  tags$div(class = "quick-fact",
                                           img(src = "whitehouse.jpeg", alt = "Historical Insights"),
                                           h4("Historical Insights"),
                                           p("Discover the rich history behind the establishment of U.S. federal holidays."),
                                           tags$div(class = "quick-fact-content",
                                                    p("Federal holidays often commemorate significant moments in American history, from the founding of the nation to key civil rights movements. Understanding their history offers insights into the values that shaped the nation.")
                                           )
                                  )
                           )
                         )
                       )
                )
              )
    ),

    # 2024 Holidays tab
    nav_panel("2024 Holidays",
              sidebarLayout(
                sidebarPanel(
                  selectInput("month_filter", "Filter by Month:", choices = c("All", unique(federal_holidays_2024$Month))),
                  br()
                ),
                mainPanel(
                  h3("2024 Federal Holidays"),
                  DTOutput("holidays_2024_table"),
                  br(),
                  p("Source: LeaveBoard")
                )
              )
    ),

    # Proposed Holidays tab
    nav_panel("Proposed Holidays",
              fluidRow(
                column(12,
                       h3("Proposed Federal Holidays"),
                       tableOutput("proposed_holidays_table")
                )
              )
    ),

    # Analytics dropdown menu
    nav_menu("Analytics",
             nav_panel("Current Holiday Distribution",
                       h3("Current Holiday Distribution by Month"),
                       plotlyOutput("current_distribution_plot")
             ),
             nav_panel("Holiday Establishment Timeline",
                       sidebarLayout(
                         sidebarPanel(
                           sliderInput("year_range", "Select Year Range:",
                                       min = min(federal_holidays_clean$year_established, na.rm = TRUE),
                                       max = max(federal_holidays_clean$year_established, na.rm = TRUE),
                                       value = c(min(federal_holidays_clean$year_established, na.rm = TRUE),
                                                 max(federal_holidays_clean$year_established, na.rm = TRUE)),
                                       step = 1, sep = ""),
                           br()
                         ),
                         mainPanel(
                           h3("Holiday Establishment Timeline"),
                           plotlyOutput("holiday_timeline_plot")
                         )
                       )
             )
    )
  ),

  footer = tagList(
    hr(),
    p("U.S. Federal Holidays Explorer - Developed with ", icon("heart"), " using Shiny and R.")
  )
)

# Server
server <- function(input, output) {

  # Render the 2024 federal holidays table with a filter for month
  output$holidays_2024_table <- renderDT({
    filtered_data <- if (input$month_filter == "All") {
      federal_holidays_2024
    } else {
      federal_holidays_2024 %>% filter(Month == input$month_filter)
    }

    datatable(filtered_data,
              options = list(
                pageLength = 11,
                dom = 't',
                class = 'table table-bordered table-hover table-striped'
              ),
              rownames = FALSE
    )
  })

  # Render the proposed holidays table using kable
  output$proposed_holidays_table <- function() {
    proposed_category %>%
      select(official_name, start_date, end_date, category, details) %>%
      kable(
        col.names = c("Proposed Name", "Start Date", "End Date", "Category", "Details"),
        caption = "Proposed Federal Holidays",
        format = "html"
      ) %>%
      kable_styling(
        bootstrap_options = c("striped", "hover", "condensed", "responsive"),
        full_width = TRUE,
        position = "left",
        font_size = 14
      ) %>%
      row_spec(0, bold = TRUE, background = "#6B4226", color = "white")
  }

  # Render the original holiday distribution plot by month
  output$current_distribution_plot <- renderPlotly({
    proposed_holidays_by_month <- proposed_federal_holidays_clean %>%
      count(month)  # Count the number of proposed holidays per month

    # Create the bar plot using ggplot2
    p <- ggplot(proposed_holidays_by_month, aes(x = month, y = n, fill = month)) +
      geom_bar(stat = "identity", fill = "steelblue") +
      labs(
        title = "Distribution of Proposed Federal Holidays by Month",
        x = "Month", y = "Count"
      ) +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))

    ggplotly(p)
  })

  # Render the holiday timeline with year range slider
  output$holiday_timeline_plot <- renderPlotly({
    filtered_data <- federal_holidays_clean %>%
      filter(year_established >= input$year_range[1] & year_established <= input$year_range[2])

    p <- ggplot(filtered_data, aes(x = year_established, y = reorder(official_name, year_established))) +
      geom_point(color = "blue", size = 3) +
      labs(
        title = "Establishment of U.S. Federal Holidays",
        x = "Year Established",
        y = "Holiday",
        caption = "Source: U.S. Federal Holidays Dataset"
      ) +
      theme_minimal()

    ggplotly(p) %>%
      layout(title = list(text = paste0(
        "Establishment of U.S. Federal Holidays",
        "<br><sup>This timeline visualizes the clustering of federal holidays around key social movements and historical events.</sup>"
      )))
  })
}

# Run the application
shinyApp(ui = ui, server = server)
