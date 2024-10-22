library(tidyverse)
library(tidyfinance)
library(scales)

prices <- download_data(
  type = "stock_prices",
  symbols = "AAPL",
  start_date = "2000-01-01",
  end_date = "2023-12-31"
)
prices

prices |>
  ggplot(aes(x = date, y = adjusted_close)) +
  geom_line() +
  labs(
    x = NULL,
    y = NULL,
    title = "Apple stock prices between beginning of 2000 and end of 2023"
  )

returns <- prices |>
  arrange(date) |>
  mutate(ret = adjusted_close / lag(adjusted_close) - 1) |>
  select(symbol, date, ret)
returns

returns <- returns |>
  drop_na(ret)

quantile_05 <- quantile(returns |> pull(ret), probs = 0.05)
returns |>
  ggplot(aes(x = ret)) +
  geom_histogram(bins = 100) +
  geom_vline(aes(xintercept = quantile_05),
    linetype = "dashed"
  ) +
  labs(
    x = NULL,
    y = NULL,
    title = "Distribution of daily Apple stock returns"
  ) +
  scale_x_continuous(labels = percent)

returns |>
  summarize(across(
    ret,
    list(
      daily_mean = mean,
      daily_sd = sd,
      daily_min = min,
      daily_max = max
    )
  ))

returns |>
  group_by(year = year(date)) |>
  summarize(across(
    ret,
    list(
      daily_mean = mean,
      daily_sd = sd,
      daily_min = min,
      daily_max = max
    ),
    .names = "{.fn}"
  )) |>
  print(n = Inf)

symbols <- download_data(
  type = "constituents", index = "Dow Jones Industrial Average"
)
symbols

prices_daily <- download_data(
  type = "stock_prices",
  symbols = symbols$symbol,
  start_date = "2000-01-01",
  end_date = "2023-12-31"
)

prices_daily |>
  ggplot(aes(
    x = date,
    y = adjusted_close,
    color = symbol
  )) +
  geom_line() +
  labs(
    x = NULL,
    y = NULL,
    color = NULL,
    title = "Stock prices of DOW index constituents"
  ) +
  theme(legend.position = "none")

returns_daily <- prices_daily |>
  group_by(symbol) |>
  mutate(ret = adjusted_close / lag(adjusted_close) - 1) |>
  select(symbol, date, ret) |>
  drop_na(ret)

returns_daily |>
  group_by(symbol) |>
  summarize(across(
    ret,
    list(
      daily_mean = mean,
      daily_sd = sd,
      daily_min = min,
      daily_max = max
    ),
    .names = "{.fn}"
  )) |>
  print(n = Inf)

trading_volume <- prices_daily |>
  group_by(date) |>
  summarize(trading_volume = sum(volume * adjusted_close))

trading_volume |>
  ggplot(aes(x = date, y = trading_volume)) +
  geom_line() +
  labs(
    x = NULL, y = NULL,
    title = "Aggregate daily trading volume of DOW index constitutens"
  ) +
    scale_y_continuous(labels = unit_format(unit = "B", scale = 1e-9))

trading_volume |>
  ggplot(aes(x = lag(trading_volume), y = trading_volume)) +
  geom_point() +
  geom_abline(aes(intercept = 0, slope = 1),
    linetype = "dashed"
  ) +
  labs(
    x = "Previous day aggregate trading volume",
    y = "Aggregate trading volume",
    title = "Persistence in daily trading volume of DOW index constituents"
  ) + 
  scale_x_continuous(labels = unit_format(unit = "B", scale = 1e-9)) +
  scale_y_continuous(labels = unit_format(unit = "B", scale = 1e-9))

prices_daily <- prices_daily |>
  group_by(symbol) |>
  mutate(n = n()) |>
  ungroup() |>
  filter(n == max(n)) |>
  select(-n)

returns_monthly <- prices_daily |>
  mutate(date = floor_date(date, "month")) |>
  group_by(symbol, date) |>
  summarize(price = last(adjusted_close), .groups = "drop_last") |>
  mutate(ret = price / lag(price) - 1) |>
  drop_na(ret) |>
  select(-price)

returns_matrix <- returns_monthly |>
  pivot_wider(
    names_from = symbol,
    values_from = ret
  ) |>
  select(-date)
sigma <- cov(returns_matrix)
mu <- colMeans(returns_matrix)

N <- ncol(returns_matrix)
iota <- rep(1, N)
sigma_inv <- solve(sigma)
mvp_weights <- sigma_inv %*% iota
mvp_weights <- mvp_weights / sum(mvp_weights)
tibble(
  average_ret = as.numeric(t(mvp_weights) %*% mu),
  volatility = as.numeric(sqrt(t(mvp_weights) %*% sigma %*% mvp_weights))
)

benchmark_multiple <- 3
mu_bar <- benchmark_multiple * t(mvp_weights) %*% mu
C <- as.numeric(t(iota) %*% sigma_inv %*% iota)
D <- as.numeric(t(iota) %*% sigma_inv %*% mu)
E <- as.numeric(t(mu) %*% sigma_inv %*% mu)
lambda_tilde <- as.numeric(2 * (mu_bar - D / C) / (E - D^2 / C))
efp_weights <- mvp_weights +
  lambda_tilde / 2 * (sigma_inv %*% mu - D * mvp_weights)

length_year <- 12
a <- seq(from = -0.4, to = 1.9, by = 0.01)
results <- tibble(
  a = a,
  mu = NA,
  sd = NA
)
for (i in seq_along(a)) {
  w <- (1 - a[i]) * mvp_weights + (a[i]) * efp_weights
  results$mu[i] <- length_year * t(w) %*% mu   
  results$sd[i] <- sqrt(length_year) * sqrt(t(w) %*% sigma %*% w)
}

results |>
  ggplot(aes(x = sd, y = mu)) +
  geom_point() +
  geom_point(
    data = results |> filter(a %in% c(0, 1)),
    size = 4
  ) +
  geom_point(
    data = tibble(
      mu = length_year * mu,       
      sd = sqrt(length_year) * sqrt(diag(sigma))
    ),
    aes(y = mu, x = sd), size = 1
  ) +
  labs(
    x = "Annualized standard deviation",
    y = "Annualized expected return",
    title = "Efficient frontier for DOW index constituents"
  ) +
  scale_x_continuous(labels = percent) +
  scale_y_continuous(labels = percent)
