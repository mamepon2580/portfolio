{-ハノイの塔 (paizaランク A 相当)-}

{-main関数-}
main = do
  x <- getLine
  mapM_ putStrLn (hanoi x)

{-IO関連-}
hanoi :: String -> [String]
hanoi x = map removeAdd (map link (map reverse (intListToStringList (map init (moveHanoi x)))))

initialState :: String -> [[Int]]
initialState x = makeBox (getX (stringToIntList x))

removeAdd :: String -> String
removeAdd x | x == []   = x ++ "-"
            | otherwise = init x

moveHanoi :: String -> [[Int]]
moveHanoi x = moveCycle 0 (getY (stringToIntList x)) (initialState x)

stringToIntList :: String -> [Int]
stringToIntList x = map (\x -> read x ::Int) (words x)

intListToStringList :: [[Int]] -> [[String]]
intListToStringList x = map (\x -> map show x) x

link :: [String] -> String
link [] = ""
link (x:xs) = x ++ " " ++ link xs

getX :: [Int] -> Int
getX (x:_) = x

getY :: [Int] -> Int
getY (_:y:_) = y

{-その他の関数-}
makeBox :: Int -> [[Int]]
makeBox x = [[1..x]++[maxBound],[maxBound],[maxBound]]

catch :: Int -> Int -> [[Int]] -> [[Int]]
catch x y ((l:ls):(m:ms):(n:ns):[]) | x == 1 && y == 2 = ((ls):(l:m:ms):(n:ns):[])
                                    | x == 1 && y == 3 = ((ls):(m:ms):(l:n:ns):[])
                                    | x == 2 && y == 1 = ((m:l:ls):(ms):(n:ns):[])
                                    | x == 2 && y == 3 = ((l:ls):(ms):(m:n:ns):[])
                                    | x == 3 && y == 1 = ((n:l:ls):(m:ms):(ns):[])
                                    | x == 3 && y == 2 = ((l:ls):(n:m:ms):(ns):[])

moveCycle :: Int -> Int -> [[Int]] -> [[Int]]
moveCycle x 0 ((l:ls):(m:ms):(n:ns):[]) = ((l:ls):(m:ms):(n:ns):[])
moveCycle x y ((l:ls):(m:ms):(n:ns):[])
  | x /= m && l < m && m < n && m < n = moveCycle m (y - 1) (catch 2 3 ((l:ls):(m:ms):(n:ns):[]))
  | x /= m && n < m && m < l && m < l = moveCycle m (y - 1) (catch 2 1 ((l:ls):(m:ms):(n:ns):[]))
  | x /= n && m < n && n < l && n < l = moveCycle n (y - 1) (catch 3 1 ((l:ls):(m:ms):(n:ns):[]))
  | x /= n && l < n && n < m && n < m = moveCycle n (y - 1) (catch 3 2 ((l:ls):(m:ms):(n:ns):[]))
  | x /= l && n < l && l < m && l < m = moveCycle l (y - 1) (catch 1 2 ((l:ls):(m:ms):(n:ns):[]))
  | x /= l && m < l && l < n && l < n = moveCycle l (y - 1) (catch 1 3 ((l:ls):(m:ms):(n:ns):[]))
  | x /= l && l < m && m < n && l == (m - 1) = moveCycle l (y - 1) (catch 1 2 ((l:ls):(m:ms):(n:ns):[]))
  | x /= l && l < n && l < m && l == (n - 1) = moveCycle l (y - 1) (catch 1 3 ((l:ls):(m:ms):(n:ns):[]))
  | x /= m && m < n && n < l && m == (n - 1) = moveCycle m (y - 1) (catch 2 3 ((l:ls):(m:ms):(n:ns):[]))
  | x /= m && m < l && l < n && m == (l - 1) = moveCycle m (y - 1) (catch 2 1 ((l:ls):(m:ms):(n:ns):[]))
  | x /= n && n < l && l < m && n == (l - 1) = moveCycle n (y - 1) (catch 3 1 ((l:ls):(m:ms):(n:ns):[]))
  | x /= n && n < m && m < l && n == (m - 1) = moveCycle n (y - 1) (catch 3 2 ((l:ls):(m:ms):(n:ns):[]))
  | x /= l && l < m && m < n && (odd m)  = moveCycle l (y - 1) (catch 1 3 ((l:ls):(m:ms):(n:ns):[]))
  | x /= l && l < m && m < n && (even m) = moveCycle l (y - 1) (catch 1 2 ((l:ls):(m:ms):(n:ns):[]))
  | x /= l && l < n && n < m && (odd n)  = moveCycle l (y - 1) (catch 1 2 ((l:ls):(m:ms):(n:ns):[]))
  | x /= l && l < n && n < m && (even n) = moveCycle l (y - 1) (catch 1 3 ((l:ls):(m:ms):(n:ns):[]))
  | x /= m && m < n && n < l && (odd n)  = moveCycle m (y - 1) (catch 2 1 ((l:ls):(m:ms):(n:ns):[]))
  | x /= m && m < n && n < l && (even n) = moveCycle m (y - 1) (catch 2 3 ((l:ls):(m:ms):(n:ns):[]))
  | x /= m && m < l && l < n && (odd l)  = moveCycle m (y - 1) (catch 2 3 ((l:ls):(m:ms):(n:ns):[]))
  | x /= m && m < l && l < n && (even l) = moveCycle m (y - 1) (catch 2 1 ((l:ls):(m:ms):(n:ns):[]))
  | x /= n && n < l && l < m && (odd l)  = moveCycle n (y - 1) (catch 3 2 ((l:ls):(m:ms):(n:ns):[]))
  | x /= n && n < l && l < m && (even l) = moveCycle n (y - 1) (catch 3 1 ((l:ls):(m:ms):(n:ns):[]))
  | x /= n && n < m && m < l && (odd m)  = moveCycle n (y - 1) (catch 3 1 ((l:ls):(m:ms):(n:ns):[]))
  | x /= n && n < m && m < l && (even m) = moveCycle n (y - 1) (catch 3 2 ((l:ls):(m:ms):(n:ns):[]))
  | even (length (l:ls)) = moveCycle 1 (y - 1) (catch 1 3 ((l:ls):(m:ms):(n:ns):[]))
  | odd  (length (l:ls)) = moveCycle 1 (y - 1) (catch 1 2 ((l:ls):(m:ms):(n:ns):[]))
