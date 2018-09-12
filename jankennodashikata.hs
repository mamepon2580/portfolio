{-じゃんけん-}

{-IO-}
main = do
  x <- getLine
  y <- getLine
  putStrLn(show (gcp (readX x) (readY x) y))

{-IO関数-}
readX :: String -> Int
readX x = getX (map (\x -> read x ::Int) (words x))

readY :: String -> Int
readY x = getY (map (\x -> read x ::Int) (words x))

getX :: [Int] -> Int
getX (x:y:[]) = x

getY :: [Int] -> Int
getY (x:y:[]) = y

{-その他の関数-}
ptnSearch :: Int -> Int -> Int -> [(Int,Int,Int)]
ptnSearch i x y | (y - (5 * ((y `div` 5) - i)) - (2 * ((y - (5 * ((y `div` 5) - i))) `div` 2))) == 0 && x - ((y `div` 5) - i) - ((y - (5 * ((y `div` 5) - i))) `div` 2) >= 0 && ((y - (5 * ((y `div` 5) - i))) `div` 2) >= 0 && ((y `div` 5) - i) >= 0 = [(x - ((y `div` 5) - i) - ((y - (5 * ((y `div` 5) - i))) `div` 2) , ((y - (5 * ((y `div` 5) - i))) `div` 2) , ((y `div` 5) - i))]
                | otherwise                                                                          = []

ptnSearchCycle :: Int -> Int -> Int -> [(Int,Int,Int)]
ptnSearchCycle i x y | (5 * i) > y  = []
                     | (5 * i) <= y = (ptnSearch i x y) ++ ptnSearchCycle (i + 1) x y

check :: String -> (Int,Int,Int)
check []                = (0,0,0)
check (x:xs) | x == 'G' = (1,0,0) `vectorPuls` check xs
             | x == 'C' = (0,1,0) `vectorPuls` check xs
             | x == 'P' = (0,0,1) `vectorPuls` check xs

vectorPuls :: (Int,Int,Int) -> (Int,Int,Int) -> (Int,Int,Int)
vectorPuls (x,y,z) (a,b,c) = (x + a,y + b,z + c)

vectorMinus :: (Int,Int,Int) -> (Int,Int,Int) -> (Int,Int,Int)
vectorMinus (x,y,z) (a,b,c) = (x `win` c,y `win` a,z `win` b)

win :: Int -> Int -> Int
win x y | x <= y = x
        | x >= y = y

vectorPuls2 :: (Int,Int,Int) -> Int
vectorPuls2 (x,y,z) = x + y + z

gcp :: Int -> Int -> String -> Int
gcp x y z = maximum (map vectorPuls2 (map  (\x -> vectorMinus (check z) x) (ptnSearchCycle 0 x y)))