{-#OPTIONS_GHC-Wall#-}

module LogAnalysis where

import Log

-- exercise 1
parseMessage :: String -> LogMessage
parseMessage x = case words x of
    "E" : e : t : m -> LogMessage (Error (read e)) (read t) (unwords m)
    "W" : t : m     -> LogMessage Warning (read t) (unwords m)
    "I" : t : m     -> LogMessage Info (read t) (unwords m)
    m               -> Unknown (unwords m)

parse :: String -> [LogMessage]
parse x = map parseMessage (lines x)

-- exercise 2
insert :: LogMessage -> MessageTree -> MessageTree
insert (Unknown _) t = t
insert m Leaf = Node Leaf m Leaf
insert message@(LogMessage _ t1 _) (Node l root@(LogMessage _ t2 _) Leaf)
    | t1 > t2 = Node l root (Node Leaf message Leaf)
insert message@(LogMessage _ t1 _) (Node Leaf root@(LogMessage _ t2 _) r)
    | t1 <= t2 = Node (Node Leaf message Leaf) root r
insert message@(LogMessage _ t1 _) (Node l root@(LogMessage _ t2 _) r)
    | t1 > t2 = Node l root (insert message r)
    | otherwise = Node (insert message l) root r

-- exercise 3
build :: [LogMessage] -> MessageTree
build = foldr insert Leaf

-- exercise 4
inOrder :: MessageTree -> [LogMessage]
inOrder Leaf = []
inOrder (Node left message right) = inOrder left ++ [message] ++ inOrder right

--exercise 5
whatWentWrong :: [LogMessage] -> [String]
whatWentWrong log = filterEmpty (errorsWithSeverity50 (inOrder (build log)))

errorWithSeverity :: LogMessage -> Int -> String
errorWithSeverity (LogMessage (Error s) _ m) severity
  | s >= severity = m
  | otherwise = ""
errorWithSeverity _ _ = ""

errorsWithSeverity50 :: [LogMessage] -> [String]
errorsWithSeverity50 = foldr (\ x -> (++) [errorWithSeverity x 50]) []

filterEmpty :: [String] -> [String]
filterEmpty [] = []
filterEmpty ("":xs) = filterEmpty xs
filterEmpty (x:xs) = x : filterEmpty xs