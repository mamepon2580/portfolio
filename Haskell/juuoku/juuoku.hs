{-十億連勝-}

{-IO-}
main = do
  x <- getLine
  y <- getContents
  putStrLn (show (combination (readX x) 0 (makeBoolList' (readY y))))


{-IO関数-}
readY :: String -> [Int]
readY x = map (\t -> read t :: Int) (lines x)

readX :: String -> Int
readX x = functionY (map (\t -> read t :: Int) (words x))

functionX :: [Int] -> Int
functionX (x:y:[]) = x

functionY :: [Int] -> Int
functionY (x:y:[]) = y

{-関数-}
makeVector :: Int -> [Bool]
makeVector 0 = []
makeVector x = [False] ++ makeVector (x - 1)

makeVectorList :: [Int] -> [[Bool]]
makeVectorList x = map makeVector x

makeBool :: [[Bool]] -> [[Bool]]
makeBool []                        = []
makeBool (y:ys) | (head y) == True  = ([True] ++ y):([False] ++ y): makeBool ys
                | (head y) == False = y: makeBool ys

makeBoolCycle :: Int -> [[Bool]]
makeBoolCycle 1 = [[True],[False]]
makeBoolCycle n = makeBool (makeBoolCycle (n - 1))

mapPlus :: [[Bool]] -> [[Bool]] -> [[Bool]]
mapPlus x y = conect (map (\s -> (map (\t -> (t ++ s)) x)) y)

makeBoolList' :: [Int] -> [[Bool]]
makeBoolList' (x:[]) = reverse (makeBoolCycle x)
makeBoolList' (x:xs) = mapPlus (reverse (makeBoolCycle x)) (makeBoolList' xs)

{-任意の用途-}
{-conect-}
conect []      = []
conect (x:xs) = x ++ conect xs

trueCount :: Int -> Int -> [Bool] -> Int
trueCount n i []     | n <= i                    = i
                     | i < n                     = n
trueCount n i (x:xs) | ((length (x:xs) + n) < i) = i
                     | x == True                 = trueCount (n + 1) i xs
                     | x == False && (n <= i)    = trueCount 0 i xs
                     | x == False && (i < n)     = trueCount 0 n xs

combination :: Int -> Int -> [[Bool]] -> Int
combination n i []                          = (i `mod` 1000000000)
combination n i (x:xs) | (trueCount 0 0 x) == n = combination n ((i + 1) `mod` 1000000000) xs
                       | otherwise              = combination n (i `mod` 1000000000) xs
