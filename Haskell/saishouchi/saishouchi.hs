{-一番小さい値-}
import Control.Monad

{-main関数-}
main = do
  x <- getContents
  putStrLn (show $ hikaku $ strToIntList x)

{-IO関数-}
strToIntList :: String -> [Int]
strToIntList x = map (\a ->read a ::Int) (lines x)

{-それ以外の関数-}
hikaku :: [Int] -> Int
hikaku (x:[])           = x
hikaku (x:y:ys) | x > y = hikaku (y:ys)
                | x <= y = hikaku (x:ys)
