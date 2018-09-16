paizaの練習問題がhaskellに対応していたので練習に解いてみました。

[山折り谷折り(paizaランク A 相当)](https://paiza.jp/learning/origami)

健忘録です。
☆☆☆でテスト通りました。

##main関数

入力は一行のみなのでgetLineを用いて受け取りputStrLnで文字列の値を返す。

intListToStringとfoldについては後で解説する。

```haskell
{-main関数-}
main = do
  x <- getLine
  putStrLn (intListToString (fold (read x :: Int)))
```

##IO関数

ここでは受け取ったIntのリストを文字に変換し、文字列として値を返す。

- `intListToString` はInt型のリストを文字列に変換する関数であり、リストの要素に対しshowを再帰的に適応し文字列に変えて値を返す。

```haskell
intListToString :: [Int] -> String
intListToString [] = []
intListToString (x:xs) = (show x) ++ (intListToString xs)
```

##その他の関数

ここからがプログラムの内容

実際に折ってみるとわかるが、一番始めに折り目をつけたところを中心に左右で山折りと谷折りが反転する。なので予め０と１を反転する関数を作り、あとは順序を逆にして連結させればよいので、左半分のみを考える。また左半分に着目すると、１つ前の状態と同じになる。

- `reverse01` は0と1からなる受け取ったIntの値に対し0ならば1を、1ならば0の値を返す関数である。

- `fold` は受け取った数が1のときは0を、そうでないときは引数がiであれば0を中心にして、左側にfoldにi - 1を代入した値を、右側にfoldにi - 1を代入し、1と０を反転させた値を順序を逆にして、Intのリストとして連結したものを返す関数である。


```haskell
reverse01 :: Int -> Int
reverse01 x | x == 0 = 1
            | x == 1 = 0

fold :: Int -> [Int]
fold 1 = [0]
fold i = fold (i - 1) ++ [0] ++ map reverse01 (reverse (fold (i - 1)))
```

他のAランクの練習問題と比べてめちゃめちゃ簡単だった。

