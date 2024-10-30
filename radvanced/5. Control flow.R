grade <- function(x) {
  if (x > 90) {
    "A"
  } else if (x > 80) {
    "B"
  } else if (x > 50) {
    "C"
  } else {
    "F"
  }
}

x1 <- if (TRUE) 1 else 2
x2 <- if (FALSE) 1 else 2

c(x1, x2)

greet <- function(name, birthday = FALSE) {
  paste0(
    "Hi ", name,
    if (birthday) " and HAPPY BIRTHDAY"
  )
}
greet("Maria", FALSE)
greet("Jaime", TRUE)

x <- 1:10
ifelse(x %% 5 == 0, "XXX", as.character(x))
ifelse(x %% 2 == 0, "even", "odd")

dplyr::case_when(
  x %% 35 == 0 ~ "fizz buzz",
  x %% 5 == 0 ~ "fizz",
  x %% 7 == 0 ~ "buzz",
  is.na(x) ~ "???",
  TRUE ~ as.character(x)
)

x_option <- function(x) {
  if (x == "a") {
    "option 1"
  } else if (x == "b") {
    "option 2" 
  } else if (x == "c") {
    "option 3"
  } else {
    stop("Invalid `x` value")
  }
}

x_option <- function(x) {
  switch(x,
         a = "option 1",
         b = "option 2",
         c = "option 3",
         stop("Invalid `x` value")
  )
}

(switch("c", a = 1, b = 2))

legs <- function(x) {
  switch(x,
         cow = ,
         horse = ,
         dog = 4,
         human = ,
         chicken = 2,
         plant = 0,
         stop("Unknown input")
  )
}
legs("cow")
legs("dog")


ifelse(TRUE, 1, "no")
ifelse(FALSE, 1, "no")
ifelse(NA, 1, "no")

x <- 1:10
if (length(x)) "not empty" else "empty"
x <- numeric()
if (length(x)) "not empty" else "empty"

for (i in 1:3) {
  print(i)
}
i <- 100
for (i in 1:3) {}
i

for (i in 1:10) {
  if (i < 3) 
    next
  
  print(i)
  
  if (i >= 5)
    break
}

means <- c(1, 50, 20)
out <- vector("list", length(means))
for (i in 1:length(means)) {
  out[[i]] <- rnorm(10, means[[i]])
}

means <- c()
out <- vector("list", length(means))
for (i in 1:length(means)) {
  out[[i]] <- rnorm(10, means[[i]])
}

seq_along(means)
out <- vector("list", length(means))
for (i in seq_along(means)) {
  out[[i]] <- rnorm(10, means[[i]])
}

xs <- as.Date(c("2020-01-01", "2010-01-01"))
for (x in xs) {
  print(x)
}
for (i in seq_along(xs)) {
  print(xs[[i]])
}


x <- numeric()
out <- vector("list", length(x))
for (i in 1:length(x)) {
  out[i] <- x[i] ^ 2
}
out

vector("list", 0)

xs <- c(1, 2, 3)
for (x in xs) {
  xs <- c(xs, x * 2)
}
xs

for (i in 1:3) {
  i <- i * 2
  print(i) 
}
