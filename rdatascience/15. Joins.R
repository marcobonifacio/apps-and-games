library(tidyverse)
library(nycflights13)

planes |> 
  count(tailnum) |> 
  filter(n > 1)

weather |> 
  count(time_hour, origin) |> 
  filter(n > 1)

flights |> 
  count(time_hour, carrier, flight) |> 
  filter(n > 1)

flights2 <- flights |> 
  mutate(id = row_number(), .before = 1)
flights2

flights2 <- flights |> 
  select(year, time_hour, origin, dest, tailnum, carrier)
flights2

flights2 |>
  left_join(airlines)

flights2 |> 
  left_join(weather |> select(origin, time_hour, temp, wind_speed))

flights2 |> 
  left_join(planes |> select(tailnum, type, engines, seats))

flights2 |> 
  filter(tailnum == "N3ALAA") |> 
  left_join(planes |> select(tailnum, type, engines, seats))

flights2 |> 
  left_join(planes, join_by(tailnum))

flights2 |> 
  left_join(airports, join_by(dest == faa))

flights2 |> 
  left_join(airports, join_by(origin == faa))

airports |> 
  semi_join(flights2, join_by(faa == origin))

airports |> 
  semi_join(flights2, join_by(faa == dest))

flights2 |> 
  anti_join(airports, join_by(dest == faa)) |> 
  distinct(dest)

airports |>
  semi_join(flights, join_by(faa == dest)) |>
  ggplot(aes(x = lon, y = lat)) +
  borders("state") +
  geom_point() +
  coord_quickmap()
