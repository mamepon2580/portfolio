{-mod7占い-}

{-IO-}
main = do
  x <- getLine
  y <- getContents
  putStrLn  (show (makeNumberFunction (read' y)))

{-IO処理-}
read' :: String -> [Int]
read' x = (map (\t -> read t :: Int) (lines x))

{-関数-}
makeNumber :: Int -> [Int] -> [Int] -> [Int] -> Int
makeNumber i (x:y:[])   (a:b:[])   (s:t:[])                                = i
makeNumber i (x:y:[])   (a:b:[])   (s:t:u:us)                              = makeNumber i       (t:u:us) (t:u:us)   (t:u:us)
makeNumber i (x:y:[])   (a:b:c:cs) (s:t:u:us)                              = makeNumber i       (a:c:cs) (a:c:cs)   (s:t:u:us)
makeNumber i (x:y:z:zs) (a:b:c:cs) (s:t:u:us) | ((x + y + z) `mod` 7) == 0 = makeNumber (i + 1) (x:y:zs) (a:b:c:cs) (s:t:u:us)
                                              | otherwise                  = makeNumber i       (x:y:zs) (a:b:c:cs) (s:t:u:us)

makeNumberFunction :: [Int] -> Int
makeNumberFunction x = makeNumber 0 x x x
