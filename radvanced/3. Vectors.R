lgl_var <- c(TRUE, FALSE)
int_var <- c(1L, 6L, 10L)
dbl_var <- c(1, 2.5, 4.5)
chr_var <- c("these are", "some strings")

c(c(1, 2), c(3, 4))

typeof(lgl_var)
typeof(int_var)
typeof(dbl_var)
typeof(chr_var)

str(c("a", 1))

x <- c(FALSE, FALSE, TRUE)
as.numeric(x)
sum(x)
mean(x)

as.integer(c("1", "1.5", "a"))

as.raw(2)
as.complex(2)
as.complex(2, 3)
complex(2, 3)
complex(real = 2, imaginary = 3)

c(1, FALSE)
c("a", 1)
c(TRUE, 1L)

1 == "1"
-1 < FALSE
"one" < 2


a <- 1:3
attr(a, "x") <- "abcdef"
attr(a, "x")

attr(a, "y") <- 4:6
str(attributes(a))

a <- structure(
  1:3, 
  x = "abcdef",
  y = 4:6
)
str(attributes(a))

attributes(a[1])
attributes(sum(a))

x <- c(a = 1, b = 2, c = 3)

x <- 1:3
names(x) <- c("a", "b", "c")

x <- setNames(1:3, c("a", "b", "c"))

x <- matrix(1:6, nrow = 2, ncol = 3)
x

y <- array(1:12, c(2, 3, 2))
y

z <- 1:6
dim(z) <- c(3, 2)
z

str(1:3)
str(matrix(1:3, ncol = 1))
str(matrix(1:3, nrow = 1))
str(array(1:3, 3))

setNames
unname

dim(c(1:6, 1:10))

x1 <- array(1:5, c(1, 1, 5))
x2 <- array(1:5, c(1, 5, 1))
x3 <- array(1:5, c(5, 1, 1))
dim(x1)
dim(x2)
dim(x3)

attr(structure(1:5, comment = "my attribute"), "comment")
structure(1:6, dim = 2:3)

x <- factor(c("a", "b", "b", "a"))
x
typeof(x)
attributes(x)

grade <- ordered(c("b", "b", "a", "c"), levels = c("c", "b", "a"))
grade

today <- Sys.Date()
typeof(today)
attributes(today)

date <- as.Date("1970-02-01")
unclass(date)

now_ct <- as.POSIXct("2018-08-01 22:00", tz = "UTC")
now_ct
typeof(now_ct)
attributes(now_ct)

structure(now_ct, tzone = "Australia/Lord_Howe")
structure(now_ct, tzone = "Europe/Paris")

one_week_1 <- as.difftime(1, units = "weeks")
one_week_1
typeof(one_week_1)
attributes(one_week_1)

one_week_2 <- as.difftime(7, units = "days")
one_week_2
attributes(one_week_2)

a <- rep(c(NA, 1/0:3), 10)
table(a)
typeof(a)
attributes(a)
b <- factor(rep(c("A","B","C"), 10))
table(b)
typeof(b)
attributes(b)

f1 <- factor(letters)
f1
levels(f1) <- rev(levels(f1))
f1

f2 <- rev(factor(letters))
f2
f3 <- factor(letters, levels = rev(letters))
f3

l1 <- list(
  1:3, 
  "a", 
  c(TRUE, FALSE, TRUE), 
  c(2.3, 5.9)
)
typeof(l1)
str(l1)
lobstr::obj_size(mtcars)
l2 <- list(mtcars, mtcars, mtcars, mtcars)
lobstr::obj_size(l2)
l3 <- list(list(list(1)))
str(l3)
l4 <- list(list(1, 2), c(3, 4))
l5 <- c(list(1, 2), c(3, 4))
str(l4)
str(l5)
as.list(1:3)

l <- list(1:3, "a", TRUE, 1.0)
dim(l) <- c(2, 2)
l
l[[1, 1]]

df1 <- data.frame(x = 1:3, y = letters[1:3])
typeof(df1)
attributes(df1)

library(tibble)

df2 <- tibble(x = 1:3, y = letters[1:3])
typeof(df2)
attributes(df2)

df <- data.frame(
  x = 1:3, 
  y = c("a", "b", "c")
)
str(df)

df1 <- data.frame(
  x = 1:3,
  y = c("a", "b", "c"),
  stringsAsFactors = FALSE
)
str(df1)

df2 <- tibble(
  x = 1:3, 
  y = c("a", "b", "c")
)
str(df2)

tibble(
  x = 1:3,
  y = x * 2
)

df3 <- data.frame(
  age = c(35, 27, 18),
  hair = c("blond", "brown", "black"),
  row.names = c("Bob", "Susan", "Sam")
)
df3
df3["Bob", ]

as_tibble(df3, rownames = "name")

dplyr::starwars

df1 <- data.frame(xyz = "a")
df2 <- tibble(xyz = "a")

str(df1$x)
str(df2$x)

df <- data.frame(x = 1:3)
df$y <- list(1:2, 1:3, 1:4)

data.frame(
  x = 1:3, 
  y = I(list(1:2, 1:3, 1:4))
)

tibble(
  x = 1:3, 
  y = list(1:2, 1:3, 1:4)
)

dfm <- data.frame(
  x = 1:3 * 10
)
dfm$y <- matrix(1:9, nrow = 3)
dfm$z <- data.frame(a = 3:1, b = letters[1:3], stringsAsFactors = FALSE)

str(dfm)

df <- data.frame(
  x = NULL,
  y = NULL
)
str(df)

df3 <- data.frame(
  age = c(35, 27, 18),
  hair = c("blond", "brown", "black"),
  row.names = c("Bob", "Susan", "Bob")
)
df3

df <- data.frame(
  x = 1:3, 
  y = c("a", "b", "c")
)
df
t(df)
t(t(df))

as.matrix(df)
data.matrix(df)

typeof(NULL)
length(NULL)

x <- NULL
attr(x, "y") <- 1

is.null(NULL)

c()
