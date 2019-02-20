{-単語のカウント-}

{-main関数-}
main = do
  x <- getLine
  putStrLn ( tplToStr $ searchWord 0 (words x) [])

{-IO関数-}
tplToStr :: [(String,Int)] -> String
tplToStr ((x,y):[])    = x ++ " " ++ (show y)
tplToStr ((x,y):xsys) = x ++ " " ++ (show y) ++ "\n" ++ (tplToStr xsys)

{-その他の関数-}
searchWord :: Int -> [String] -> [String] -> [(String,Int)]
searchWord n (x:[]) []            = [(x,n + 1)]
searchWord n (x:[]) zs            = [(x,n + 1)] ++ (searchWord 0 zs [])
searchWord n (x:y:ys) zs | x == y = searchWord (n + 1) (x:ys) zs
                         | x /= y = searchWord n (x:ys) (zs ++ [y])
