
# Haskellの関数をモジュールに頼らずJavascriptで作る頭の体操

個人的なメモで分からなかった所や、出来たことを残しておく健忘録です。
直したり、増やしたり、随時更新していきます。消しちゃったらごめんね。

Haskellっぽさを出すためにfor文ではなく再帰で統一して書いています。
今のところ配列についての関数が多いです。

でも配列をリストとして扱うのには無理があるので、今回はメソッド縛りだったけどちゃんと使った方がいいです。
目指すところは、object指向と関数型をうまくいいとこ取りする感じです。

プログラムはgitのレポジトリに置いてあります。
https://github.com/mamepon2580/portfolio/tree/master/javascript/funcHasToJs

↓↓↓ここからが内容↓↓↓

## 関数型JavaScript

### length関数

```Javascript
//length :: [a] -> Int
function length(xs) {
  function searchUndefined(i){
    if(xs[i] !== undefined){
      return searchUndefined(i + 1);
    }else{
      return (i);
    }
  }
  let i = 0;
  let y = searchUndefined(i);
  return(y);
}
```

### head関数

```Javascript
//head :: [a] -> a
function head(xs) {
 return(xs[0]);
}
```

### last関数

```javascript
//last :: [a] -> a
function last(xs){
  xl = length(xs);
  y = xs[xl - 1];
  return(y);
}
```


### tail関数

```javascript
//tail :: [a] -> [a]
function tail(xs){
  function makeNewArr(i){
    if (xs[i] !== undefined){
      ys[i - 1] = xs[i]
      return(makeNewArr(i + 1));
    }else{
      return (ys);
    }
  }
  let i = 1;
  let ys = [];
  let zs = makeNewArr(i);
  return(zs);
}
```

### init関数

```Javascript
//init :: [a] -> [a]
function init(xs){
  function makeLastNumber(i){
    if (xs[i] !== undefined){
      y = xs[i]
      return(makeLastNumber(i + 1));
    }else{
      return (y);
    }
  }
  let i = 0;
  let y = undefined;
  let z = makeLastNumber(i);
  return(z);
}

```

### take関数

```javascript
//take:: Int -> [a] -> [a]
function take(x,ys){
  function makeNewArr(i){
    if(ys[i] === undefined || i === x){
      return(zs);
    }else{
      zs[i] = ys[i];
      return(makeNewArr(i + 1));
    }
  }
  let i = 0;
  let zs = [];
  let ws = makeNewArr(i);
  return(ws);
}
```

### drop関数

```javascript

//drop :: Int -> [a] -> [a]
function drop(x,ys){
  function makeNewArr(i,j){
    if(ys[j] === undefined){
      return(zs);
    }else if(j >= x){
      zs[i] = ys[j];
      return(makeNewArr(i + 1,j + 1));
    }else{
      return(makeNewArr(i,j + 1));
    }
  }
  let i = 0;
  let j = 0;
  let zs = [];
  let ws = makeNewArr(i,j);
  return(ws);
}
```

### delete関数

```javascript
//deleteFirst :: [a] -> [a]
function deleteFirst(xs,y){
  function makeNewArr1(i){
    if(xs[i] !== undefined){
      if(xs[i] !== y){
        zs[i] = xs[i];
        return(makeNewArr1(i + 1));
      }else{
        let ws = makeNewArr2(i);
        return(ws)
      }
    }else{
      return(zs);
    }
  }
  let i = 0;
  let zs =[];
  let vs = makeNewArr1(i);
  return(vs);
}
```

### reverse関数

```Javascript
//reverse :: [a] -> [a]
function reverse(xs){
  function makeNewArr(i){
      if(xs[i] !== undefined){
        ys[xl - i - 1] = xs[i];
        return(makeNewArr(i + 1));
      }else{
        return(ys)
      }
  }
  let i = 0;
  let xl = length(xs);
  let ys =[];
  let zs = makeNewArr(i);
  return(zs);
}
```

### list結合

```Javascript
//arrConect :: [a] -> [a] -> [a]
function arrConect(xs,ys){
  function makeNewArr(i){
    if(i < xl + yl){
      if(i < xl){
        zs[i] = xs[i];
      }else{
        zs[i] = ys[i - xl];
      }return(makeNewArr(i + 1));
    }else{
      return(zs);
    }
  }
  let i = 0;
  let xl = length(xs);
  let yl = length(ys);
  let zs =[];
  let ws = makeNewArr(i);
  return(ws);
}
```

### concat

```javascript
//concat :: [[a]] -> [a]
function concat(xss){
  let ys = foldLeft(arrConect,[],xss)
  return(ys)
}
```

### zipper関数(もどき)

→タプルがないのでとりあえず配列で作った

```javascript
//zipper :: [a] -> [a] -> [[a]]
function zipper(xs,ys){
  function makeNewArrTuple(i){
    if(xs[i] !== undefined && ys[i] !== undefined){
      zs[i] = [xs[i],ys[i]];
      return(makeNewArrTuple(i + 1));
    }else{
      return(zs);
    }
  }
  let i = 0;
  let zs =[];
  let ws = makeNewArrTuple(i);
  return(ws);
}
```

### zipWith

```javascript
//zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
function zipWith(func,xs,ys){
  function funcCycle(i){
    if(xs[i] !== undefined && ys[i] !== undefined){
      zs[i] = func(xs[i],ys[i]);
      return(funcCycle(i + 1));
    }else{
      return(zs);
    }
  }
  let i = 0;
  let zs = [];
  let ws = funcCycle(i);
  return(ws);
}
```

### map関数

```Javascript
//mapping :: (a -> b) -> [a] -> [b]
function mapping(func,xs){
  function mapCycle(i){
    if(xs[i] !== undefined){
      ys[i] = func(xs[i]);
      return(mapCycle(i + 1));
    }else{
      return(ys);
    }
  }
  let i = 0;
  let ys = [];
  let zs = mapCycle(i);
  return(ys);
}
```

### foldl関数

```Javascript
//foldLeft :: (a -> b -> a) -> a -> [b] -> a
function foldLeft(func,y,xs){
  function fold(i){
    if(xs[i] !== undefined){
      return(func(xs[i],fold(i + 1)));
    }else {
      return(y);
    }
  }
  let i = 0;
  let z = fold(i);
  return(z);
}
```

### curry関数

```javascript
//curry :: (a -> b -> c) -> (a -> (b -> c))
function curry(func){
  return(function(Arg1){
    return(function(Arg2){
      return(func(Argument1,Argument2))
    });
  });
}
```

### maximum関数

```javascript
//maxList :: [a] -> a
function maxList(xs){
  function maxSaveCycle(i){
    if (xs[i] !== undefined) {
      if(y <= xs[i] || y === null){
        y = xs[i]
        return (maxSaveCycle(i + 1));
      }else{
        return (maxSaveCycle(i + 1));
      }
    }else{
      return(y);
    }
  }
  let i = 0;
  let y = null;
  let z = maxSaveCycle(i)
  return(y);
}
```

### minimum関数

```javascript
//mixList :: [a] -> a
function minList(xs){
  function minSaveCycle(i){
    if (xs[i] !== undefined) {
      if(y >= xs[i] || y === null){
        y = xs[i]
        return (minSaveCycle(i + 1));
      }else{
        return (minSaveCycle(i + 1));
      }
    }else{
      return(y);
    }
  }
  let i = 0;
  let y = null;
  let z = minSaveCycle(i)
  return(y);
}
```

### filter関数

```javascript
//filter :: (a -> Bool) -> [a] -> [a]
function filter(func,xs){
  function filterCycle(i,j){
    if(xs[j] !== undefined){
      if(func(xs[j])){
        return(filterCycle(i,j + 1));
      }else{
        ys[i] = xs[j]
        return(filterCycle(i + 1,j + 1));
      }
    }else{
      return(ys);
    }
  }
  let i = 0;
  let j = 0;
  let ys = [];
  let zs = filterCycle(i,j);
  return(ys);
}
```

### elem関数

```javascript
//elem :: Eq a => a -> [a] -> Bool
function elem(x,ys){
  function boolCycle(i){
    if(ys[i] !== undefined){
      if(x === ys[i]){
        return(true);
      }else{
        return(boolCycle(i + 1))
      }
    }else {
      return(false)
    }
  }
  let i = 0;
  let y = boolCycle(i);
  return(y);
}
```

### all関数

```javascript
//all :: (a -> Bool) -> [a] -> Bool
function any(func,xs){
  function boolCycle(i){
    if(xs[i] !== undefined){
      if(func(xs[i])){
        return(true);
      }else{
        return(boolCycle(i + 1))
      }
    }else {
      return(false)
    }
  }
  let i = 0;
  let y = boolCycle(i);
  return(y);
}
```

### any関数

```javascript
//any :: (a -> Bool) -> [a] -> Bool
function any(func,xs){
  function boolCycle(i){
    if(xs[i] !== undefined){
      if(func(xs[i])){
        return(true);
      }else{
        return(boolCycle(i + 1))
      }
    }else {
      return(false)
    }
  }
  let i = 0;
  let y = boolCycle(i);
  return(y);
}
```

### nullSearch関数

```Javascript
//nullCheckList :: [a] -> Bool
function nullCheckList(xs) {
  function nullCheck(i){
    if(xs[i] === null){
      return(true);
    }else if (xs[i] === undefined){
      return(false);
    }else{
      return(nullCheck(i + 1));
    }
  }
  let i = 0;
  let bool = nullCheck(i);
  return (bool);
}
```

### sum関数

```Javascript
//sum :: Num a => [a] -> a
function sum(xs){
  function plusCycle(i){
    if (xs[i] !== undefined) {
      return (xs[i] + plusCycle(i + 1));
    }else{
      return (0);
    }
  }
  let i = 0;
  let y = plusCycle(i);
  return(y);
}
```

### prodact関数

```javascript
//product :: Num a => [a] -> a
function product(xs){
  function multiplCycle(i){
    if (xs[i] !== undefined) {
      return (xs[i] * multiplCycle(i + 1));
    }else{
      return (1);
    }
  }
  let i = 0;
  let y = multiplCycle(i);
  return(y);
}

```

### repeat関数

```javascript

//repeat :: a -> [a]
function repeat(x , n){
  function cycle(i){
    if (i !== n) {
      ys[i] = x;
      return(cycle(i + 1));
    }else{
      return(ys);
    }
  }
  let i = 0;
  let ys = [];
  let z = cycle(i);
  return (ys);
}
```

### iterate関数

```javascript
//iterate :: (a -> a) -> a -> [a]
function iterate(func,x,n){
  function funcCycle(i){
    if(i !== n){
      ys[i + 1] = func(ys[i]);
      return(funcCycle(i + 1));
    }else {
      return(ys);
    }
  }
  let i = 0;
  let ys = [x];
  let zs = funcCycle(i);
  return(zs);
}
```
