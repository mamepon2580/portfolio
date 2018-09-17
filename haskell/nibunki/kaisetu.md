# Haskellで二分木探索を扱う対話型システム

paizaの練習問題をHaskellで解き遊んでいたのですが、どうしてもSランクの問題だとリストでのソートを多用し、計算量が凄まじいことになるいたい。んで、テストが☆☆☆で通らなかったので、これはデータ構造作るしかないと思い、まずは二分木探索に手をつけてみました。

`data.txt`と`nibunki.hs`を予め同じディレクトリに作成しておき`nibunki.hs`を編集していきます。

プログラムはgitのレポジトリに置いてあります。
https://github.com/mamepon2580/portfolio/tree/master/haskell/nibunki

↓↓↓ここからが内容↓↓↓

## モジュール

予め使う関数のモジュールを用意しておく。

```haskell
import System.IO
import System.Directory
import Data.List
```

## main関数

main関数を定義する。細かなIO関数の処理は後で定義することにして、大枠だけここで作る。

 - **`main`**  は実際に実行されるIO処理だが、今回は命令とそれに伴う値を受け取り、命令に従った処理を実行する対話型のシステムを作るので、受け取った命令の文字列に応じて処理が行われるようcase文を使って`order` の値によって分岐させておく。読み難くなるのを防ぐため、その先のIO処理は別に記述する。修了を表す`quit` 以外は新しい命令を受け付けるよう`>> main` を記述しておく。

```haskell
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
```

## IO関数

### 挿入IO

挿入を行うIO処理を作る。二分木を読み込み、スペースで区切られた数字の文字列をターミナルから受け取り、その数字を前から順に二分木に挿入する。

- **`insCycle`** は、まず、`oldDataString` に`data.txt` から読み込んだ文字列のデータを束縛する。次に、それを`read` を使って木構造として読み込んだ値を`oldDataTree` に束縛する。そして、スペースで区切られた文字列を受け取り、`nmString` に束縛する。さらに、`map` と`read` を使って、Intのリストに整形し、その値を`nmIntList` に束縛する。`insertCycle` に`oldDataTree` と`nmIntList` を渡し、Intのリストを二分木に挿入し、その値を`newData` に束縛する。`openTempFile` を使って一時的にデータを保管する場所を作り、`hd`の中に、`newData` の値を格納する。`removeFile` で`data.txt`を削除し、`renameFile` で`tm` の名前を`data.txt` に変更する。  

`insertCycle` についてはその他の関数で説明する。

```haskell
insCycle :: IO ()
insCycle = do
  oldDataString <- readFile "data.txt"
  let oldDataTree = (\x -> read x :: Tree) oldDataString
  nmString <- getLine
  let nmIntList = map (\x -> read x :: Int) (words nmString)
  let newData = show $ insertTreeCycle nmIntList oldDataTree
  putStrLn (newData)
  (tm , hd) <- openTempFile "." "temp"
  hPutStr hd newData
  hClose hd
  removeFile "data.txt"
  renameFile tm "data.txt"
```

### 削除IO

削除を行うIO処理を作る。二分木を読み込み、スペースで区切られた数字の文字列をターミナルから受け取り、その数字を前から順に二分木から削除する。

- **`remoCycle`** は、`insCycle` とほぼ同じ処理をするが、`insertTreeCycle` ではなく、`removeTreeCycle` を用いる。

`removeTreeCycle` についてはその他の関数で説明する。

```haskell
remoCycle :: IO ()
remoCycle = do
  oldDataString <- readFile "data.txt"
  let oldDataTree = (\x -> read x :: Tree) oldDataString
  nmString <- getLine
  let nmIntList = map (\x -> read x :: Int) (words nmString)
  let newData = show $ removeTreeCycle nmIntList oldDataTree
  putStrLn (newData)
  (tm , hd) <- openTempFile "." "temp"
  hPutStr hd newData
  hClose hd
  removeFile "data.txt"
  renameFile tm "data.txt"
```

### 検索IO

検索を行うIO処理を作る。二分木を読み込み、スペースで区切られた数字の文字列をターミナルから受け取り、その数字を前から順に二分木にどれだけあるか調べる。


- **`findNumber`** は、`insCycle` とほぼ同じ処理をするが、`insertTreeCycle` ではなく、`findTreeCycle` を用いる。また、検索を行うだけで書き込みは行わないので、後半の`putStrLn (newData)` 以降は消去している。
- **`ListBlankString`** は、出力する際に、数字をスペースで区切り文字列として返す関数である。

`findTreeCycle` についてはその他の関数で説明する。

```haskell
findNumber :: IO ()
findNumber = do
  oldDataString <- readFile "data.txt"
  let oldDataTree = (\x -> read x :: Tree) oldDataString
  nmString <- getLine
  let nmIntList = map (\x -> read x :: Int) (words nmString)
  let numberList = init $ listBlankString $ (findTreeCycle nmIntList oldDataTree)
  putStrLn (numberList)

listBlankString :: [Int] -> String
listBlankString [] = []
listBlankString (x:xs) = (show x) ++ " " ++ listBlankString xs
```

### 参照IO

参照を行うIO処理を作る。二分木を読み込み、それを表示する。

- **`checkData`** は、ただ、`oldDataString` に`data.txt` から読み込んだ文字列のデータを束縛し、それを`putStrLn` によって文字列として返す。

```haskell
checkData :: IO ()
checkData = do
  oldDataString <- readFile "data.txt"
  putStrLn (oldDataString)
```

### 初期化IO

初期化を行うIO処理を作る。`data.txt` を削除し、文字列`Leaf` の入った新しい`data.txt` を作る。

- **`setLeaf`** は、まず、`newData` に文字列`Leaf` を束縛する。`openTempFile` を使って一時的にデータを保管する場所を作り、`hd`の中に、`newData` の値を格納する。`removeFile` で`data.txt`を削除し、`renameFile` で`tm` の名前を`data.txt` に変更する。  

```haskell
setLeaf :: IO ()
setLeaf = do
  let newData = "Leaf"
  putStrLn (newData)
  (tm , hd) <- openTempFile "." "temp"
  hPutStr hd newData
  hClose hd
  removeFile "data.txt"
  renameFile tm "data.txt"
```

## data型

二分木の根幹となるdata型を定義しておく。少し工夫して`(Int,Int)` としている。これは、`(値,個数)` を表しており、木構造が複雑になり可読性が下がるのを防いでいる。

```haskell
data Tree = Leaf | Node Tree (Int, Int) Tree deriving (Show , Read)
```
## その他の関数

### insert関数

ここでは挿入IOで出てきた`insertTreeCycle` を作る。

- **`insertTree`** は、引数のIntを二分木に挿入する関数であり、二分木がもし`Leaf` なら`Node Leaf (m,1) Leaf` を挿入し、またそれ以外であれば、引数の値が今いるノードの値より大きければ右の二分木に、小さければ左の二分木に、`insertTree` を適応する。もし、挿入するIntの値と同じ値であれば、そのノードの個数を1つ増やす。
- **`insertTreeCycle`** は、引数のIntのリストに対し、再帰的に`insertTree` を適応し、二分木に挿入する関数である。

```haskell
insertTree :: Int -> Tree -> Tree
insertTree m Leaf                              = (Node Leaf (m,1) Leaf)
insertTree m (Node a1 (a21,a22) a3) | m >  a21 = (Node a1 (a21,a22) (insertTree m a3))
                                    | m == a21 = (Node a1 (a21,a22 + 1) a3)
                                    | m <  a21 = (Node (insertTree m a1) (a21,a22) a3)

insertTreeCycle :: [Int] -> Tree -> Tree
insertTreeCycle []     y = y
insertTreeCycle (x:xs) y = insertTreeCycle xs (insertTree x y)
```

### remove関数

ここでは挿入IOで出てきた`removeTreeCycle` を作る。

- **`findMaxIntPear`** は、引数の二分木に対し、今いるノードの右側が`Leaf` であれば探索をやめ、`(Int,Int)` の値を返し、また、`Leaf` でなければ、その右側の二分木に対し`findMaxIntPear` を再帰的に適応する関数である。
- **`removeMaxIntPear`** は、`findMaxIntPear` と基本的には同じなのですが、そのノードの`(Int,Int)` を返すのではなく、それそのものを削除しその下の二分木を連結する。
- **`findRemoveMaxList`** は、少し面倒である。途中にあるノードのタプルの個数が0になってしまう場合それをそのまま削除すると、二分木が二つ残ってしまい接続することができない。なので`findMaxIntPear` と`removeMaxIntPear` を使い、左側の二分木の中で一番大きいノードを見つけ出しそれを持って来て削除した部分の補修に使う。この値は右側の二分木のどのノードより値は小さいが、左側の二分木のどの値よりも大きいので全体の木構造を壊さずに住む。
- **`removeTree`** は、引数のIntの値が、今いるノードの数より大きければ右側に、小さければ左側に`removeTree` を再帰的に適応する関数である。また、ノードが`Leaf` のときはそのまま何もせず、同じ値をとる時はそのノードの個数の値を1減らす。そのとき、1つしかない場合にはそのノードを削除し、`findRemoveMaxList` を適応する関数である。
- **`removeTreeCycle`** は、引数のIntのリストに対し、再帰的に`removeTree` を適応し、二分木から削除する関数である。

```haskell
findMaxIntPaer :: Tree -> (Int,Int)
findMaxIntPaer (Node a1 (a21,a22) Leaf )   = (a21,a22)
findMaxIntPaer (Node a1 (a21,a22) a3 )     = findMaxIntPaer a3

removeMaxIntPear :: Tree -> Tree
removeMaxIntPear (Node a1 (a21,a22) Leaf )   = a1
removeMaxIntPear (Node a1 (a21,a22) a3 )     = Node a1 (a21,a22) (removeMaxIntPear a3)

findRemoveMaxList :: Tree -> Tree
findRemoveMaxList (Node Leaf (a21,1) a3) = a3
findRemoveMaxList (Node a1 (a21,1) a3)   = Node (removeMaxIntPear a1) (findMaxIntPaer a1) a3

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
```

### find関数

ここでは挿入IOで出てきた`findTreeCycle` を作る。

- **`findTree`** は、引数のIntを二分木からいくつあるか検索する関数であり、二分木がもし`Leaf` なら0を返し、またそれ以外であれば、引数の値が今いるノードの値より大きければ右の二分木に、小さければ左の二分木に、`findTree` を適応する。もし、挿入するIntの値と同じ値であれば、そのノードの個数の値を返す。
- **`findTreeCycle`** は、引数のIntのリストに対し、再帰的に`findTree` を適応し、二分木を検索する関数である。


```haskell
findTree :: Int -> Tree -> Int
findTree m Leaf                               = 0
findTree m (Node a1 (a21,a22) a3 ) | m >  a21 = findTree m a3
                                  | m == a21 = a22
                                  | m <  a21 = findTree m a1

findTreeCycle :: [Int] -> Tree -> [Int]
findTreeCycle x y = map (\z -> findTree z y) x
```

## 実行結果

多くのテストをかけたわけではないが、`insert` `remove` `find` `check` `quit` `reset` に対し、期待どおりの結果が得られた。その一例として下記のghcでの実行結果を載せておく。

```terminal
[aki@localhost nibunkitansaku]$ runghc nibunki.hs
please order (insert,remove,find,check,quit,reset)
insert
5 3 7 1 4 1 0 1 6 8 6
Node (Node (Node (Node Leaf (0,1) Leaf) (1,3) Leaf) (3,1) (Node Leaf (4,1) Leaf)) (5,1) (Node (Node Leaf (6,2) Leaf) (7,1) (Node Leaf (8,1) Leaf))
please order (insert,remove,find,check,quit,reset)
remove
5
Node (Node (Node (Node Leaf (0,1) Leaf) (1,3) Leaf) (3,1) Leaf) (4,1) (Node (Node Leaf (6,2) Leaf) (7,1) (Node Leaf (8,1) Leaf))
please order (insert,remove,find,check,quit,reset)
find
1 4
3 1
please order (insert,remove,find,check,quit,reset)
check
Node (Node (Node (Node Leaf (0,1) Leaf) (1,3) Leaf) (3,1) Leaf) (4,1) (Node (Node Leaf (6,2) Leaf) (7,1) (Node Leaf (8,1) Leaf))
please order (insert,remove,find,check,quit,reset)
reset
Leaf
please order (insert,remove,find,check,quit,reset)
quit
[aki@localhost nibunkitansaku]$
```
