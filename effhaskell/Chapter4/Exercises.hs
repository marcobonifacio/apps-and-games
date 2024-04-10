module Chapter4.Exercises where

data BinaryTree a = Leaf | Branch (BinaryTree a) a (BinaryTree a)
  deriving (Show)

showStringTree :: BinaryTree String -> String
showStringTree Leaf = ""
showStringTree (Branch Leaf s Leaf) = "(" <> s <> ")"
showStringTree (Branch left s right) = 
  "(" <> showStringTree left <> "(" <> s <> ")" <> showStringTree right <> ")"