{-文字列収集-}

import Control.Monad

{-main関数-}
main = do
  x <- getLine
  y <- getContents
  putStrLn (conect (map show (payPlus (readY (read' x) y) (readX (read' x) y))))

{-IO関数-}
conect :: [String] -> String
conect []     = ""
conect (x:xs) = x ++ "\n" ++ (conect xs)

read' :: String -> Int
read' x = functionX (map (\t -> read t :: Int) (words x))

functionX :: [Int] -> Int
functionX (x:y:[]) = x

readX :: Int -> String -> [[String]]
readX i x = map words (headN i (lines x))

readY :: Int -> String -> [String]
readY i x = (tailN i (lines x))

headN :: Int -> [String] -> [String]
headN 0 (x:xs) = []
headN i (x:xs) = x: headN (i - 1) xs

tailN :: Int -> [String] -> [String]
tailN 1 (x:xs) = xs
tailN i (x:xs) = tailN (i - 1) xs

{-それ以外の関数-}
compar :: String -> String -> Bool
compar (x:xs) []                 = False
compar [] []                     = True
compar [] (y:ys)                 = True
compar (x:xs) (y:ys) | x == y    = compar xs ys
                     | otherwise = False

pay :: String -> [String] -> String
pay x y | (compar x (head y)) = head (tail y)
        | otherwise           = "0"

payCycle :: [String] -> [[String]] -> [[String]]
payCycle x y = (map (\t -> (map (\s -> pay t s) y)) x)

plus :: [Int] -> Int
plus []     = 0
plus (x:xs) = x + plus xs

plusCycle ::[[String]] -> [Int]
plusCycle x = map plus (map (\s -> (map (\t -> read t :: Int)) s) x)

payPlus :: [String] -> [[String]] -> [Int]
payPlus x y = plusCycle (payCycle x y)
