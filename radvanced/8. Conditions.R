library(rlang)

stop("This is what an error looks like")

warning("This is what a warning looks like")

message("This is what a message looks like")

f <- function() g()
g <- function() h()
h <- function() stop("This is an error!")

f()

h <- function() stop("This is an error!", call. = FALSE)
f()

h <- function() abort("This is an error!")
f()

fw <- function() {
  cat("1\n")
  warning("W1")
  cat("2\n")
  warning("W2")
  cat("3\n")
  warning("W3")
}
fw()

formals(1)
file.remove("this-file-doesn't-exist")
lag(1:3, k = 1.5)
as.numeric(c("18", "30", "50+", "345,678"))

fm <- function() {
  cat("1\n")
  message("M1")
  cat("2\n")
  message("M2")
  cat("3\n")
  message("M3")
}

fm()

f1 <- function(x) {
  log(x)
  10
}
f1("x")

f2 <- function(x) {
  try(log(x))
  10
}
f2("a")

default <- NULL
try(default <- read.csv("possibly-bad-input.csv"), silent = TRUE)

suppressWarnings({
  warning("Uhoh!")
  warning("Another warning")
  1
})

suppressMessages({
  message("Hello there")
  2
})

suppressWarnings({
  message("You can still see me")
  3
})

cnd <- catch_cnd(stop("An error"))
str(cnd)

f3 <- function(x) {
  tryCatch(
    error = function(cnd) NA,
    log(x)
  )
}

f3("x")

tryCatch(
  error = function(cnd) 10,
  1 + 1
)

tryCatch(
  error = function(cnd) 10,
  {
    message("Hi!")
    1 + 1
  }
)

tryCatch(
  message = function(cnd) "There",
  {
    message("Here")
    stop("This code is never run!")
  }
)

tryCatch(
  error = function(cnd) {
    paste0("--", conditionMessage(cnd), "--")
  },
  stop("This is an error")
)

path <- tempfile()
tryCatch(
  {
    writeLines("Hi!", path)
    # ...
  },
  finally = {
    # always run
    unlink(path)
  }
)

tryCatch(
  message = function(cnd) cat("Caught a message!\n"), 
  {
    message("Someone there?")
    message("Why, yes!")
  }
)

withCallingHandlers(
  message = function(cnd) cat("Caught a message!\n"), 
  {
    message("Someone there?")
    message("Why, yes!")
  }
)

withCallingHandlers(
  message = function(cnd) cat("Level 2\n"),
  withCallingHandlers(
    message = function(cnd) cat("Level 1\n"),
    message("Hello")
  )
)
tryCatch(
  message = function(cnd) cat("Level 2\n"),
  withCallingHandlers(
    message = function(cnd) cat("Level 1\n"),
    message("Hello")
  )
)

withCallingHandlers(
  message = function(cnd) {
    cat("Level 2\n")
    cnd_muffle(cnd)
  },
  withCallingHandlers(
    message = function(cnd) cat("Level 1\n"),
    message("Hello")
  )
)

withCallingHandlers(
  message = function(cnd) cat("Level 2\n"),
  withCallingHandlers(
    message = function(cnd) {
      cat("Level 1\n")
      cnd_muffle(cnd)
    },
    message("Hello")
  )
)

f <- function() g()
g <- function() h()
h <- function() message("!")
withCallingHandlers(f(), message = function(cnd) {
  lobstr::cst()
  cnd_muffle(cnd)
})
tryCatch(f(), message = function(cnd) lobstr::cst())


catch_cnd(stop("An error"))
catch_cnd(abort("An error"))

show_condition <- function(code) {
  tryCatch(
    error = function(cnd) "error",
    warning = function(cnd) "warning",
    message = function(cnd) "message",
    {
      code
      NULL
    }
  )
}

show_condition(stop("!"))
show_condition(10)
show_condition(warning("?!"))
show_condition({
  10
  message("?")
  warning("?!")
})


abort(
  "error_not_found",
  message = "Path `blah.csv` not found", 
  path = "blah.csv"
)

log(letters)
log(1:10, base = letters)

my_log <- function(x, base = exp(1)) {
  if (!is.numeric(x)) {
    abort(paste0(
      "`x` must be a numeric vector; not ", typeof(x), "."
    ))
  }
  if (!is.numeric(base)) {
    abort(paste0(
      "`base` must be a numeric vector; not ", typeof(base), "."
    ))
  }
  
  base::log(x, base = base)
}
my_log(letters)
my_log(1:10, base = letters)

abort_bad_argument <- function(arg, must, not = NULL) {
  msg <- glue::glue("`{arg}` must {must}")
  if (!is.null(not)) {
    not <- typeof(not)
    msg <- glue::glue("{msg}; not {not}.")
  }
  
  abort("error_bad_argument", 
        message = msg, 
        arg = arg, 
        must = must, 
        not = not
  )
}

stop_custom <- function(.subclass, message, call = NULL, ...) {
  err <- structure(
    list(
      message = message,
      call = call,
      ...
    ),
    class = c(.subclass, "error", "condition")
  )
  stop(err)
}

err <- catch_cnd(
  stop_custom("error_new", "This is a custom error", x = 10)
)
class(err)
err$x

my_log <- function(x, base = exp(1)) {
  if (!is.numeric(x)) {
    abort_bad_argument("x", must = "be numeric", not = x)
  }
  if (!is.numeric(base)) {
    abort_bad_argument("base", must = "be numeric", not = base)
  }
  
  base::log(x, base = base)
}
my_log(letters)
my_log(1:10, base = letters)

library(testthat)

err <- catch_cnd(my_log("a"))
expect_s3_class(err, "error_bad_argument")
expect_equal(err$arg, "x")
expect_equal(err$not, "character")

tryCatch(
  error_bad_argument = function(cnd) "bad_argument",
  error = function(cnd) "other error",
  my_log("a")
)

tryCatch(
  error = function(cnd) "other error",
  error_bad_argument = function(cnd) "bad_argument",
  my_log("a")
)

fail_with <- function(expr, value = NULL) {
  tryCatch(
    error = function(cnd) value,
    expr
  )
}
fail_with(log(10), NA_real_)
fail_with(log("x"), NA_real_)

try2 <- function(expr, silent = FALSE) {
  tryCatch(
    error = function(cnd) {
      msg <- conditionMessage(cnd)
      if (!silent) {
        message("Error: ", msg)
      }
      structure(msg, class = "try-error")
    },
    expr
  )
}
try2(1)
try2(stop("Hi"))
try2(stop("Hi"), silent = TRUE)

foo <- function(expr) {
  tryCatch(
    error = function(cnd) error_val,
    {
      expr
      success_val
    }
  )
}

does_error <- function(expr) {
  tryCatch(
    error = function(cnd) TRUE,
    {
      expr
      FALSE
    }
  )
}

catch_cnd <- function(expr) {
  tryCatch(
    condition = function(cnd) cnd, 
    {
      expr
      NULL
    }
  )
}

safety <- function(expr) {
  tryCatch(
    error = function(cnd) {
      list(result = NULL, error = cnd)
    },
    list(result = expr, error = NULL)
  )
}
str(safety(1 + 10))
str(safety(stop("Error!")))

warning2error <- function(expr) {
  withCallingHandlers(
    warning = function(cnd) abort(conditionMessage(cnd)),
    expr
  )
}
warning2error({
  x <- 2 ^ 4
  warn("Hello")
})

catch_cnds <- function(expr) {
  conds <- list()
  add_cond <- function(cnd) {
    conds <<- append(conds, list(cnd))
    cnd_muffle(cnd)
  }
  
  withCallingHandlers(
    message = add_cond,
    warning = add_cond,
    expr
  )
  
  conds
}

catch_cnds({
  inform("a")
  warn("b")
  inform("c")
})

catch_cnds <- function(expr) {
  conds <- list()
  add_cond <- function(cnd) {
    conds <<- append(conds, list(cnd))
    cnd_muffle(cnd)
  }
  
  tryCatch(
    error = function(cnd) {
      conds <<- append(conds, list(cnd))
    },
    withCallingHandlers(
      message = add_cond,
      warning = add_cond,
      expr
    )
  )
  
  conds
}
catch_cnds({
  inform("a")
  warn("b")
  abort("C")
})

log <- function(message, level = c("info", "error", "fatal")) {
  level <- match.arg(level)
  signal(message, "log", level = level)
}
log("This code was run")

record_log <- function(expr, path = stdout()) {
  withCallingHandlers(
    log = function(cnd) {
      cat(
        "[", cnd$level, "] ", cnd$message, "\n", sep = "",
        file = path, append = TRUE
      )
    },
    expr
  )
}
record_log(log("Hello"))

ignore_log_levels <- function(expr, levels) {
  withCallingHandlers(
    log = function(cnd) {
      if (cnd$level %in% levels) {
        cnd_muffle(cnd)
      }
    },
    expr
  )
}

record_log(ignore_log_levels(log("Hello"), "info"))
withRestarts(signalCondition(cond), muffle = function() NULL)


bottles_of_beer <- function(i = 99) {
  message(
    "There are ", i, " bottles of beer on the wall, ", 
    i, " bottles of beer."
  )
  while(i > 0) {
    tryCatch(
      Sys.sleep(1),
      interrupt = function(err) {
        i <<- i - 1
        if (i > 0) {
          message(
            "Take one down, pass it around, ", i, 
            " bottle", if (i > 1) "s", " of beer on the wall."
          )
        }
      }
    )
  }
  message(
    "No more bottles of beer on the wall, ", 
    "no more bottles of beer."
  )
}

