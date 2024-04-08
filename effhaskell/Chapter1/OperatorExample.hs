module Chapter1.OperatorExample where

(+++) :: Num a => a -> a -> a
infixl 6 +++
(+++) a b = a + b

divide :: Double -> Double -> Double
divide = (/)