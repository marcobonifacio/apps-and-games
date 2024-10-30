f02 <- function(x, y) {
  # A comment
  x + y
}
formals(f02)
body(f02)
environment(f02)
attr(f02, "srcref")

sum
`[`
typeof(sum)
typeof(`[`)

formals(sum)
body(sum)
environment(sum)

f01 <- function(x) {
  sin(1 / x ^ 2)
}

lapply(mtcars, function(x) length(unique(x)))
Filter(function(x) !is.numeric(x), mtcars)
integrate(function(x) sin(x) ^ 2, 0, pi)

funs <- list(
  half = function(x) x / 2,
  double = function(x) x * 2
)
funs$double(10)

args <- list(1:10, na.rm = TRUE)
do.call(mean, args)

typeof(f02)

objs <- mget(ls("package:base", all = TRUE), inherits = TRUE)
funs <- Filter(is.function, objs)
funs


square <- function(x) x^2
deviation <- function(x) x - mean(x)

x <- runif(100)

sqrt(mean(square(deviation(x))))
out <- deviation(x)
out <- square(out)
out <- mean(out)
out <- sqrt(out)
out

library(magrittr)

x %>%
  deviation() %>%
  square() %>%
  mean() %>%
  sqrt()

x <- 10
g01 <- function() {
  x <- 20
  x
}

g01()
x

x <- 10
y <- 20
g02 <- function() {
  x <- 1
  y <- 2
  c(x, y)
}
g02()
c(x, y)

x <- 2
g03 <- function() {
  y <- 1
  c(x, y)
}
g03()
y

x <- 1
g04 <- function() {
  y <- 2
  i <- function() {
    z <- 3
    c(x, y, z)
  }
  i()
}
g04()

g07 <- function(x) x + 1
g08 <- function() {
  g07 <- function(x) x + 100
  g07(10)
}
g08()

g09 <- function(x) x + 100
g10 <- function() {
  g09 <- 10
  g09(g09)
}
g10()

g11 <- function() {
  if (!exists("a")) {
    a <- 1
  } else {
    a <- a + 1
  }
  a
}

g11()
g11()

g12 <- function() x + 1
x <- 15
g12()
x <- 20
g12()
codetools::findGlobals(g12)
environment(g12) <- emptyenv()
g12()


c <- 10
c(c = c)

f <- function(x) {
  f <- function(x) {
    f <- function() {
      x ^ 2
    }
    f() + 1
  }
  f(x) * 2
}
f(10)


h01 <- function(x) {
  10
}
h01(stop("This is an error!"))

y <- 10
h02 <- function(x) {
  y <- 100
  x + 1
}

h02(y)

h02(y <- 1000)
y

double <- function(x) { 
  message("Calculating...")
  x * 2
}

h03 <- function(x) {
  c(x, x)
}

h03(double(20))

h04 <- function(x = 1, y = x * 2, z = a + b) {
  a <- 10
  b <- 100
  
  c(x, y, z)
}
h04()

h05 <- function(x = ls()) {
  a <- 1
  x
}
h05()
h05(ls())

h06 <- function(x = 10) {
  list(missing(x), x)
}
str(h06())
str(h06(10))


x_ok <- function(x) {
  !is.null(x) && length(x) == 1 && x > 0
}
x_ok(NULL)
x_ok(1)
x_ok(1:3)

f2 <- function(x = z) {
  z <- 100
  x
}
f2()

y <- 10
f1 <- function(x = {y <- 1; 2}, y = 0) {
  c(x, y)
}
f1()
y

show_time <- function(x = stop("Error!")) {
  stop <- function(...) Sys.time()
  print(x)
}
show_time()


i01 <- function(y, z) {
  list(y = y, z = z)
}

i02 <- function(x, ...) {
  i01(...)
}
str(i02(x = 1, y = 2, z = 3))

i03 <- function(...) {
  list(first = ..1, third = ..3)
}
str(i03(1, 2, 3))

i04 <- function(...) {
  list(...)
}
str(i04(a = 1, b = 2))

x <- list(c(1, 3, NA), c(4, NA, 6))
str(lapply(x, mean, na.rm = TRUE))

print(factor(letters), max.levels = 4)

print(y ~ x, showEnv = TRUE)


j01 <- function(x) {
  if (x < 10) {
    0
  } else {
    10
  }
}
j01(5)

j02 <- function(x) {
  if (x < 10) {
    return(0)
  } else {
    return(10)
  }
}

j03 <- function() 1
j03()
j04 <- function() invisible(1)
j04()
print(j04())
(j04())
str(withVisible(j04()))

a <- 2
(a <- 2)

a <- b <- c <- d <- 2

j05 <- function() {
  stop("I'm an error")
  return(10)
}
j05()

j06 <- function(x) {
  cat("Hello\n")
  on.exit(cat("Goodbye!\n"), add = TRUE)
  
  if (x) {
    return(10)
  } else {
    stop("Error")
  }
}
j06(TRUE)
j06(FALSE)

x + y
`+`(x, y)

names(df) <- c("x", "y", "z")
`names<-`(df, c("x", "y", "z"))

for(i in 1:10) print(i)
`for`(i, 1:10, print(i))

`(` <- function(e1) {
  if (is.numeric(e1) && runif(1) < 0.1) {
    e1 + 1
  } else {
    e1
  }
}
replicate(50, (1 + 2))
rm("(")

add <- function(x, y) x + y
lapply(list(1:3, 4:5), add, 3)
lapply(list(1:3, 4:5), `+`, 3)

k01 <- function(abcdef, bcde1, bcde2) {
  list(a = abcdef, b1 = bcde1, b2 = bcde2)
}
str(k01(1, 2, 3))
str(k01(2, 3, abcdef = 1))
str(k01(2, 3, a = 1))
str(k01(1, 3, b = 1))

`%+%` <- function(a, b) paste0(a, b)
"new " %+% "string"

`% %` <- function(a, b) paste(a, b)
`%/\\%` <- function(a, b) paste(a, b)
"a" % % "b"
"a" %/\% "b"

`%-%` <- function(a, b) paste0("(", a, " %-% ", b, ")")
"a" %-% "b" %-% "c"

`second<-` <- function(x, value) {
  x[2] <- value
  x
}
x <- 1:10
second(x) <- 5L
x

`modify<-` <- function(x, position, value) {
  x[position] <- value
  x
}
modify(x, 1) <- 10
x
