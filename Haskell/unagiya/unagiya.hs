{-長テーブルのうなぎ屋-}
import Data.List

{-main関数-}
main = do
  x <- getLine
  y <- getContents
  putStrLn (show $ countTable $ (editTableCycle (checkList (readX x) ) (mameCouter)))

{-IO関数-}
readX :: String -> Int
readX x = getX (map (\x -> read x ::Int) (words x))

getX :: [Int] -> Int
getX (x:y:[]) = x

readY :: String -> Int
readY x = getY (map (\x -> read x ::Int) (words x))

getY :: [Int] -> Int
getY (x:y:[]) = y

getContentsList :: String -> (Int,Int)
getContentsList x = map words (lines x)

{-その他の関数-}
mameCouter :: Int -> [(Int,Bool)]
makeCouter n = [(n,False)] ++ makeCouter (n - 1)

checkList :: Int -> Int -> Int -> [Int]
chcekList n a 0 = []
chcekList n a b = [(a 'mod' n)] ++ chcekList (((a + 1) 'mod' n)) (b - 1)

insert' :: Int -> [Int] -> [Int]
insert' x []              = [x]
insert' x (y:ys) | x < y  = (x:y:ys)
                 | x >= y  = [y] ++ insert' x ys

insertSort :: [Int] -> [Int] -> [Int]
insertSort [] ys     = ys
insertSort (x:xs) ys = insertSort xs (insert' x ys)

checkTable :: [Int] -> [(Int,Bool)] -> Bool
checkTable [] ((y,z):yzs) = True
checkTable (x:xs) ((y,z):yzs) | x == y = (not z) && (checkTable xs yzs)
                              | x /= y = checkTable (x:xs) yzs

editTable :: [Int] -> [(Int,Bool)] -> [(Int,Bool)]
editTable (x:xs) ((y,z):yzs) | x == y = (y,True) ++ (editTable xs yzs)
                             | x /= y = editTable (x:xs) yzs

editTableCycle :: [Int] -> [(Int,Bool)] -> [(Int,Bool)]
editTableCycle (x:xs) ys | checkTable xs ys = editTable (x:xs) ys
                         | otherwise        = editTableCycle xs ys

countTable :: [(Int,Bool)] -> Int
countTable [] = 0
countTable ((x,y):xys) | y         = 1 + (countTable xys)
                       | otherwise = countTable xys
