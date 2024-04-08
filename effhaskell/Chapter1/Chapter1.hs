module Chapter1 where

addOne :: Num a => a -> a
addOne num = num + 1

timesTwo :: Num a => a -> a
timesTwo num = num * 2

squared :: Num a => a -> a
squared num = num * num

minusFive :: Num a => a -> a
minusFive num = num - 5
