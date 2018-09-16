paizaの練習問題がhaskellに対応していたので練習に問いてみました。

[じゃんけんの手の出し方 (paizaランク A 相当)](https://paiza.jp/learning/janken)

健忘録です。
☆☆☆でテスト通りました。

##main関数

入力された値を受け取り実行するmain関数を作る。

`gcp` はその他の関数、`readX` 、`readY` はIO関数のセクションで解説する。

```haskell
main = do
  x <- getLine
  y <- getLine
  putStrLn $ show $ gcp (readX x) (readY x) y
```

##IO関数

入力された値を扱い易い形に整形する。

- `readX` は受け取った「n1 n2」という数字、スペース、数字の文字列からスペースを取り除きn1の数字のみをInt型として整形し抽出する関数である。

- `readY` はreadXと同じくn2を抽出する。

- `getX` はInt型の要素が２つのリストが与えられたとき１つ目の値を返す関数である。
- `getY` はgetXと同じく２つ目の値を返す。

```haskell
readX :: String -> Int
readX x = getX (map (\x -> read x ::Int) (words x))

readY :: String -> Int
readY x = getY (map (\x -> read x ::Int) (words x))

getX :: [Int] -> Int
getX (x:y:[]) = x

getY :: [Int] -> Int
getY (x:y:[]) = y
```

##その他の関数

ここからがプログラムの内容

### 組み合わせ

まずグー、チョキ、パーのすべての組み合わせをベクトル化しリストにするために、パーの取りうる最大値を調べ、その値を軸にしてパーの数を減らしていきそのときのグーとチョキの数を調べる。

- `div` は割り算の商を求める関数である。

- `nmOfPar` は全体の指の本数を５で割りパーの取りうる最大の数を求め、その値からiを引いた値を返す関数である。

- `nmOfCho` は全体の指の本数からパーの指の本数を引き、残りの指の本数からチョキの数を決定しその値を返す関数である。

- `nmOfGoo` は全体の試合数からグーとパーの数を引き、グーの数を決定しその値を返す関数である。

```haskell
nmOfPar :: Int -> Int -> Int
nmOfPar i x = (x `div` 5) - i

nmOfCho :: Int -> Int -> Int
nmOfCho i x = (x - (5 * (nmOfPar i x))) `div` 2

nmOfGoo :: Int -> Int -> Int -> Int
nmOfGoo i x y = x - (nmOfPar i y) - (nmOfCho i y)
```

### ベクトル化

ここでは指の数がパーで出した指の数の合計とチョキで出した合計の和と一致しているか、またグーの数が０以下になっていないかを調べ、それを満たさない場合には空のリストを生成する。iの値を動かしながらすべてのパターンのグー、チョキ、パーの組み合わせをベクトル化する。

- `checkNmOfFinger` は指の数がパーで出した指の数の合計とチョキで出した合計の和と一致しているか調べ、一致している場合にはtrueを、そうでない場合にはfalseを返す関数である。

- `ptnSearch` はパーの取りうる最大の数からiだけ減らしたとき、指の数がパーで出した指の数の合計とチョキで出した合計の和と一致しており、またグーの数が０以下になっていないなら、そのときのグー、チョキ、パーの数の三組のベクトルの単一要素のリストを生成する。そうでない場合には、空のリストを生成し値を返す関数である。

- `ptnSearchCycle` はiを動かし、パーで減らしたの指の数が全体の指の数を超えた場合には空のリストを生成し、そうでない場合にはそのiの数に対するベクトルを生成したあと、再帰的定義によりiにi - 1を代入した自身の関数を呼び出し、条件を満たすすべてのベクトルのリストを生成する関数である。

```haskell
checkNmOfFinger :: Int -> Int -> Bool
checkNmOfFinger i x = (x - (5 * (nmOfPar i x)) - (2 * (nmOfCho i x))) == 0

ptnSearch :: Int -> Int -> Int -> [(Int,Int,Int)]
ptnSearch i x y | checkNmOfFinger i y && nmOfGoo >= 0 = [((nmOfGoo i x y) , (nmOfCho i y) , (nmOfPar i y))]
                | otherwise                           = []

ptnSearchCycle :: Int -> Int -> Int -> [(Int,Int,Int)]
ptnSearchCycle i x y | (5 * i) > y  = []
                     | (5 * i) <= y = (ptnSearch i x y) ++ ptnSearchCycle (i + 1) x y
```

### 勝利数の最大値

最後に相手の出すグー、チョキ、パーの文字列からグーを出した回数、パーを出した回数、チョキを出した回数の三組のベクトルを生成し、先程のベクトルのリストと比較し、勝つ数の最大値を求める。

- `check` はG、C、Pからなる文字列から、グーなら(1,0,0)を、チョキなら(0,1,0)を、パーなら(0,0,1)を生成し、そのベクトルの和を求めその値を返す関数である。

- `vectorPuls` は三組の２つのベクトルの和を定義している。

- `vectorMinus` はグーで勝つ数、チョキで勝つ数、パーで勝つ数の三組のベクトルを返す関数である。

- `win` は２つのベクトルの第一要素と第三要素、第二要素と第一要素、第三要素と第二要素を比較し、小さい方の値で生成した新しい三組のベクトルを返す関数である。

- `vectorPuls2` はベクトルの第一要素、第二要素、第三要素の和を返す関数である。

- `gcp` はじゃんけんの出し方のベクトルのリストのそれぞれの要素に対し、vectorMinusを適応し勝つ数を求め、その最大値を求める関数である。

```haskell
check :: String -> (Int,Int,Int)
check []                = (0,0,0)
check (x:xs) | x == 'G' = (1,0,0) `vectorPuls` check xs
             | x == 'C' = (0,1,0) `vectorPuls` check xs
             | x == 'P' = (0,0,1) `vectorPuls` check xs

vectorPuls :: (Int,Int,Int) -> (Int,Int,Int) -> (Int,Int,Int)
vectorPuls (x,y,z) (a,b,c) = (x + a,y + b,z + c)

vectorMinus :: (Int,Int,Int) -> (Int,Int,Int) -> (Int,Int,Int)
vectorMinus (x,y,z) (a,b,c) = (x `win` c,y `win` a,z `win` b)

win :: Int -> Int -> Int
win x y | x <= y = x
        | x >= y = y

vectorPuls2 :: (Int,Int,Int) -> Int
vectorPuls2 (x,y,z) = x + y + z

gcp :: Int -> Int -> String -> Int
gcp x y z = maximum (map vectorPuls2 (map  (\x -> vectorMinus (check z) x) (ptnSearchCycle 0 x y)))
```

初投稿キメたぜ。
