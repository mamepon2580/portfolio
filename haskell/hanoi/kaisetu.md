
# paizaラーニングの練習問題をHaskellで解く　ハノイの塔

(paizaランク A 相当)

paizaの練習問題がhaskellに対応していたので練習に問いてみました。

[ハノイの塔 (paizaランク A 相当))](https://paiza.jp/learning/hanoi)

健忘録です。
☆☆☆でテスト通りました。

## main関数

hanoiについては後で解説します。

```haskell
{-main関数-}
main = do
  x <- getLine
  mapM_ putStrLn (hanoi x)
```

## IO関数

今回の内容はIO処理がかなり面倒なのでいくつかに分けて説明します。

### 出力

ハノイの塔の積木をIntとして扱い、3つのリストを塔に見立て行き来させることで扱うのですが、リストの先頭に大きい数が来ると、後ろの方まで調べなけばならず計算量が増えるので、予め順序を逆転しておきます。なので最後に出力させるときは、反転させてから出力します。

あとで解説しますが、リストが空になると大小関係を比較できないので、土台として最も大きいIntの数をリストの最後に用意しておき、出力するときにはそれを取り除きます。

また、数字と数字の間にスペースを入れて出力するために、文字の最後にスペースを追加し、それを文字列として連結したあと、最後に文字列の最後のスペースを取り除きます。そして、文字列が空のリストだった場合にはハイフンを追加します。


- **hanoi** は受け取った数字、スペース、数字の値に帯対し、解いたハノイの塔を文字列のリストとして返す関数です。

- **removeAdd** は文字列の最後の文字を削除し、もし文字列が空のリストである場合には、ハイフンを追加し文字列を返す関数です。

- **link** は与えられた文字列のリストをハイフンを挟んで連結する関数で、最後の文字の後ろにもハイフンがつきます。

- **intListToStringList** はIntのリストの要素を文字列に直した値をリストとして返す関数です。

moveHanoiについては後で解説します。

```haskell
hanoi :: String -> [String]
hanoi x = map removeAdd (map link (map reverse (intListToStringList (map init (moveHanoi x)))))

removeAdd :: String -> String
removeAdd x | x == []   = "-"
            | otherwise = init x

link :: [String] -> String
link [] = ""
link (x:xs) = x ++ " " ++ link xs

intListToStringList :: [[Int]] -> [[String]]
intListToStringList x = map (\x -> map show x) 
```

### 入力

入力される値は一行で数字、スペース、数字の形で与えられるので、それをIntのリストに直し、第一要素を返す関数と、第二要素を返す関数を作り、2つに分けます。

- **getX** は引数のIntのリストの第一要素を返す関数である。
- **getY** はgetXと同じく引数の第二要素を返す関数である。

```haskell
getX :: [Int] -> Int
getX (x:_) = x

getY :: [Int] -> Int
getY (_:y:_) = y
```

入力された値を整形しハノイの塔を解く関数に流し込みます。

- **moveHanoi** は数字、スペース、数字からなる文字列を受け取り、2つ目の数字の値だけ左にハノイの塔を積み上げ、1つ目の数字の値だけそれを答えに向かって捜査し、最後のハノイの状態の値を返す関数です。

- **stringToIntList** は数字、スペース、数字で与えられる文字列をスペースで区切り、2つの要素をもつIntのリストとして値を返す関数です。

- **initialState** は2つのIntのリストから第一要素を受け取り、ハノイの塔を解く前の初期状態を3つのIntのリストとして作りその値を返す関数です。


moveCycleとmakeBoxについてはあとで解説します。

```haskell
moveHanoi :: String -> [[Int]]
moveHanoi x = moveCycle 0 (getY (stringToIntList x)) (initialState x)

stringToIntList :: String -> [Int]
stringToIntList x = map (\x -> read x ::Int) (words x)

initialState :: String -> [[Int]]
initialState x = makeBox (getX (stringToIntList x))
```

## その他の関数

### 初期状態

まず、ハノイの塔の土台に当たる部分を作り、その一番左端にx個のすべての大きさの積み木を積みます。maxBoundはIntのなかで一番大きい数なので動かされる心配はありません。なので、これを土台として活用し、リストが空になって値を比較できなくなるのを防ぎます。

- **makeBox** はIntを受け取り、1からその値の数だけ順番に列挙したリストを生成し、それをmaxBoundの入った3つリストの第1要素のリストに前から連結し、その値を返す関数です。

```haskell
makeBox :: Int -> [[Int]]
makeBox x = [[1..x]++[maxBound],[maxBound],[maxBound]]
```

### 移動

次に、積木を掴んで移動させる為の関数を作っておきます。

- **chach** は第三引数で与えられた3つのIntのリストに対し、第一引数で与えられたIntの値番目のリストから、第二引数で与えられた値番目のリストにリストの第一要素を移動させその値を返す関数です。

```haskell
catch :: Int -> Int -> [[Int]] -> [[Int]]
catch x y ((l:ls):(m:ms):(n:ns):[]) | x == 1 && y == 2 = ((ls):(l:m:ms):(n:ns):[])
                                    | x == 1 && y == 3 = ((ls):(m:ms):(l:n:ns):[])
                                    | x == 2 && y == 1 = ((m:l:ls):(ms):(n:ns):[])
                                    | x == 2 && y == 3 = ((l:ls):(ms):(m:n:ns):[])
                                    | x == 3 && y == 1 = ((n:l:ls):(m:ms):(ns):[])
                                    | x == 3 && y == 2 = ((l:ls):(n:m:ms):(ns):[])
```

### ハノイの塔

ここからはハノイの塔の状態を評価し解くための関数を作ります。

強引にすべてのパターンを列挙してそれぞれについて処理を記述していきます。ここで重要なのは、ハノイの塔の評価は現状態がどうなっているかだけでは情報が足りず、解くことが出来ないということです。なので、
一つ前の状態でどの積み木を動かしたのか記憶しておく必要があり、それは動かさないように関数を定義する必要があります。

  **moveCycle** は第一引数に前の状態で動かした積み木の値を保持し、第二引数に残りの動かす回数、第三引数に3つのIntのリストを持ちます。3つのリストの第1要素を比較し、前回動かしたものでないものの中で動かす積木を決定します。<br>
1. まず、3つのリストの第一要素の中で2番目に大きい値の積み木をとり、それより大きい積み木のところへ移動させていきます。これを6パターン記述します。
2. 次に、一番小さい積木を動かすときで、差が1になる積み木の上に優先的に動かすよう先に記述しておきます。
3. そして、一番小さい積木を動かすときでそれ以外の場合は、3つのリストの中で2番目に大きい積み木が偶数ならその上に、奇数なら一番大きい積み木の上に動かす様に記述します
4. 最後に、最初に動かすときには前状態がないので第一引数に0をとり、また、2つ目のリストと3つ目のリストのどちらに動かすのかを、与えられた積み木の数が偶数か奇数かで決定します。これは、必ず3つめのリストにハノイの塔が完成されるようにするためです。

関数を一回適応する毎に第二引数の値が0になったら再帰的に関数を呼び出すのをやめ、その値を返すよう定義しています。

```haskell
moveCycle :: Int -> Int -> [[Int]] -> [[Int]]
moveCycle x 0 ((l:ls):(m:ms):(n:ns):[]) = ((l:ls):(m:ms):(n:ns):[])
moveCycle x y ((l:ls):(m:ms):(n:ns):[])
{-1.-}
  | x /= m && l < m && m < n && m < n = moveCycle m (y - 1) (catch 2 3 ((l:ls):(m:ms):(n:ns):[]))
  | x /= m && n < m && m < l && m < l = moveCycle m (y - 1) (catch 2 1 ((l:ls):(m:ms):(n:ns):[]))
  | x /= n && m < n && n < l && n < l = moveCycle n (y - 1) (catch 3 1 ((l:ls):(m:ms):(n:ns):[]))
  | x /= n && l < n && n < m && n < m = moveCycle n (y - 1) (catch 3 2 ((l:ls):(m:ms):(n:ns):[]))
  | x /= l && n < l && l < m && l < m = moveCycle l (y - 1) (catch 1 2 ((l:ls):(m:ms):(n:ns):[]))
  | x /= l && m < l && l < n && l < n = moveCycle l (y - 1) (catch 1 3 ((l:ls):(m:ms):(n:ns):[]))
{-2.-}
  | x /= l && l < m && m < n && l == (m - 1) = moveCycle l (y - 1) (catch 1 2 ((l:ls):(m:ms):(n:ns):[]))
  | x /= l && l < n && l < m && l == (n - 1) = moveCycle l (y - 1) (catch 1 3 ((l:ls):(m:ms):(n:ns):[]))
  | x /= m && m < n && n < l && m == (n - 1) = moveCycle m (y - 1) (catch 2 3 ((l:ls):(m:ms):(n:ns):[]))
  | x /= m && m < l && l < n && m == (l - 1) = moveCycle m (y - 1) (catch 2 1 ((l:ls):(m:ms):(n:ns):[]))
  | x /= n && n < l && l < m && n == (l - 1) = moveCycle n (y - 1) (catch 3 1 ((l:ls):(m:ms):(n:ns):[]))
  | x /= n && n < m && m < l && n == (m - 1) = moveCycle n (y - 1) (catch 3 2 ((l:ls):(m:ms):(n:ns):[]))
{-3.-}
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
{-4.-}
  | even (length (l:ls)) = moveCycle 1 (y - 1) (catch 1 3 ((l:ls):(m:ms):(n:ns):[]))
  | odd  (length (l:ls)) = moveCycle 1 (y - 1) (catch 1 2 ((l:ls):(m:ms):(n:ns):[]))
```
IO処理が面倒でした。
