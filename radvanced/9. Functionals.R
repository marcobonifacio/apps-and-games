randomise <- function(f) f(runif(1e3))
randomise(mean)
randomise(mean)
randomise(sum)

library(purrr)

triple <- function(x) x * 3
map(1:3, triple)

map_chr(mtcars, typeof)
map_lgl(mtcars, is.double)
n_unique <- function(x) length(unique(x))
map_int(mtcars, n_unique)
map_dbl(mtcars, mean)

pair <- function(x) c(x, x)
map(1:2, pair)
map(1:2, as.character)

map_dbl(mtcars, function(x) length(unique(x)))
map_dbl(mtcars, ~ length(unique(.x)))

x <- map(1:3, ~ runif(2))
str(x)

x <- list(
  list(-1, x = 1, y = c(2), z = "a"),
  list(-2, x = 4, y = c(5, 6), z = "b"),
  list(-3, x = 8, y = c(9, 10, 11))
)
map_dbl(x, "x")
map_dbl(x, 1)
map_dbl(x, list("y", 1))
map_chr(x, "z", .default = NA)

x <- list(1:5, c(1:10, NA))
map_dbl(x, ~ mean(.x, na.rm = TRUE))
map_dbl(x, mean, na.rm = TRUE)

plus <- function(x, y) x + y

x <- c(0, 0, 0, 0)
map_dbl(x, plus, runif(1))
map_dbl(x, ~ plus(.x, runif(1)))

trims <- c(0, 0.1, 0.2, 0.5)
x <- rcauchy(1000)
map_dbl(trims, ~ mean(x, trim = .x))
map_dbl(trims, function(trim) mean(x, trim = trim))
map_dbl(trims, mean, x = x)

map(1:3, ~ runif(2))
map(1:3, runif(2))

by_cyl <- split(mtcars, mtcars$cyl)
by_cyl %>% 
  map(~ lm(mpg ~ wt, data = .x)) %>% 
  map(coef) %>% 
  map_dbl(2)
by_cyl

df <- data.frame(
  x = 1:3,
  y = 6:4
)
map(df, ~ .x * 2)
modify(df, ~ .x * 2)

xs <- map(1:8, ~ runif(10))
xs[[1]][[1]] <- NA
ws <- map(1:8, ~ rpois(10, 5) + 1)
map_dbl(xs, mean)
map2_dbl(xs, ws, weighted.mean)
map2_dbl(xs, ws, weighted.mean, na.rm = TRUE)

welcome <- function(x) {
  cat("Welcome ", x, "!\n", sep = "")
}
names <- c("Hadley", "Jenny")
map(names, welcome)
walk(names, welcome)

temp <- tempfile()
dir.create(temp)

cyls <- split(mtcars, mtcars$cyl)
paths <- file.path(temp, paste0("cyl-", names(cyls), ".csv"))
walk2(cyls, paths, write.csv)

dir(temp)

imap_chr(iris, ~ paste0("The first value of ", .y, " is ", .x[[1]]))

x <- map(1:6, ~ sample(1000, 10))
imap_chr(x, ~ paste0("The highest value of ", .y, " is ", max(.x)))

pmap_dbl(list(xs, ws), weighted.mean)
pmap_dbl(list(xs, ws), weighted.mean, na.rm = TRUE)

trims <- c(0, 0.1, 0.2, 0.5)
x <- rcauchy(1000)

pmap_dbl(list(trim = trims), mean, x = x)

params <- tibble::tribble(
  ~ n, ~ min, ~ max,
  1L,     0,     1,
  2L,    10,   100,
  3L,   100,  1000
)
pmap(params, runif)


modify(mtcars, 3)
mtcars

l <- map(1:4, ~ sample(1:10, 15, replace = T))
str(l)

out <- l[[1]]
out <- intersect(out, l[[2]])
out <- intersect(out, l[[3]])
out <- intersect(out, l[[4]])
out

reduce(l, intersect)
reduce(l, union)

accumulate(l, intersect)

x <- c(4, 3, 10)
reduce(x, `+`)
accumulate(x, `+`)

reduce(integer(), `+`, .init = 0)

df <- data.frame(x = 1:3, y = c("a", "b", "c"))
detect(df, is.factor)
detect_index(df, is.factor)

str(keep(df, is.factor))
str(discard(df, is.factor))

df <- data.frame(
  num1 = c(0, 10, 20),
  num2 = c(5, 6, 7),
  chr1 = c("a", "b", "c"),
  stringsAsFactors = FALSE
)
str(map_if(df, is.numeric, mean))
str(modify_if(df, is.numeric, mean))
str(map(keep(df, is.numeric), mean))
