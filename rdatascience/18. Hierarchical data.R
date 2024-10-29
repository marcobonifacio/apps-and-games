library(tidyverse)
library(repurrrsive)
library(jsonlite)

x1 <- list(1:4, "a", TRUE)
x1

x2 <- list(a = 1:2, b = 1:3, c = 1:4)
x2

x3 <- list(list(1, 2), list(3, 4))
str(x3)

x5 <- list(1, list(2, list(3, list(4, list(5)))))
str(x5)

View(x5)

df <- tibble(
  x = 1:2, 
  y = c("a", "b"),
  z = list(list(1, 2), list(3, 4, 5))
)
df

df1 <- tribble(
  ~x, ~y,
  1, list(a = 11, b = 12),
  2, list(a = 21, b = 22),
  3, list(a = 31, b = 32),
)

df2 <- tribble(
  ~x, ~y,
  1, list(11, 12, 13),
  2, list(21),
  3, list(31, 32),
)

df1 |> 
  unnest_wider(y)

df1 |> 
  unnest_wider(y, names_sep = "_")

df2 |> 
  unnest_longer(y)

df6 <- tribble(
  ~x, ~y,
  "a", list(1, 2),
  "b", list(3),
  "c", list()
)

df6 |> unnest_longer(y)
df6 |> unnest_longer(y, keep_empty = TRUE)

df4 <- tribble(
  ~x, ~y,
  "a", list(1),
  "b", list("a", TRUE, 5)
)
df4 |> 
  unnest_longer(y)

View(gh_repos)

repos <- tibble(json = gh_repos)
repos

repos |> 
  unnest_longer(json)

repos |> 
  unnest_longer(json) |> 
  unnest_wider(json) 

repos |> 
  unnest_longer(json) |> 
  unnest_wider(json) |> 
  select(id, full_name, owner, description)

repos |> 
  unnest_longer(json) |> 
  unnest_wider(json) |> 
  select(id, full_name, owner, description) |> 
  unnest_wider(owner, names_sep = "_")

chars <- tibble(json = got_chars)
chars

chars |> 
  unnest_wider(json)

characters <- chars |> 
  unnest_wider(json) |> 
  select(id, name, gender, culture, born, died, alive)
characters

chars |> 
  unnest_wider(json) |> 
  select(id, where(is.list))

chars |> 
  unnest_wider(json) |> 
  select(id, titles) |> 
  unnest_longer(titles)

titles <- chars |> 
  unnest_wider(json) |> 
  select(id, titles) |> 
  unnest_longer(titles) |> 
  filter(titles != "") |> 
  rename(title = titles)
titles

gmaps_cities

gmaps_cities |> 
  unnest_wider(json)

gmaps_cities |> 
  unnest_wider(json) |> 
  select(-status) |> 
  unnest_longer(results)

locations <- gmaps_cities |> 
  unnest_wider(json) |> 
  select(-status) |> 
  unnest_longer(results) |> 
  unnest_wider(results)
locations

locations |> 
  select(city, formatted_address, geometry) |> 
  unnest_wider(geometry)

locations |> 
  select(city, formatted_address, geometry) |> 
  unnest_wider(geometry) |> 
  unnest_wider(location)

locations |> 
  select(city, formatted_address, geometry) |> 
  unnest_wider(geometry) |> 
  # focus on the variables of interest
  select(!location:viewport) |>
  unnest_wider(bounds)

locations |> 
  select(city, formatted_address, geometry) |> 
  unnest_wider(geometry) |> 
  select(!location:viewport) |>
  unnest_wider(bounds) |> 
  rename(ne = northeast, sw = southwest) |> 
  unnest_wider(c(ne, sw), names_sep = "_") 

locations |> 
  select(city, formatted_address, geometry) |> 
  hoist(
    geometry,
    ne_lat = c("bounds", "northeast", "lat"),
    sw_lat = c("bounds", "southwest", "lat"),
    ne_lng = c("bounds", "northeast", "lng"),
    sw_lng = c("bounds", "southwest", "lng"),
  )

gh_users_json()
gh_users2 <- read_json(gh_users_json())
identical(gh_users, gh_users2)

json <- '[
  {"name": "John", "age": 34},
  {"name": "Susan", "age": 27}
]'
df <- tibble(json = parse_json(json))
df

df |> 
  unnest_wider(json)

json <- '{
  "status": "OK", 
  "results": [
    {"name": "John", "age": 34},
    {"name": "Susan", "age": 27}
 ]
}
'
df <- tibble(json = list(parse_json(json)))
df

df |> 
  unnest_wider(json) |> 
  unnest_longer(results) |> 
  unnest_wider(results)

df <- tibble(results = parse_json(json)$results)
df |> 
  unnest_wider(results)
