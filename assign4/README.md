
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
#>             date date_definition                        official_name
#> 1      January 1      fixed date                       New Year's Day
#> 2  January 15–21      3rd monday  Birthday of Martin Luther King, Jr.
#> 3 February 15–21      3rd monday                Washington's Birthday
#> 4      May 25–31     last monday                         Memorial Day
#> 5        June 19      fixed date Juneteenth National Independence Day
#> 6         July 4      fixed date                     Independence Day
#>   date_established
#> 1       1870-06-28
#> 2       1983-11-02
#> 3             <NA>
#> 4             <NA>
#> 5       2021-06-17
#> 6             <NA>
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        details
#> 1                                                                                                                                                                                                      Celebrates the beginning of the Gregorian calendar year. Festivities include counting down to 12:00 midnight on the preceding night, New Year's Eve, often with fireworks displays and parties. The ball drop at Times Square in New York City, broadcast live on television nationwide, has become a national New Year's festivity. Serves as the traditional end of the Christmas and holiday season.
#> 2                                                                                                                                                                                                       Honors Dr. Martin Luther King Jr., a civil rights leader who was born on January 15, 1929. Some municipalities hold parades, and since the 1994 King Holiday and Service Act, it has become a day of citizen action volunteer service, sometimes referred to as the MLK Day of Service. The holiday is observed on the third Monday of January, and is combined with other holidays in several states.
#> 3 Honors George Washington, Founding Father, commander of the Continental Army, and the first U.S. president, who was born on February 22, 1732. In 1968, the Uniform Monday Holiday Act shifted the date of the commemoration from February 22 to the third Monday in February, meaning the observed holiday never falls on Washington's actual birthday. Because of this, combined with the fact that Abraham Lincoln's birthday falls on February 12, many now refer to this holiday as "Presidents' Day" and consider it a day honoring all American presidents. The official name has never been changed.
#> 4                                                                                                                                                                                                                                                                                             Honors U.S. military personnel who have fought and died while serving in the United States Armed Forces. Many municipalities hold parades with marching bands and an overall military theme, and the day marks the unofficial beginning of the summer season. The holiday is observed on the last Monday in May.
#> 5                                                                                                                                                                                                              Commemorates the emancipation of enslaved people in the United States on the anniversary of the 1865 date when emancipation was announced in Galveston, Texas. Celebratory traditions often include readings of the Emancipation Proclamation, singing traditional songs, rodeos, street fairs, family reunions, cookouts, park parties, historical reenactments, and Miss Juneteenth contests.
#> 6                                                                                                                                                                                                                                                                                                                                       Celebrates the 1776 adoption of the Declaration of Independence from British rule. Parades, picnics, and cookouts are held during the day and fireworks are set off at night. On the day before this holiday, the stock market trading session ends three hours early.
#>   year_established
#> 1             1870
#> 2             1983
#> 3             1879
#> 4             1968
#> 5             2021
#> 6             1870
```

### Shiny App

This package includes a Shiny app that allows users to explore U.S.
Federal Holidays interactively. To launch the app, use the following
command:

# Launch the Shiny app

launch_shiny_app()

The app provides an interface to filter holidays by year, explore
trends, and analyze proposed holidays.

### What is special about using `README.Rmd`?

Using `README.Rmd` allows us to include R code chunks directly in the
README, which can dynamically generate output (e.g., plots, tables). For
example, the following code generates a plot:

<img src="man/figures/README-pressure-1.png" width="100%" /> ![Graph
showing pressure trends over
time](reference/figures/README-pressure-1.png) You’ll still need to
render `README.Rmd` regularly to keep `README.md` up-to-date. The
function `devtools::build_readme()` is handy for this.

### License

This package is released under the MIT License. See the LICENSE file for
more details.

### Additional Resources

- [Documentation](https://github.com/ETC5523-2024/assignment-4-packages-and-shiny-apps-xiaoranzhong0924/tree/main/assign4)
- [GitHub
  Repo](https://github.com/ETC5523-2024/assignment-4-packages-and-shiny-apps-xiaoranzhong0924)
