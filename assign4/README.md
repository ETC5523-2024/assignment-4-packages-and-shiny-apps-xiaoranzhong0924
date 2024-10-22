
<!-- README.md is generated from README.Rmd. Please edit that file -->

# assign4: Exploring U.S. Federal Holidays

<!-- badges: start -->
<!-- badges: end -->

The goal of **assign4** is to provide tools for analyzing U.S. Federal
Holidays. This package allows you to explore the historical evolution of
established holidays and analyze trends in proposed holidays. It
includes a Shiny app to help users interactively explore the dataset.

## Installation

You can install the development version of **assign4** from
[GitHub](https://github.com/ETC5523-2024/assignment-4-packages-and-shiny-apps-xiaoranzhong0924)
with:

``` r
# Install from GitHub using remotes package
remotes::install_github("ETC5523-2024/assignment-4-packages-and-shiny-apps-xiaoranzhong0924", subdir = "assign4")
```

## Example

Here’s a basic example that shows how to load the package and access
some of its functions:

``` r
# Load the package
library(assign4)

# Explore the dataset
head(federal_holidays)
#> # A tibble: 6 × 6
#>   date   date_definition official_name date_established details year_established
#>   <chr>  <chr>           <chr>         <date>           <chr>              <int>
#> 1 Janua… fixed date      New Year's D… 1870-06-28       "Celeb…             1870
#> 2 Janua… 3rd monday      Birthday of … 1983-11-02       "Honor…             1983
#> 3 Febru… 3rd monday      Washington's… NA               "Honor…             1879
#> 4 May 2… last monday     Memorial Day  NA               "Honor…             1968
#> 5 June … fixed date      Juneteenth N… 2021-06-17       "Comme…             2021
#> 6 July 4 fixed date      Independence… NA               "Celeb…             1870
```

### Shiny App

This package includes a Shiny app that allows users to explore U.S.
Federal Holidays interactively. To launch the app, use the following
command:

# Launch the Shiny app

``` r
launch_shiny_app()
```

The app provides an interface to filter holidays by year, explore
trends, and analyze proposed holidays.

### What is special about using `README.Rmd`?

Using `README.Rmd` allows us to include R code chunks directly in the
README, which can dynamically generate output (e.g., plots, tables). For
example, the following code generates a plot:

``` r
plot(pressure)
```

<figure>
<img src="man/figures/README-pressure-1.png"
alt="Graph showing pressure trends over time" />
<figcaption aria-hidden="true">Graph showing pressure trends over
time</figcaption>
</figure>

You’ll still need to render `README.Rmd` regularly to keep `README.md`
up-to-date. The function `devtools::build_readme()` is handy for this.

### License

This package is released under the MIT License. See the LICENSE file for
more details.

### Additional Resources

- [Explore U.S. Federal Holidays
  article](https://etc5523-2024.github.io/assignment-4-packages-and-shiny-apps-xiaoranzhong0924/articles/explore-assign4.html)
- [Documentation](https://github.com/ETC5523-2024/assignment-4-packages-and-shiny-apps-xiaoranzhong0924/tree/main/assign4)
- [GitHub
  Repo](https://github.com/ETC5523-2024/assignment-4-packages-and-shiny-apps-xiaoranzhong0924)
