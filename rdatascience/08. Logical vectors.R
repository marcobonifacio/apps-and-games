library(tidyverse)
library(nycflights13)

x <- c(1, 2, 3, 5, 7, 11, 13)
x * 2

df <- tibble(x)
df |> 
  mutate(y = x * 2)

flights |> 
  filter(dep_time > 600 & dep_time < 2000 & abs(arr_delay) < 20)

flights |> 
  mutate(
    daytime = dep_time > 600 & dep_time < 2000,
    approx_ontime = abs(arr_delay) < 20,
    .keep = "used"
  )

flights |> 
  mutate(
    daytime = dep_time > 600 & dep_time < 2000,
    approx_ontime = abs(arr_delay) < 20,
  ) |> 
  filter(daytime & approx_ontime)

flights |> 
  filter(is.na(dep_time))

flights |> 
  filter(month == 1, day == 1) |> 
  arrange(desc(is.na(dep_time)), dep_time)

# Exercise 1
sqrt(2)^2 == 2
near(sqrt(2)^2, 2)

flights |> 
  filter(month == 11 | month == 12)

flights |> 
  filter(month %in% c(11, 12))

flights |> 
  filter(dep_time %in% c(NA, 0800))

# Exercise 1
flights |> 
  filter(is.na(arr_delay) & !is.na(dep_delay))

flights |> 
  filter(is.na(arr_delay) & !is.na(arr_time) & !is.na(sched_arr_time))

# Exercise 2
flights |> 
  filter(is.na(dep_time))

# Exercise 3
flights |>
  group_by(year, month, day) |>
  summarize(
    cancelled = mean(is.na(dep_time)),
    mean_delay = mean(dep_delay < 20, na.rm = TRUE)
  ) |>
  ggplot(aes(x = cancelled, y = mean_delay)) +
    geom_point() +
    geom_smooth() +
    coord_cartesian(xlim = c(0, 0.25))

flights |> 
  group_by(year, month, day) |> 
  summarize(
    all_delayed = all(dep_delay <= 60, na.rm = TRUE),
    any_long_delay = any(arr_delay >= 300, na.rm = TRUE),
    .groups = "drop"
  )

flights |> 
  group_by(year, month, day) |> 
  summarize(
    proportion_delayed = mean(dep_delay <= 60, na.rm = TRUE),
    count_long_delay = sum(arr_delay >= 300, na.rm = TRUE),
    .groups = "drop"
  )

flights |> 
  filter(arr_delay > 0) |> 
  group_by(year, month, day) |> 
  summarize(
    behind = mean(arr_delay),
    n = n(),
    .groups = "drop"
  )

flights |> 
  group_by(year, month, day) |> 
  summarize(
    behind = mean(arr_delay[arr_delay > 0], na.rm = TRUE),
    ahead = mean(arr_delay[arr_delay < 0], na.rm = TRUE),
    n = n(),
    .groups = "drop"
  )

# Exercise 2
lv <- c(F, T, F, T, F)
prod(lv)
max(lv)

x <- c(-3:3, NA)
if_else(x > 0, "+ve", "-ve")

if_else(x > 0, "+ve", "-ve", "???")

if_else(x < 0, -x, x)

x1 <- c(NA, 1, 2, NA)
y1 <- c(3, NA, 4, 6)
if_else(is.na(x1), y1, x1)

if_else(x == 0, "0", if_else(x < 0, "-ve", "+ve"), "???")

x <- c(-3:3, NA)
case_when(
  x == 0   ~ "0",
  x < 0    ~ "-ve", 
  x > 0    ~ "+ve",
  is.na(x) ~ "???"
)

case_when(
  x < 0 ~ "-ve",
  x > 0 ~ "+ve",
  .default = "???"
)

flights |> 
  mutate(
    status = case_when(
      is.na(arr_delay)      ~ "cancelled",
      arr_delay < -30       ~ "very early",
      arr_delay < -15       ~ "early",
      abs(arr_delay) <= 15  ~ "on time",
      arr_delay < 60        ~ "late",
      arr_delay < Inf       ~ "very late",
    ),
    .keep = "used"
  )

# Exercise 1
even_odd <- function(x) {
  if_else(x %% 2 == 0, "even", "odd")
}
even_odd(4)
even_odd(3)

# Exercise 2
x <- c("Monday", "Saturday", "Wednesday")

if_else(x %in% c("Saturday", "Sunday"), "Weekend", "Weekday")

flights |>
  mutate(
    holyday = case_when(
      day == 1 & month == 1   ~ "New Years Day",
      day == 4 & month == 7   ~ "4th of July",
      day == 28 & month == 11 ~ "Thanksgiving",
      day == 25 & month == 12 ~ "Christmas",
      .default                = "not an holyday"
    )
  ) |>
  relocate(holyday)
