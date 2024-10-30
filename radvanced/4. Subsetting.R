x <- c(2.1, 4.2, 3.3, 5.4)

x[c(3, 1)]
x[order(x)]
x[c(1, 1)]
x[c(2.1, 2.9)]

x[-c(3, 1)]

x[c(TRUE, TRUE, FALSE, FALSE)]
x[x > 3]

x[]

x[0]

(y <- setNames(x, letters[1:4]))
y[c("d", "c", "a")]
y[c("a", "a", "a")]
z <- c(abc = 1, def = 2)
z[c("a", "d")]

a <- matrix(1:9, nrow = 3)
colnames(a) <- c("A", "B", "C")
a[1:2, ]
a[c(TRUE, FALSE, TRUE), c("B", "A")]
a[0, -2]
a[1, ]
a[1, 1]

vals <- outer(1:5, 1:5, FUN = "paste", sep = ",")
vals
vals[c(4, 15)]

select <- matrix(ncol = 2, byrow = TRUE, c(
  1, 1,
  3, 1,
  2, 4
))
vals[select]

df <- data.frame(x = 1:3, y = 3:1, z = letters[1:3])
df[df$x == 2, ]
df[c(1, 3), ]
df[c("x", "z")]
df[, c("x", "z")]

str(df["x"])
str(df[, "x"])

df <- tibble::tibble(x = 1:3, y = 3:1, z = letters[1:3])
str(df["x"])
str(df[, "x"])

a <- matrix(1:4, nrow = 2)
str(a[1, ])
str(a[1, , drop = FALSE])

df <- data.frame(a = 1:2, b = 1:2)
str(df[, "a"])
str(df[, "a", drop = FALSE])

z <- factor(c("a", "b"))
z[1]
z[1, drop = TRUE]


mtcars[mtcars$cyl == 4, ]
mtcars[1:4, ]
mtcars[mtcars$cyl <= 5, ]
mtcars[mtcars$cyl == 4 | mtcars$cyl == 6, ]

x <- 1:5
x[NA_real_]

x <- outer(1:5, 1:5, FUN = "*")
x
x[upper.tri(x)]

mtcars[1:20, ]

diag

x <- list(1:3, "a", 4:6)

var <- "cyl"
mtcars$var
mtcars[[var]]

x <- list(abc = 1)
x$a
x[["a"]]

x <- list(
  a = list(1, 2, 3),
  b = list(3, 4, 5)
)
purrr::pluck(x, "a", 1)
purrr::pluck(x, "c", 1)
purrr::pluck(x, "c", 1, .default = NA)

mod <- lm(mpg ~ wt, data = mtcars)
mod$df.residual
smod <- summary(mod)
smod$r.squared
summary(mod)$r.squared

x <- 1:5
x[c(1, 2)] <- c(101, 102)
x

x <- list(a = 1, b = 2)
x[["b"]] <- NULL
str(x)

y <- list(a = 1, b = 2)
y["b"] <- list(NULL)
str(y)

mtcars[] <- lapply(mtcars, as.integer)
is.data.frame(mtcars)

mtcars <- lapply(mtcars, as.integer)
is.data.frame(mtcars)

x <- c("m", "f", "u", "f", "f", "m", "m")
lookup <- c(m = "Male", f = "Female", u = NA)
lookup[x]
unname(lookup[x])

grades <- c(1, 2, 2, 3, 1)

info <- data.frame(
  grade = 3:1,
  desc = c("Excellent", "Good", "Poor"),
  fail = c(F, F, T)
)
id <- match(grades, info$grade)
id
info[id, ]

df <- data.frame(x = c(1, 2, 3, 1, 2), y = 5:1, z = letters[1:5])
df[sample(nrow(df)), ]
df[sample(nrow(df), 3), ]
df[sample(nrow(df), 6, replace = TRUE), ]

x <- c("b", "c", "a")
order(x)
x[order(x)]

df2 <- df[sample(nrow(df)), 3:1]
df2
df2[order(df2$x), ]
df2[, order(names(df2))]

df <- data.frame(x = c(2, 4, 1), y = c(9, 11, 6), n = c(3, 5, 1))
rep(1:nrow(df), df$n)
df[rep(1:nrow(df), df$n), ]

df <- data.frame(x = 1:3, y = 3:1, z = letters[1:3])
df$z <- NULL

df <- data.frame(x = 1:3, y = 3:1, z = letters[1:3])
df[c("x", "y")]
df[setdiff(names(df), "z")]

rm(mtcars)
mtcars[mtcars$gear == 5, ]
mtcars[mtcars$gear == 5 & mtcars$cyl == 4, ]

x <- sample(10) < 4
which(x)

unwhich <- function(x, n) {
  out <- rep_len(FALSE, n)
  out[x] <- TRUE
  out
}
unwhich(which(x), 10)

(x1 <- 1:10 %% 2 == 0)
(x2 <- which(x1))
(y1 <- 1:10 %% 5 == 0)
(y2 <- which(y1))
x1 & y1
intersect(x2, y2)
x1 | y1
union(x2, y2)
x1 & !y1
setdiff(x2, y2)
xor(x1, y1)
setdiff(union(x2, y2), intersect(x2, y2))
