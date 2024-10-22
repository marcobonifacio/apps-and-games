library(tidyverse)
library(tidyfinance)
library(scales)

start_date <- ymd("1960-01-01")
end_date <- ymd("2023-12-31")

library(frenchdata)

factors_ff3_monthly_raw <- download_french_data("Fama/French 3 Factors")

factors_ff3_monthly <- factors_ff3_monthly_raw$subsets$data[[1]] |>
  mutate(
    date = floor_date(ymd(str_c(date, "01")), "month"),
    across(c(RF, `Mkt-RF`, SMB, HML), ~as.numeric(.) / 100),
    .keep = "none"
  ) |>
  rename_with(str_to_lower) |>
  rename(mkt_excess = `mkt-rf`) |> 
  filter(date >= start_date & date <= end_date)

factors_ff5_monthly_raw <- download_french_data("Fama/French 5 Factors (2x3)")

factors_ff5_monthly <- factors_ff5_monthly_raw$subsets$data[[1]] |>
  mutate(
    date = floor_date(ymd(str_c(date, "01")), "month"),
    across(c(RF, `Mkt-RF`, SMB, HML, RMW, CMA), ~as.numeric(.) / 100),
    .keep = "none"
  ) |>
  rename_with(str_to_lower) |>
  rename(mkt_excess = `mkt-rf`) |> 
  filter(date >= start_date & date <= end_date)

factors_ff3_daily_raw <- download_french_data("Fama/French 3 Factors [Daily]")

factors_ff3_daily <- factors_ff3_daily_raw$subsets$data[[1]] |>
  mutate(
    date = ymd(date),
    across(c(RF, `Mkt-RF`, SMB, HML), ~as.numeric(.) / 100),
    .keep = "none"
  ) |>
  rename_with(str_to_lower) |>
  rename(mkt_excess = `mkt-rf`) |>
  filter(date >= start_date & date <= end_date)

industries_ff_monthly_raw <- download_french_data("10 Industry Portfolios")

industries_ff_monthly <- industries_ff_monthly_raw$subsets$data[[1]] |>
  mutate(date = floor_date(ymd(str_c(date, "01")), "month")) |>
  mutate(across(where(is.numeric), ~ . / 100)) |>
  select(date, everything()) |>
  filter(date >= start_date & date <= end_date) |> 
  rename_with(str_to_lower)

factors_q_monthly_link <-
  "https://global-q.org/uploads/1/2/2/6/122679606/q5_factors_monthly_2023.csv"

factors_q_monthly <- read_csv(factors_q_monthly_link) |>
  mutate(date = ymd(str_c(year, month, "01", sep = "-"))) |>
  rename_with(~str_remove(., "R_")) |>
  rename_with(str_to_lower) |>
  mutate(across(-date, ~. / 100)) |>
  select(date, risk_free = f, mkt_excess = mkt, everything()) |>
  filter(date >= start_date & date <= end_date)

sheet_id <- "1bM7vCWd3WOt95Sf9qjLPZjoiafgF_8EG"
sheet_name <- "Monthly"
macro_predictors_url <- paste0(
  "https://docs.google.com/spreadsheets/d/", sheet_id,
  "/gviz/tq?tqx=out:csv&sheet=", sheet_name
)
macro_predictors_raw <- read_csv(macro_predictors_url)

macro_predictors <- macro_predictors_raw |>
  mutate(date = ym(yyyymm)) |>
  mutate(across(where(is.character), as.numeric)) |>
  mutate(
    IndexDiv = Index + D12,
    logret = log(IndexDiv) - log(lag(IndexDiv)),
    Rfree = log(Rfree + 1),
    rp_div = lead(logret - Rfree, 1), # Future excess market return
    dp = log(D12) - log(Index), # Dividend Price ratio
    dy = log(D12) - log(lag(Index)), # Dividend yield
    ep = log(E12) - log(Index), # Earnings price ratio
    de = log(D12) - log(E12), # Dividend payout ratio
    tms = lty - tbl, # Term spread
    dfy = BAA - AAA # Default yield spread
  ) |>
  select(
    date, rp_div, dp, dy, ep, de, svar,
    bm = `b/m`, ntis, tbl, lty, ltr,
    tms, dfy, infl
  ) |>
  filter(date >= start_date & date <= end_date) |>
  drop_na()

series <- "CPIAUCNS"
cpi_url <- paste0(
  "https://fred.stlouisfed.org/series/",
  series, "/downloaddata/", series, ".csv"
)

library(httr2)

cpi_daily <- request(cpi_url) |>
  req_perform() |> 
  resp_body_string() |> 
  read_csv() |> 
  mutate(
    date = as.Date(DATE),
    value = as.numeric(VALUE),
    series = series,
    .keep = "none"
  )

cpi_monthly <- cpi_daily |>
  mutate(
    date = floor_date(date, "month"),
    cpi = value / value[date == max(date)],
    .keep = "none"
  )

library(RSQLite)
library(dbplyr)

tidy_finance <- dbConnect(
  SQLite(),
  "data/tidy_finance_r.sqlite",
  extended_types = TRUE
)

dbWriteTable(
  tidy_finance,
  "factors_ff3_monthly",
  value = factors_ff3_monthly,
  overwrite = TRUE
)

factors_ff3_monthly_db <- tbl(tidy_finance, "factors_ff3_monthly")

factors_ff3_monthly_db |>
  select(date, rf)

factors_ff3_monthly_db |>
  select(date, rf) |>
  collect()

dbWriteTable(
  tidy_finance,
  "factors_ff5_monthly",
  value = factors_ff5_monthly,
  overwrite = TRUE
)

dbWriteTable(
  tidy_finance,
  "factors_ff3_daily",
  value = factors_ff3_daily,
  overwrite = TRUE
)

dbWriteTable(
  tidy_finance,
  "industries_ff_monthly",
  value = industries_ff_monthly,
  overwrite = TRUE
)

dbWriteTable(
  tidy_finance,
  "factors_q_monthly",
  value = factors_q_monthly,
  overwrite = TRUE
)

dbWriteTable(
  tidy_finance,
  "macro_predictors",
  value = macro_predictors,
  overwrite = TRUE
)

dbWriteTable(
  tidy_finance,
  "cpi_monthly",
  value = cpi_monthly,
  overwrite = TRUE
)

library(tidyverse)
library(RSQLite)

tidy_finance <- dbConnect(
  SQLite(),
  "data/tidy_finance_r.sqlite",
  extended_types = TRUE
)

factors_q_monthly <- tbl(tidy_finance, "factors_q_monthly")
factors_q_monthly <- factors_q_monthly |> collect()

res <- dbSendQuery(tidy_finance, "VACUUM")
res

dbClearResult(res)

dbListTables(tidy_finance)