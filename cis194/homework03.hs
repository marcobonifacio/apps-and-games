skips :: [a] -> [[a]]
skips [] = []
skips [x] = [[x]]
skips (x:xs) = 