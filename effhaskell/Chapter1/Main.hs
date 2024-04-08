module Chapter1.Main where

makeGreeting :: String -> String -> String
makeGreeting salutation person =
  let messageWithTrailingSpace = salutation <> " "
  in messageWithTrailingSpace <> person

extendedGreeting person =
  let joinWithNewlines a b = a <> "\n" <> b
      helloAndGoodbye hello goodbye =
        let hello' = makeGreeting hello person
            goodbye' = makeGreeting goodbye person
        in joinWithNewlines hello' goodbye'
  in helloAndGoodbye "Hello" "Goodbye"

main :: IO ()
main = print $ makeGreeting "Hello" "George"