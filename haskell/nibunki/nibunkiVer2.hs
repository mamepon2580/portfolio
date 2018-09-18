{-二分木探索-}

import System.IO
import System.Directory
import Data.List

{-main関数-}
{-IO関数-}

main :: IO ()
main = do
  putStrLn("please order (insert,remove,find,check,quit,reset)")
  order <- getLine
  case order of
    "insert" -> insCycle >> main
    "remove" -> remoCycle >> main
    "find" -> findNumber >> main
    "check" -> checkData >> main
    "quit" -> return ()
    "reset" -> setLeaf >> main
    _ -> putStrLn ("error") >> main

readWriteFncIO :: ([Int] -> Tree -> Tree) -> IO ()
readWriteFncIO func = do
  oldDataString <- readFile "data.txt"
  let oldDataTree = (\x -> read x :: Tree) oldDataString
  nmString <- getLine
  let nmIntList = map (\x -> read x :: Int) (words nmString)
  let newData = show $ func nmIntList oldDataTree
  putStrLn (newData)
  (tm , hd) <- openTempFile "." "temp"
  hPutStr hd newData
  hClose hd
  removeFile "data.txt"
  renameFile tm "data.txt"

insCycle :: IO ()
insCycle = readWriteFncIO insertTreeCycle

remoCycle :: IO ()
remoCycle = readWriteFncIO removeTreeCycle

findNumber :: IO ()
findNumber = do
  oldDataString <- readFile "data.txt"
  let oldDataTree = (\x -> read x :: Tree) oldDataString
  nmString <- getLine
  let nmIntList = map (\x -> read x :: Int) (words nmString)
  let newData = show $ findTreeCycle nmIntList oldDataTree
  putStrLn (newData)

listBlankString :: [Int] -> String
listBlankString [] = []
listBlankString (x:xs) = (show x) ++ " " ++ listBlankString xs

checkData :: IO ()
checkData = do
  oldDataString <- readFile "data.txt"
  putStrLn (oldDataString)

setLeaf :: IO ()
setLeaf = do
  let newData = "Leaf"
  putStrLn (newData)
  (tm , hd) <- openTempFile "." "temp"
  hPutStr hd newData
  hClose hd
  removeFile "data.txt"
  renameFile tm "data.txt"

{-その他の関数-}

data Tree = Leaf | Node Tree (Int, Int) Tree deriving (Show , Read)

{-挿入-}

insertTree :: Int -> Tree -> Tree
insertTree m Leaf                              = (Node Leaf (m,1) Leaf)
insertTree m (Node a1 (a21,a22) a3) | m >  a21 = (Node a1 (a21,a22) (insertTree m a3))
                                    | m == a21 = (Node a1 (a21,a22 + 1) a3)
                                    | m <  a21 = (Node (insertTree m a1) (a21,a22) a3)

insertTreeCycle :: [Int] -> Tree -> Tree
insertTreeCycle []     y = y
insertTreeCycle (x:xs) y = insertTreeCycle xs (insertTree x y)

{-削除-}

removeTree :: Int -> Tree -> Tree
removeTree m Leaf                              = Leaf
removeTree m (Node a1 (a21,a22) a3) | m >  a21 = Node a1 (a21,a22) (removeTree m a3)
                                    | m == a21 = if a22 > 1
                                      then Node a1 (a21,a22 - 1) a3
                                      else findRemoveMaxList (Node a1 (a21,a22) a3)
                                    | m <  a21 = Node (removeTree m a1) (a21,a22) a3

removeTreeCycle :: [Int] -> Tree -> Tree
removeTreeCycle []     y = y
removeTreeCycle (x:xs) y = removeTreeCycle xs (removeTree x y)

findMaxIntPaer :: Tree -> (Int,Int)
findMaxIntPaer (Node a1 (a21,a22) Leaf )   = (a21,a22)
findMaxIntPaer (Node a1 (a21,a22) a3 )     = findMaxIntPaer a3

removeMaxIntPear :: Tree -> Tree
removeMaxIntPear (Node a1 (a21,a22) Leaf )   = a1
removeMaxIntPear (Node a1 (a21,a22) a3 )     = Node a1 (a21,a22) (removeMaxIntPear a3)

findRemoveMaxList :: Tree -> Tree
findRemoveMaxList (Node Leaf (a21,1) a3) = a3
findRemoveMaxList (Node a1 (a21,1) a3)   = Node (removeMaxIntPear a1) (findMaxIntPaer a1) a3

{-検索-}

findTree :: Int -> Tree -> Int
findTree m Leaf                               = 0
findTree m (Node a1 (a21,a22) a3 ) | m >  a21 = findTree m a3
                                  | m == a21 = a22
                                  | m <  a21 = findTree m a1

findTreeCycle :: [Int] -> Tree -> [Int]
findTreeCycle x y = map (\z -> findTree z y) x

{-参照-}
