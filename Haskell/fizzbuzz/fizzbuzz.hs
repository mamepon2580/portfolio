{-FizzBuzz-}
import Data.List

{-main関数-}
main = do
  x <- getLine
  putStrLn (conect $ fizzbuzz $ makeIntList $ strToInt x)

{-IO関数-}
strToInt :: String -> Int
strToInt x = read x ::Int

conect :: [String] -> String
conect [] = ""
conect (x:xs) = x ++ "\n" ++ conect xs

{-その他の関数-}
makeIntList :: Int -> [Int]
makeIntList 0 = []
makeIntList n = makeIntList (n - 1) ++ [n]

fizzbuzz :: [Int] -> [String]
fizzbuzz [] = []
fizzbuzz (x:xs) | (x `mod` 15) == 0 = ["Fizz Buzz"] ++ fizzbuzz xs
                | (x `mod` 3)  == 0 = ["Fizz"] ++ fizzbuzz xs
                | (x `mod` 5)  == 0 = ["Buzz"] ++ fizzbuzz xs
                | otherwise         = [show x] ++ fizzbuzz xs
