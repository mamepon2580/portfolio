{-計算機パーサー-}

import Data.Char

type Parser a = String -> [(a,String)]

return' :: a -> Parser a
return' x = \inp -> [(x,inp)]

failure :: Parser a
failure = \inp -> []

item :: Parser Char
item = \inp -> case inp of
                 [] -> []
                 (x:xs) -> [(x,xs)]

parse :: Parser a -> String -> [(a,String)]
parse p s = p s

monado :: Parser a -> (a -> Parser b) -> Parser b
monado p f = \inp -> case parse p inp of
                       [] -> []
                       [(u,out)] -> parse (f u) out

_monado :: Parser a -> Parser b -> Parser b
_monado p p' = p `monado` (\_ -> p')

m :: Parser a -> (a -> Parser b) -> Parser b
m p f = \inp -> case parse p inp of
                 [] -> []
                 [(u,out)] -> parse (f u) out

serect :: Parser a -> Parser a -> Parser a
serect f g = \imp -> case parse f imp of
                             [] -> parse g imp
                             [(u,out)] -> [(u,out)]

sat :: (Char -> Bool) -> Parser Char
sat p = item `monado` (\x -> if p x then return' x else failure)

digit :: Parser Char
digit = sat isDigit

lower :: Parser Char
lower = sat isLower

upper :: Parser Char
upper = sat isUpper

letter :: Parser Char
letter = sat isAlpha

alphanum :: Parser Char
alphanum = sat isAlphaNum

char :: Char -> Parser Char
char x = sat (== x)

string :: String -> Parser String
string [] = return' []
string (x:xs) = char x `monado` (\x -> ((string xs) `monado` (\_ -> return' (x:xs))))

many :: Parser a -> Parser [a]
many p = (many1 p) `serect` return' []

many1 :: Parser a -> Parser [a]
many1 p = p `monado` (\u -> ((many p) `monado` (\us -> return' (u:us))))

ident :: Parser String
ident = lower `monado` (\x -> (many alphanum) `monado` (\xs -> return' (x:xs)))

nat :: Parser Int
nat = many1 digit `monado` (\xs -> return' (read xs))

space :: Parser ()
space = (many (sat isSpace)) `monado` (\_ -> return'(()))

token :: Parser a -> Parser a
token p = space `monado` (\_ -> p `monado` (\u -> space `monado`\_ -> return' u))

identifier :: Parser String
identifier = token ident

natural :: Parser Int

natural = token nat

symbol :: String -> Parser String
symbol xs = token (string xs)

p :: Parser [Int]
p = (symbol "[") `m` (\_ -> natural `m` (\n -> (many ((symbol "," )`m` (\_ -> natural))) `m` ((\ns -> (symbol "]") `m` (\_ -> return' (n:ns))))))

{-数式-}

mN = monado
mN' = _monado

expr :: Parser Int
expr = term `mN` (\t -> (
         ((symbol "+" ) `serect` (symbol "-" )) `mN` (\k ->
         expr `mN` (\e ->
         case k of
        "+" -> return' (t + e)
        "-" -> return' (t - e))))
       `serect` (return' t))

term :: Parser Int
term = factor `mN` (\f ->
         (((symbol "*") `serect` (symbol "/")) `mN` (\k ->
         term `mN` (\t ->
         case k of
          "*" -> return' (f * t)
          "/" -> return' (f `div` t))))
       `serect` return' f)

factor :: Parser Int
factor = symbol "(" `mN` (\_ ->
         expr `mN` (\e ->
         symbol ")" `mN` (\_ ->
         return' e)))
         `serect` natural

eval :: String -> Int
eval xs = case parse expr xs of
  [(n,[])]  -> n
  [(_,out)] -> error ("unused input " ++ out)
  []        -> error "invalid input"
