library(tidyverse)
library(babynames)

str_view(fruit, "berry")

str_view(c("a", "ab", "ae", "bd", "ea", "eab"), "a.")

str_view(fruit, "a...e")

str_view(c("a", "ab", "abb"), "ab?")

str_view(c("a", "ab", "abb"), "ab+")

str_view(c("a", "ab", "abb"), "ab*")

str_view(words, "[aeiou]x[aeiou]")

str_view(words, "[^aeiou]y[^aeiou]")

str_view(fruit, "apple|melon|nut")
str_view(fruit, "aa|ee|ii|oo|uu")

str_detect(c("a", "b", "c"), "[aeiou]")

babynames |> 
  filter(str_detect(name, "wu")) |> 
  count(name, wt = n, sort = TRUE)

babynames |> 
  group_by(year) |> 
  summarize(prop_x = mean(str_detect(name, "wu"))) |> 
  ggplot(aes(x = year, y = prop_x)) + 
  geom_line()

babynames |> 
  count(name) |> 
  mutate(
    vowels = str_count(name, "[aeiou]"),
    consonants = str_count(name, "[^aeiou]")
  )

df <- tribble(
  ~str,
  "<Sheryl>-F_34",
  "<Kisha>-F_45", 
  "<Brandon>-N_33",
  "<Sharon>-F_38", 
  "<Penny>-F_58",
  "<Justin>-M_41", 
  "<Patricia>-F_84", 
)

df |> 
  separate_wider_regex(
    str,
    patterns = c(
      "<", 
      name = "[A-Za-z]+", 
      ">-", 
      gender = ".",
      "_",
      age = "[0-9]+"
    )
  )

str_view(fruit, "^apple$")
x <- c("summary(x)", "summarize(df)", "rowsum(x)", "sum(x)")
str_view(x, "\\bsum\\b")

str_view(fruit, "(..)\\1")
str_view(words, "^(..).*\\1$")

sentences |> 
  str_replace("(\\w+) (\\w+) (\\w+)", "\\1 \\3 \\2") |> 
  str_view()

sentences |> 
  str_match("the (\\w+) (\\w+)") |> 
  head()

sentences |> 
  str_match("the (\\w+) (\\w+)") |> 
  as_tibble(.name_repair = "minimal") |> 
  set_names("match", "word1", "word2")

bananas <- c("banana", "Banana", "BANANA")
str_view(bananas, regex("banana", ignore_case = TRUE))

x <- "Line 1\nLine 2\nLine 3"
str_view(x, ".Line")
str_view(x, regex(".Line", dotall = TRUE))
str_view(x, regex("^Line", multiline = TRUE))

phone <- regex(
  r"(
    \(?     # optional opening parens
    (\d{3}) # area code
    [)\-]?  # optional closing parens or dash
    \ ?     # optional space
    (\d{3}) # another three numbers
    [\ -]?  # optional space or dash
    (\d{4}) # four more numbers
  )", 
  comments = TRUE
)

str_extract(c("514-791-8141", "(123) 456 7890", "123456"), phone)

str_view(c("", "a", "."), fixed("."))

str_view(sentences, "^The")
str_view(sentences, "^The\\b")
str_view(sentences, "^She|He|It|They\\b")
str_view(sentences, "^(She|He|It|They)\\b")

str_view(words, "^[^aeiou]+$")
str_view(words[!str_detect(words, "[aeiou]")])

str_view(words, "a.*b|b.*a")
words[str_detect(words, "a") & str_detect(words, "b")]

words[
  str_detect(words, "a") &
    str_detect(words, "e") &
    str_detect(words, "i") &
    str_detect(words, "o") &
    str_detect(words, "u")
]

cols <- colors()
cols <- cols[!str_detect(cols, "\\d")]
str_view(cols)

pattern <- str_c("\\b(", str_flatten(cols, "|"), ")\\b")
str_view(sentences, pattern)
