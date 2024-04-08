module Chapter1.Main where

makeGreeting :: String -> String -> String
makeGreeting salutation person =
  salutation <> " " <> person

main :: IO ()
main = print "no salutation to show yet"