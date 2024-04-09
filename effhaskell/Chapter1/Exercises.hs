module Chapter1.Exercises where

factorial :: (Eq t, Num t) => t -> t
factorial n =
  if n == 1 then 1
  else n * factorial (n - 1)

fibonacci :: (Eq t, Num t) => t -> t
fibonacci n
  | n == 0 = 0
  | n == 1 = 1
  | otherwise = fibonacci (n - 1) + fibonacci (n - 2)

curry' :: ((a, b) -> c) -> a -> b -> c
curry' f a b = f (a, b)

uncurry' :: (a -> b -> c) -> (a, b) -> c
uncurry' f (a, b) = f a b