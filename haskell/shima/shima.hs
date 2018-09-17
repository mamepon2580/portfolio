{-島探し-}

{-例示-}
{-
[(1,1,1),(1,2,1),(1,3,0),(1,4,1),(2,1,1),(2,2,1),(2,3,1),(2,4,1),(3,1,1),(3,2,1),(3,3,0),(3,4,0),(4,1,0),(4,2,0),(4,3,0),(4,4,1)]
-}

{-IO-}

main = do
  x <- getLine
  y <- getContents
  putStrLn (show (count (makeMatrix y)))

{-IO関数-}
listX :: String -> [Int]
listX x = map (\x -> read x :: Int) (words x)

listY :: String -> [[Int]]
listY x = map (map (\x -> read x :: Int)) (map words (lines x))

makeMatrix :: String -> [(Int,Int,Int)]
makeMatrix x = matrix 0 0 (listY x)

{-関数-}
vector :: Int -> Int -> [Int] -> [(Int,Int,Int)]
vector i j []     = []
vector i j (x:xs) = [(i,j,x)] ++ vector i (j + 1) xs

matrix :: Int -> Int -> [[Int]] -> [(Int,Int,Int)]
matrix _ _ []     = []
matrix i j (x:xs) = vector i j x ++ matrix (i + 1) j xs


{-リスト整理-}
remove' :: [(Int,Int,Int)] -> [(Int,Int,Int)]
remove' []                    = []
remove' ((x,y,z):ws) | z /= 1 = remove' ws
                     | z == 1 = (x,y,z): remove' ws

{-島探し-}
remove :: (Int,Int,Int) -> [(Int,Int,Int)] -> [(Int,Int,Int)]
remove (x,y,1) []                    = []
remove (x,y,1) (z:zs) | (x,y,1) == z = remove (x,y,1) zs
                      | (x,y,1) /= z = z: remove (x,y,1) zs

find :: (Int,Int,Int) -> [(Int,Int,Int)] -> Bool
find x []                 = False
find x (y:ys) | x == y    = True
              | otherwise = find x ys

{-
check :: (Int,Int,Int) -> [(Int,Int,Int)] -> (Bool,Bool,Bool,Bool)
check (x,y,1) z = ((find ((x - 1),y,1) z),(find ((x + 1),y,1) z),(find (x,(y - 1),1) z),(find (x,(y + 1),1) z))
-}

checkList :: (Int,Int,Int) -> [(Int,Int,Int)] -> [(Bool,Bool,Bool,Bool)]
checkList (x,y,1) []                          = [(False,False,False,False)]
checkList (x,y,1) (z:zs) | z == ((x - 1),y,1) = (True,False,False,False): checkList (x,y,1) zs
                         | z == ((x + 1),y,1) = (False,True,False,False): checkList (x,y,1) zs
                         | z == (x,(y - 1),1) = (False,False,True,False): checkList (x,y,1) zs
                         | z == (x,(y + 1),1) = (False,False,False,True): checkList (x,y,1) zs
                         | otherwise          = checkList (x,y,1) zs

checkSum :: [(Bool,Bool,Bool,Bool)] -> (Bool,Bool,Bool,Bool)
checkSum ((x,y,z,w):[]) = (x,y,z,w)
checkSum ((x,y,z,w):(a,b,c,d):ws) = checkSum (((x || a),(y || b),(z || c),(w || d)):ws)

check ::  (Int,Int,Int) -> [(Int,Int,Int)] -> (Bool,Bool,Bool,Bool)
check x y = checkSum (checkList x y)

catch :: Int -> (Bool,Bool,Bool,Bool) -> (Int,Int,Int) -> [(Int,Int,Int)] -> [(Int,Int,Int)]
catch n b (x,y,1) [] = []
catch 0 b (x,y,1) z  = catch 1 (check (x,y,1) z) (x,y,1) z
catch 1 b (x,y,1) z | b == (True,True,True,True)     = intersectionFunction (remove (x,y,1) z) (\t -> ((catch 1 (check ((x - 1),y,1) z) ((x - 1),y,1) t))) (\t -> ((catch 1 (check ((x + 1),y,1) z) ((x + 1),y,1) t))) (\t -> ((catch 1 (check (x,(y - 1),1) z) (x,(y - 1),1) t))) (\t -> ((catch 1 (check (x,(y + 1),1) z) (x,(y + 1),1) t)))
                    | b == (True,True,True,False)    = intersectionFunction (remove (x,y,1) z) (\t -> ((catch 1 (check ((x - 1),y,1) z) ((x - 1),y,1) t))) (\t -> ((catch 1 (check ((x + 1),y,1) z) ((x + 1),y,1) t))) (\t -> ((catch 1 (check (x,(y - 1),1) z) (x,(y - 1),1) t))) ids
                    | b == (True,True,False,True)    = intersectionFunction (remove (x,y,1) z) (\t -> ((catch 1 (check ((x - 1),y,1) z) ((x - 1),y,1) t))) (\t -> ((catch 1 (check ((x + 1),y,1) z) ((x + 1),y,1) t))) ids                                                         (\t -> ((catch 1 (check (x,(y + 1),1) z) (x,(y + 1),1) t)))
                    | b == (True,True,False,False)   = intersectionFunction (remove (x,y,1) z) (\t -> ((catch 1 (check ((x - 1),y,1) z) ((x - 1),y,1) t))) (\t -> ((catch 1 (check ((x + 1),y,1) z) ((x + 1),y,1) t))) ids                                                         ids
                    | b == (True,False,True,True)    = intersectionFunction (remove (x,y,1) z) (\t -> ((catch 1 (check ((x - 1),y,1) z) ((x - 1),y,1) t))) ids                                                         (\t -> ((catch 1 (check (x,(y - 1),1) z) (x,(y - 1),1) t))) (\t -> ((catch 1 (check (x,(y + 1),1) z) (x,(y + 1),1) t)))
                    | b == (True,False,True,False)   = intersectionFunction (remove (x,y,1) z) (\t -> ((catch 1 (check ((x - 1),y,1) z) ((x - 1),y,1) t))) ids                                                         (\t -> ((catch 1 (check (x,(y - 1),1) z) (x,(y - 1),1) t))) ids
                    | b == (True,False,False,True)   = intersectionFunction (remove (x,y,1) z) (\t -> ((catch 1 (check ((x - 1),y,1) z) ((x - 1),y,1) t))) ids                                                         ids                                                         (\t -> ((catch 1 (check (x,(y + 1),1) z) (x,(y + 1),1) t)))
                    | b == (True,False,False,False)  = intersectionFunction (remove (x,y,1) z) (\t -> ((catch 1 (check ((x - 1),y,1) z) ((x - 1),y,1) t))) ids                                                         ids                                                         ids
                    | b == (False,True,True,True)    = intersectionFunction (remove (x,y,1) z) ids                                                         (\t -> ((catch 1 (check ((x + 1),y,1) z) ((x + 1),y,1) t))) (\t -> ((catch 1 (check (x,(y - 1),1) z) (x,(y - 1),1) t))) (\t -> ((catch 1 (check (x,(y + 1),1) z) (x,(y + 1),1) t)))
                    | b == (False,True,True,False)   = intersectionFunction (remove (x,y,1) z) ids                                                         (\t -> ((catch 1 (check ((x + 1),y,1) z) ((x + 1),y,1) t))) (\t -> ((catch 1 (check (x,(y - 1),1) z) (x,(y - 1),1) t))) ids
                    | b == (False,True,False,True)   = intersectionFunction (remove (x,y,1) z) ids                                                         (\t -> ((catch 1 (check ((x + 1),y,1) z) ((x + 1),y,1) t))) ids                                                         (\t -> ((catch 1 (check (x,(y + 1),1) z) (x,(y + 1),1) t)))
                    | b == (False,True,False,False)  = intersectionFunction (remove (x,y,1) z) ids                                                         (\t -> ((catch 1 (check ((x + 1),y,1) z) ((x + 1),y,1) t))) ids                                                         ids
                    | b == (False,False,True,True)   = intersectionFunction (remove (x,y,1) z) ids                                                         ids                                                         (\t -> ((catch 1 (check (x,(y - 1),1) z) (x,(y - 1),1) t))) (\t -> ((catch 1 (check (x,(y + 1),1) z) (x,(y + 1),1) t)))
                    | b == (False,False,True,False)  = intersectionFunction (remove (x,y,1) z) ids                                                         ids                                                         (\t -> ((catch 1 (check (x,(y - 1),1) z) (x,(y - 1),1) t))) ids
                    | b == (False,False,False,True)  = intersectionFunction (remove (x,y,1) z) ids                                                         ids                                                         ids                                                         (\t -> ((catch 1 (check (x,(y + 1),1) z) (x,(y + 1),1) t)))
                    | b == (False,False,False,False) = intersectionFunction (remove (x,y,1) z) ids                                                         ids                                                         ids                                                         ids

catchCycle :: Int -> [(Int,Int,Int)] -> Int
catchCycle i []           = i
catchCycle i ((x,y,1):zs) =  catchCycle (i + 1) (catch 0 (True,True,True,True) (x,y,1) ((x,y,1):zs))

count :: [(Int,Int,Int)] -> Int
count x = catchCycle 0 (remove' x)

{-集合-}
inter :: (Int,Int,Int) -> [(Int,Int,Int)] -> [(Int,Int,Int)]
inter x []              = []
inter x (y:ys) | x == y = y: (inter x ys)
               | x /= y = inter x ys

intersect :: [(Int,Int,Int)] -> [(Int,Int,Int)] -> [(Int,Int,Int)]
intersect [] y = []
intersect (x:xs) y =inter x y ++ intersect xs y

intersection :: [(Int,Int,Int)] -> [(Int,Int,Int)] -> [(Int,Int,Int)] -> [(Int,Int,Int)] -> [(Int,Int,Int)]
intersection x y z w = (intersect x (intersect y (intersect z w)))

intersectionFunction ::[(Int,Int,Int)] -> ([(Int,Int,Int)] -> [(Int,Int,Int)]) -> ([(Int,Int,Int)] -> [(Int,Int,Int)]) -> ([(Int,Int,Int)] -> [(Int,Int,Int)]) -> ([(Int,Int,Int)] -> [(Int,Int,Int)]) -> [(Int,Int,Int)]
intersectionFunction x f g h i = intersection (f x) (g x) (h x) (i x)

ids :: [(Int,Int,Int)] -> [(Int,Int,Int)]
ids x = x
