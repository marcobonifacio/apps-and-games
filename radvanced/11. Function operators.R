chatty <- function(f) {
  force(f)
  
  function(x, ...) {
    res <- f(x, ...)
    cat("Processing ", x, "\n", sep = "")
    res
  }
}
f <- function(x) x ^ 2
s <- c(3, 2, 1)

purrr::map_dbl(s, chatty(f))

library(purrr)
library(memoise)

x <- list(
  c(0.512, 0.165, 0.717),
  c(0.064, 0.781, 0.427),
  c(0.890, 0.785, 0.495),
  "oops"
)
out <- rep(NA_real_, length(x))
for (i in seq_along(x)) {
  out[[i]] <- sum(x[[i]])
}

safe_sum <- safely(sum)
safe_sum
str(safe_sum(x[[1]]))
str(safe_sum(x[[4]]))

out <- map(x, safely(sum))
str(out)
out

out <- transpose(map(x, safely(sum)))
str(out)
out

ok <- map_lgl(out$error, is.null)
ok

x[!ok]
out$result[ok]

slow_function <- function(x) {
  Sys.sleep(1)
  x * 10 * runif(1)
}
system.time(print(slow_function(1)))
system.time(print(slow_function(1)))

fast_function <- memoise::memoise(slow_function)
system.time(print(fast_function(1)))
system.time(print(fast_function(1)))

fib <- function(n) {
  if (n < 2) return(1)
  fib(n - 2) + fib(n - 1)
}
system.time(fib(23))
system.time(fib(24))

fib2 <- memoise::memoise(function(n) {
  if (n < 2) return(1)
  fib2(n - 2) + fib2(n - 1)
})
system.time(fib2(23))
system.time(fib2(24))

delay_by <- function(f, amount) {
  force(f)
  force(amount)
  
  function(...) {
    Sys.sleep(amount)
    f(...)
  }
}
system.time(runif(100))
system.time(delay_by(runif, 0.1)(100))

dot_every <- function(f, n) {
  force(f)
  force(n)
  
  i <- 0
  function(...) {
    i <<- i + 1
    if (i %% n == 0) cat(".")
    f(...)
  }
}
walk(1:100, runif)
walk(1:100, dot_every(runif, 10))
