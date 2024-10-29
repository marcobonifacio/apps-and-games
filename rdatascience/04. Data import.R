library(tidyverse)

# 7.2

students <- read_csv(
  "https://pos.it/r4ds-students-csv", na = c("N/A",)
)

students |> 
  rename(
    student_id = `Student ID`,
    full_name = `Full Name`
  )

students <- students |> 
  janitor::clean_names() |>
  mutate(
    meal_plan = factor(meal_plan),
    age = parse_number(if_else(age == "five", "5", age))
  )

students

read_csv(
  "a,b,c
  1,2,3
  4,5,6"
)

read_csv(
  "The first line of metadata
  The second line of metadata
  x,y,z
  1,2,3",
  skip = 2
)

read_csv(
  "# A comment I want to skip
  x,y,z
  1,2,3",
  comment = "#"
)

read_csv(
  "1,2,3
  4,5,6",
  col_names = FALSE
)

read_csv(
  "1,2,3
  4,5,6",
  col_names = c("x", "y", "z")
)

# Exercise 6
annoying <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`))
)
annoying |>
  rename(
    one = `1`,
    two = `2`
  ) |>
  mutate(
    three = two / one
  ) |>
  ggplot(
    aes(x = one, y = two)
  ) +
    geom_point() +
    geom_smooth()

# 7.3

read_csv("
  logical,numeric,date,string
  TRUE,1,2021-01-15,abc
  false,4.5,2021-02-15,def
  T,Inf,2021-02-16,ghi
")

simple_csv <- "
  x
  10
  .
  20
  30"

read_csv(simple_csv)

df <- read_csv(
  simple_csv, 
  na = "."
)
