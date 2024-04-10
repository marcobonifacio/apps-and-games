module Chapter4.Lists where

data List a = Empty | Cons a (List a)
  deriving (Show)

toList :: [a] -> List a
toList = foldr Cons Empty

fromList :: List a -> [a]
fromList = listFoldr (:) []

listFoldr :: (a -> b -> b) -> b -> List a -> b
listFoldr _ b Empty = b
listFoldr f b (Cons x xs) = f x $ listFoldr f b xs

listFoldl :: (b -> a -> b) -> b -> List a -> b
listFoldl _ b Empty = b
listFoldl f b (Cons x xs) = f (listFoldl f b xs) x

listHead :: List a -> Maybe a
listHead Empty = Nothing
listHead (Cons x xs) = Just x

listTail :: List a -> List a
listTail Empty  = Empty
listTail (Cons x xs) = xs

listReverse :: List a -> List a
listReverse = toList . reverse . fromList

listMap :: (a -> b) -> List a -> List b
listMap _ Empty = Empty
listMap f (Cons x xs) = Cons (f x) $ listMap f xs