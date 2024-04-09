import Data.List
import Data.Ord

-- credit card validator
-- exercise 1
toDigits :: Integer -> [Integer]
toDigits n
    | n <= 0    = []
    | otherwise = toDigits (n `div` 10) ++ [n `mod` 10]

toDigitsRev :: Integer -> [Integer]
toDigitsRev n
    | n <= 0    = []
    | otherwise = (n `mod` 10) : toDigitsRev (n `div` 10)

-- exercise 2
doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther [] = []
doubleEveryOther [x] = [x]
doubleEveryOther (x : y : zs)
    | even (length zs) = x*2 : y : doubleEveryOther zs
    | otherwise        = x : y*2 : doubleEveryOther zs

--exercise 3
sumDigits :: [Integer] -> Integer
sumDigits [] = 0
sumDigits [x]
    | x < 10    = x
    | otherwise = sum (toDigits x)
sumDigits (x : xs) = sumDigits [x] + sumDigits xs

-- exercise 4
validate :: Integer -> Bool
validate n
    | sumDigits (doubleEveryOther (toDigits n)) `mod` 10 == 0 = True
    | otherwise                                               = False

-- towers of hanoi
-- exercise 5
type Peg = String
type Move = (Peg, Peg)
hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
hanoi 0 a b c = []
hanoi n a b c = hanoi (n-1) a c b ++ [(a, b)] ++ hanoi (n-1) c b a

-- exercise 6
hanoi4 :: Integer -> Peg -> Peg -> Peg -> Peg -> [Move]
hanoi4 0 a b c d = [ ]
hanoi4 1 a b c d = [(a, b)]
hanoi4 n a b c d = shortest [hanoi4 (n - k) a d c b ++ hanoi k a b c ++ hanoi4 (n - k) d b a c | k <- [1..(n-1)]]

shortest :: [[a]] -> [a]
shortest [] = []
shortest ls = minimumBy (comparing length) ls