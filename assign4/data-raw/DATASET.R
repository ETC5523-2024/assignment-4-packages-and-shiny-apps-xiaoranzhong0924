## code to prepare `DATASET` dataset goes here

# Load necessary libraries
library(tidyverse)
library(janitor)
library(here)
library(fs)
library(rvest)
library(polite)
library(lubridate)

# Set working directory
working_dir <- here::here("data", "2024", "2024-06-18")

# Create a web session
session <- polite::bow(
  "https://en.wikipedia.org/wiki/Federal_holidays_in_the_United_States",
  user_agent = "TidyTuesday (https://tidytues.day, jonthegeek+tidytuesday@gmail.com)",
  delay = 0
)

# Scrape tables from the webpage
holiday_tables <- session |>
  polite::scrape() |>
  rvest::html_table()

# Clean and process federal holidays data
federal_holidays <- holiday_tables[[2]] |>
  janitor::clean_names() |>
  dplyr::rename(official_name = "official_name_2") |>
  tidyr::separate_wider_regex(
    "date",
    patterns = c(
      date = "^[^(]+",
      "\\(",
      date_definition = "[^)]+",
      "\\)$"
    )
  ) |>
  dplyr::mutate(
    date_definition = tolower(date_definition),
    details = stringr::str_remove_all(details, "\\[\\d+\\]"),
    year_established = stringr::str_extract(date_established, "\\d{4}") |>
      as.integer(),
    date_established = stringr::str_extract(
      date_established,
      "^[A-Za-z]+ \\d{1,2}, \\d{4}"
    ) |>
      lubridate::mdy()
  )

#' Federal Holidays Dataset
#'
#' A dataset containing information about U.S. federal holidays.
#'
#' @format A data frame with columns:
#' \describe{
#'   \item{date}{The observed date for the holiday.}
#'   \item{date_definition}{Description of how the date is determined.}
#'   \item{official_name}{The formal name of the holiday.}
#'   \item{year_established}{The year the holiday was legally recognized.}
#'   \item{details}{Additional information about the holiday's history.}
#' }
#' @source TidyTuesday Project
"federal_holidays"

# Clean and process proposed federal holidays data
proposed_federal_holidays <- holiday_tables[[3]] |>
  janitor::clean_names() |>
  tidyr::separate_wider_regex(
    "date",
    patterns = c(
      date = "^[^(]+",
      "\\(",
      date_definition = "[^)]+",
      "\\)$"
    )
  ) |>
  dplyr::mutate(
    date_definition = tolower(date_definition) |>
      stringr::str_remove_all("\\[\\d+\\]"),
    details = stringr::str_remove_all(details, "\\[\\d+\\]")
  )

#' Proposed Federal Holidays Dataset
#'
#' A dataset containing information about proposed U.S. federal holidays.
#'
#' @format A data frame with columns:
#' \describe{
#'   \item{date}{The proposed date for the holiday.}
#'   \item{date_definition}{Description of how the date is determined.}
#'   \item{official_name}{The proposed name of the holiday.}
#'   \item{details}{Additional information about the holiday proposal.}
#' }
#' @source TidyTuesday Project
"proposed_federal_holidays"

# Save the cleaned data to the package's data directory
usethis::use_data(federal_holidays, proposed_federal_holidays, overwrite = TRUE)

