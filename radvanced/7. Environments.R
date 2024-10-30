library(rlang)

e1 <- env(
  a = FALSE,
  b = "a",
  c = 2.3,
  d = 1:3,
)

e1$d <- e1

e1

env_print(e1)

identical(global_env(), current_env())

e2a <- env(d = 4, e = 5)
e2b <- env(e2a, a = 1, b = 2, c = 3)
env_parent(e2b)
env_parent(e2a)

e2c <- env(empty_env(), d = 4, e = 5)
e2d <- env(e2c, a = 1, b = 2, c = 3)
env_parents(e2b)
env_parents(e2d)
env_parents(e2b, last = empty_env())

x <- 0
f <- function() {
  x <<- 1
}
f()
x

e3 <- env(x = 1, y = 2)
e3$x
e3$z <- 3
e3[["z"]]
e3$xyz
env_get(e3, "xyz")
env_get(e3, "xyz", default = NA)
env_poke(e3, "a", 100)
e3$a
env_bind(e3, a = 10, b = 20)
env_names(e3)
env_has(e3, "a")
e3$a <- NULL
env_has(e3, "a")
env_unbind(e3, "a")
env_has(e3, "a")

env_bind_lazy(current_env(), b = {Sys.sleep(1); 1})
system.time(print(b))
system.time(print(b))

env_bind_active(current_env(), z1 = function(val) runif(1))
z1
z1

rm(a)
rebind <- function(name, value, env = caller_env()) {
  if (identical(env, empty_env())) {
    stop("Can't find `", name, "`", call. = FALSE)
  } else if (env_has(env, name)) {
    env_poke(env, name, value)
  } else {
    rebind(name, value, env_parent(env))
  }
}
rebind("a", 10)
a <- 5
rebind("a", 10)
a

where <- function(name, env = caller_env()) {
  if (identical(env, empty_env())) {
    # Base case
    stop("Can't find ", name, call. = FALSE)
  } else if (env_has(env, name)) {
    # Success case
    env
  } else {
    # Recursive case
    where(name, env_parent(env))
  }
}
where("yyy")
x <- 5
where("x")
where("mean")

e4a <- env(empty_env(), a = 1, b = 2)
e4b <- env(e4a, x = 10, a = 11)
where("a", e4b)
where("b", e4b)
where("C", e4b)

search()
search_envs()

y <- 1
f <- function(x) x + y
fn_env(f)

e <- env()
e$g <- function() 1

sd

g <- function(x) {
  if (!env_has(current_env(), "a")) {
    message("Defining a")
    a <- 1
  } else {
    a <- a + 1
  }
  a
}
g(10)
g(10)

h2 <- function(x) {
  a <- x * 2
  current_env()
}

e <- h2(x = 10)
env_print(e)
fn_env(h2)

plus <- function(x) {
  function(y) x + y
}

plus_one <- plus(1)
plus_one
plus_one(2)

f <- function(x) {
  g(x = 2)
}
g <- function(x) {
  h(x = 3)
}
h <- function(x) {
  stop()
}
f(x = 1)
traceback()

h <- function(x) {
  lobstr::cst()
}
f(x = 1)

a <- function(x) b(x)
b <- function(x) c(x)
c <- function(x) x

a(f())

my_env <- new.env(parent = emptyenv())
my_env$a <- 1

get_a <- function() {
  my_env$a
}
set_a <- function(value) {
  old <- my_env$a
  my_env$a <- value
  invisible(old)
}
