library(tidyverse)
library(tidyfinance)
library(scales)
library(RSQLite)
library(dbplyr)

start_date <- ymd("1960-01-01")
end_date <- ymd("2023-12-31")

library(RPostgres)

