## ----setup, include = FALSE---------------------------------------------------
# Load necessary packages and data
library(assign4)   # Load the package
library(dplyr)     # For data manipulation
library(janitor)   # For cleaning column names
library(lubridate) # For working with dates
library(ggplot2)   # For plotting
library(stringr)   # For string manipulation (str_extract, etc.)

## ----federal-holidays-cleaning, eval=TRUE-------------------------------------
# Load the raw dataset (TidyTuesday data or local file in actual use)
# tuesdata <- tidytuesdayR::tt_load('2024-06-18')
# federal_holidays <- tuesdata$federal_holidays

# For the vignette, we'll assume the dataset is already included in the package
data(federal_holidays)

# Clean the dataset
federal_holidays_clean <- federal_holidays %>%
  janitor::clean_names() %>%
  mutate(
    year_established = as.integer(year_established),
    date_established = lubridate::mdy(date_established),
    details = stringr::str_remove_all(details, "\\[\\d+\\]")
  )

# View the first few rows of the cleaned dataset
head(federal_holidays_clean)

## ----proposed-holidays-cleaning, eval=TRUE------------------------------------
# Load the proposed federal holidays dataset
# proposed_federal_holidays <- tuesdata$proposed_federal_holidays

# For the vignette, we'll assume the dataset is already included in the package
data(proposed_federal_holidays)

# Clean the dataset
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

# View the first few rows of the cleaned dataset
head(proposed_federal_holidays_clean)

## ----proposed-holidays-categorization, eval=TRUE------------------------------
# Categorize proposed holidays by theme
proposed_category <- proposed_federal_holidays_clean %>%
  mutate(category = case_when(
    str_detect(details, "Indigenous|Native|Cesar Chavez|Rosa Parks|Harriet Tubman|Malcolm X|Susan B. Anthony") ~ "Cultural Recognition",
    str_detect(details, "Environment|Earth|Climate") ~ "Environmental",
    str_detect(details, "Election|Voting|Democracy|Voter|President|Congress|Act") ~ "Political",
    str_detect(details, "Flag|September 11|Remembrance|Veterans|Memorial|Patriotic") ~ "Patriotic",
    TRUE ~ "Other"
  ))

# Count holidays by category
holiday_categories <- proposed_category %>%
  count(category)

# Display the categories
holiday_categories %>%
  knitr::kable(col.names = c("Holiday Category", "Count"))

## ----table-recent-holidays, eval=TRUE-----------------------------------------
federal_holidays_clean %>%
  arrange(desc(year_established)) %>%
  select(official_name, year_established) %>%
  head(5) %>%
  knitr::kable(col.names = c("Holiday Name", "Year Established"))

## ----eval = FALSE-------------------------------------------------------------
#  # Launch the Shiny app
#  launch_shiny_app()

## ----fig-timeline-established-holidays, eval=TRUE, fig.cap="Establishment of U.S. Federal Holidays", fig.align='center'----
ggplot(federal_holidays_clean, aes(x = year_established, y = reorder(official_name, year_established))) +
  geom_point(color = "blue", size = 3) +
  labs(
    title = "Establishment of U.S. Federal Holidays",
    x = "Year Established",
    y = "Holiday",
    caption = "Source: U.S. Federal Holidays Dataset"
  ) +
  theme_minimal()

