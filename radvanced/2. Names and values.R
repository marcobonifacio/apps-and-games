library(lobstr)

x <- c(1, 2, 3)
y <- x

obj_addr(x)
obj_addr(y)

`_abc` <- 1
`_abc`

`if` <- 10
`if`

a <- 1:10
b <- a
c <- b
d <- 1:10

obj_addr(a)
obj_addr(b)
obj_addr(c)
obj_addr(d)

mean
base::mean
get("mean")
evalq(mean)
match.fun("mean")

obj_addr(mean)
obj_addr(base::mean)
obj_addr(get("mean"))
obj_addr(evalq(mean))
obj_addr(match.fun(mean))

make.names(`_abc`)

x <- c(1, 2, 3)
y <- x

y[[3]] <- 4
x

x <- c(1, 2, 3)
cat(tracemem(x), "\n")
y <- x
y[[3]] <- 4L
y[[3]] <- 5L
untracemem(x)

f <- function(a) {
  a
}

x <- c(1, 2, 3)
cat(tracemem(x), "\n")

z <- f(x)

untracemem(x)

l1 <- list(1, 2, 3)
l2 <- l1
l2[[3]] <- 4

ref(l1, l2)

d1 <- data.frame(x = c(1, 5, 6), y = c(2, 4, 3))
d2 <- d1
d2[, 2] <- d2[, 2] * 2
d3 <- d1
d3[1, ] <- d3[1, ] * 3

x <- c("a", "a", "abc", "d")

ref(x, character = TRUE)

tracemem(1:10)
untracemem(1:10)

x <- c(1L, 2L, 3L)
tracemem(x)

x[[3]] <- 4

a <- 1:10
b <- list(a, a)
c <- list(b, a, 1:10)

ref(a)
ref(b)
ref(c)

x <- list(1:10)
tracemem(x)
x[[2]] <- x

obj_size(letters)
obj_size(ggplot2::diamonds)

x <- runif(1e6)
obj_size(x)
y <- list(x, x, x)
obj_size(y)
obj_size(list(NULL, NULL, NULL))

banana <- "bananas bananas bananas"
obj_size(banana)
obj_size(rep(banana, 100))

obj_size(x, y)
obj_size(1:3)
obj_size(1:1e9)

y <- rep(list(runif(1e4)), 100)
object.size(y)
obj_size(y)

funs <- list(mean, sd, var)
obj_size(funs)

a <- runif(1e6)
obj_size(a)

b <- list(a, a)
obj_size(b)
obj_size(a, b)

b[[1]][[1]] <- 10
obj_size(b)
obj_size(a, b)

b[[2]][[1]] <- 10
obj_size(b)
obj_size(a, b)

v <- c(1, 2, 3)
v[[3]] <- 4


x <- data.frame(matrix(runif(5 * 1e4), ncol = 5))
medians <- vapply(x, median, numeric(1))

for (i in seq_along(medians)) {
  x[[i]] <- x[[i]] - medians[[i]]
}

cat(tracemem(x), "\n")
for (i in 1:5) {
  x[[i]] <- x[[i]] - medians[[i]]
}
untracemem(x)

y <- as.list(x)
cat(tracemem(y), "\n")
for (i in 1:5) {
  y[[i]] <- y[[i]] - medians[[i]]
}

e1 <- rlang::env(a = 1, b = 2, c = 3)
e2 <- e1

e1$c <- 4
e2$c

e <- rlang::env()
e$self <- e

ref(e)


x <- list()
x[[1]] <- x
x

tracemem(e)

x <- 1:3
x <- 2:4
rm(x)
gc()
