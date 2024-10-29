library(tidyverse)

x <- c("one", "two", "three", "four", "five")
x[c(3, 2, 5)]

x[c(-1, -3, -5)]

x <- c(10, 3, NA, 5, 8, 1, NA)
x[!is.na(x)]
x[x %% 2 == 0]

x <- c(abc = 1, def = 2, xyz = 5)
x[c("xyz", "def")]

x[]

df <- tibble(
  x = 1:3, 
  y = c("a", "e", "f"), 
  z = runif(3)
)
df[1, 2]
df[, c("x" , "y")]
df[df$x > 1, ]

tb <- tibble(
  x = 1:4,
  y = c(10, 4, 1, 21)
)
tb[[1]]
tb[["x"]]
tb$x

tb$z <- tb$x + tb$y
tb

max(diamonds$carat)
diamonds |> pull(carat) |> max()

levels(diamonds$cut)
diamonds |> pull(cut) |> levels()

l <- list(
  a = 1:3, 
  b = "a string", 
  c = pi, 
  d = list(-1, -5)
)
str(l[1:2])
str(l[1])
str(l[4])
str(l[[1]])
str(l[[4]])
str(l$a)


df <- tibble(a = 1, b = 2, c = "a", d = "b", e = 4)
num_cols <- sapply(df, is.numeric)
num_cols
df[, num_cols] <- lapply(df[, num_cols, drop = FALSE], \(x) x * 2)
df
vapply(df, is.numeric, logical(1))

diamonds |> 
  group_by(cut) |> 
  summarize(price = mean(price))

tapply(diamonds$price, diamonds$cut, mean)

hist(diamonds$carat)
plot(diamonds$carat, diamonds$price)
