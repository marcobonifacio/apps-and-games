module Chapter2.Exercises where

reverseR :: [a] -> [a]
reverseR = foldr (\acc x -> x ++ [acc]) []

reverseL :: [a] -> [a]
reverseL = foldl (flip (:)) []

zipWithLC :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWithLC f xs ys = [f x y | x <- xs, y <- ys]

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys