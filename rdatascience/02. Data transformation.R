library(nycflights13)
library(tidyverse)

flights

glimpse(flights)

flights |>
  filter(dest == "IAH") |>
  group_by(year, month, day) |>
  summarize(
    arr_delay = mean(arr_delay, na.rm = TRUE)
  )

# 3.2

flights |>
  filter(dep_delay > 120)

flights |>
  filter(month == 1 & day == 1)

flights |>
  filter(month == 1 | month == 2)

flights |>
  filter(month %in% c(1, 2))

jan1 <- flights |>
  filter(month == 1 & day == 1)

flights |>
  arrange(year, month, day, dep_time)

flights |>
  arrange(desc(dep_delay))

flights |>
  distinct(origin, dest, .keep_all = TRUE)

flights |>
  count(origin, dest, sort = TRUE)

# Exercise 1
flights |>
  filter(arr_delay >= 200)

flights |>
  filter(dest == "IAH" | dest == "HOU")

flights |>
  filter(carrier %in% c("UA", "AA", "DL"))

flights |>
  filter(month %in% c(7, 8, 9))

flights |>
  filter(dep_delay <= 0 & arr_delay >= 200)

flights |>
  filter(air_time >= 30 & arr_delay >= 100)

# Exercise 2
flights |>
  arrange(desc(dep_delay))

flights |>
  arrange(dep_time)

# Exercise 3
flights |>
  arrange(desc(distance / air_time)) |>
  select(distance, air_time)

# Exercise 4
flights |>
  distinct(year, month, day) |>
  count()

# Exercise 5
flights |>
  filter(distance == max(distance)) |>
  select(distance)

# 3.3

flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .after = day
  )

flights |> 
  mutate(
    gain = dep_delay - arr_delay,
    hours = air_time / 60,
    gain_per_hours = gain / hours,
    .keep = "used"
  )

flights |> 
  select(year, month, day)

flights |> 
  select(year:day)

flights |> 
  select(!year:day)

flights |> 
  select(where(is.character))

flights |> 
  select(tail_num = tailnum)

flights |> 
  rename(tail_num = tailnum)

flights |> 
  relocate(time_hour, air_time)

# Exercise 3
flights |> 
  select(year, year, year)

# Exercise 4
variables <- c("year", "month", "day", "dep_delay", "arr_delay")
flights |> 
  select(any_of(variables))

# Exercise 5
flights |> select(contains("TIME", ignore.case = FALSE))

# Exercise 6
flights |>
  rename(air_time_min = air_time) |>
  relocate(air_time_min)

# 3.4

flights |> 
  filter(dest == "IAH") |> 
  mutate(speed = distance / air_time * 60) |> 
  select(year:day, dep_time, carrier, flight, speed) |> 
  arrange(desc(speed))

# 3.5

flights |> 
  group_by(month)

flights |> 
  group_by(month) |> 
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE),
    n = n()
  )

flights |> 
  group_by(dest) |> 
  slice_max(arr_delay, n = 1, with_ties = FALSE) |>
  relocate(dest)

daily <- flights |>  
  group_by(year, month, day)
daily

daily |> 
  summarize(
    n = n(),
    .groups = "keep"
  )

daily |> 
  ungroup()

daily |> 
  ungroup() |>
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE), 
    flights = n()
  )

flights |> 
  summarize(
    delay = mean(dep_delay, na.rm = TRUE), 
    n = n(),
    .by = month
  )

flights |> 
  group_by(month) |>
  summarize(
    delay = mean(dep_delay, na.rm = TRUE), 
    n = n()
  )

flights |> 
  summarize(
    delay = mean(dep_delay, na.rm = TRUE), 
    n = n(),
    .by = c(origin, dest)
  )

# Exercise 1
flights |>
  group_by(carrier, dest) |>
  summarize(
    delay = mean(dep_delay, na.rm = TRUE), 
    n = n()
  ) |>
  arrange(desc(delay))

# Exercise 2
flights |>
  group_by(dest) |>
  slice_max(dep_delay, n = 1)

# Exercise 3
flights |>
  mutate(
    hour = dep_time %/% 100
  ) |>
  group_by(hour) |>
  summarize(
    delay_dep = mean(dep_delay, na.rm = TRUE),
    delay_arr = mean(arr_delay, na.rm = TRUE),
    n = n()
  ) |>
  ggplot(
    aes(x = hour, size = n)
  ) +
  geom_point(aes(y = delay_dep), color = "green") +
  geom_point(aes(y = delay_arr), color = "red")

# Exercise 4
flights |>
  group_by(origin) |>
  slice_min(dep_delay, n = 2)

# Exercise 6
df <- tibble(
  x = 1:5,
  y = c("a", "b", "a", "a", "b"),
  z = c("K", "K", "L", "L", "K")
)
df |>
  group_by(y)
df |>
  arrange(y)
df |>
  group_by(y) |>
  summarize(mean_x = mean(x))
df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x))
df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x), .groups = "drop")
df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x))

df |>
  group_by(y, z) |>
  mutate(mean_x = mean(x))

# 3.6

batters <- Lahman::Batting |> 
  group_by(playerID) |> 
  summarize(
    performance = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    n = sum(AB, na.rm = TRUE)
  )
batters

batters |> 
  filter(n > 100) |> 
  ggplot(aes(x = n, y = performance)) +
  geom_point(alpha = 1 / 10) + 
  geom_smooth(se = FALSE)

batters |> 
  arrange(desc(performance))