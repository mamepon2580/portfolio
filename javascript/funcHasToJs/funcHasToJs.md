
# Haskellの関数をモジュールに頼らずJavascriptで作る頭の体操

個人的なメモで分からなかった所や、出来たことを残しておく健忘録です。
直したり、増やしたり、随時更新していきます。消しちゃったらごめんね。

Haskellっぽさを出すためにfor文ではなく再帰で統一して書いています。
今のところ配列についての関数が多いです。

プログラムはgitのレポジトリに置いてあります。
https://github.com/mamepon2580/portfolio/tree/master/javascript/funcHasToJs

↓↓↓ここからが内容↓↓↓

## 関数型Javascript

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
        function makeNewArr2(i){
          if(xs[i + 1] !== undefined){
            zs[i] = xs[i + 1];
            return(makeNewArr2(i + 1));
          }else{
            return(zs);
          }
        }
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
//arrPuls :: [a] -> [a] -> [a]
function arrPlus(xs,ys){
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

### zipper関数(もどき)

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

### null関数

```Javascript
//nullCheckList :: [a] -> Bool
function nullCheckList(xs) {
  function nullCheck(i){
    if(xs[i] === undefined){
      return(true);
    }else if (xs[i] === undefined){
      return(nullCheck(i + 1));
    }else{
      return(false);
    }
  }
  let i = 0;
  let bool = nullCheck(i);
  return (bool);
}
```

### sum関数

```Javascript
//Num a => [a] -> a
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
