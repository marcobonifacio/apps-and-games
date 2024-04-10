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

concatMapR :: Foldable t => (a -> [b]) -> t a -> [b]
concatMapR f xs = (\c n -> foldr (\x b -> foldr c b (f x)) n xs) (:) []

concatMapL :: Foldable t => (a -> [b]) -> t a -> [b]
concatMapL f xs = reverse ((\c n -> foldl (\b x -> foldl c b (f x)) n xs) (flip (:)) [])

mapAndFolds :: Num c => (a1 -> a2) -> (a2 -> c -> c) -> [a1] -> c
mapAndFolds f g = foldr g 0 . map f

mapAndFolds' :: (Foldable t, Num b1) => (a -> b2) -> (b2 -> b1 -> b1) -> t a -> b1
mapAndFolds' f g = foldr (g . f) 0