
# Rnewswacafi

<!-- badges: start -->
[![code-size](https://img.shields.io/github/languages/code-size/DRC-Wacafi/Rnewswacafi.svg)](https://github.com/DRC-Wacafi/Rnewswacafi)
<!-- badges: end -->

NEWSwacafi est une initiative innovante destinée à fournir aux décideurs et analystes une compréhension approfondie des dynamiques au Sahel. En exploitant la puissance du web scraping et des analyses de données avancées, notre plateforme offre des insights précieux pour anticiper les tensions et conflits.

## Installation

You can install the development version of Rnewswacafi like so:

``` r
devtools::install_github("DRC-Wacafi/Rnewswacafi")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(Rnewswacafi)
## basic example code

# Keys
api_key <- "6a07a7ee-ade3-4209-aa1b-b4504ebc0e68"
api_secret <- "pbkdf2_sha256$600000$eVJKaltgn341HcwJWfVlWg$bpuIG09itt+g1R2MDOzS/QMoJstT6bWZTTVTcQlQ3cc="

# Connection
connect_info <- api_connect(api_key = api_key, api_secret = api_secret)

# Get data
start_date <- as.Date("2024-01-01")
end_date <- as.Date("2024-01-31")
news <- get_news(connect_info, start_date, end_date)
head(news,2)
```

