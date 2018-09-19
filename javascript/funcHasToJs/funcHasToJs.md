
# Haskellの関数をモジュールに頼らずJavascriptで作る頭の体操

個人的なメモで分からなかった所や、出来たことを残しておく健忘録です。
直したり、増やしたり、随時更新していきます。消しちゃったらごめんね。

Haskellっぽさを出すためにfor文ではなく再帰で統一して書いています。
今のところ配列についての関数が多いです。

プログラムはgitのレポジトリに置いてあります。
https://github.com/mamepon2580/portfolio/tree/master/javascript/funcHasToJs

↓↓↓ここからが内容↓↓↓

## 関数型Javascriptの関数

### length関数

```Javascript
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
function head(xs) {
 return(xs[0]);
}
```

### tail関数

```javascript
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

### reverse関数

```Javascript
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
  return(zs);
}
```

### map関数

```Javascript
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
function foldLeft(func,xs,y){
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
  let ys = nullCheck(i);
  return (ys);
}
```

### sum関数

```Javascript
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
## 参考文献

JavaScriptで関数型プログラミングの入門
https://qiita.com/takeharu/items/cf98d352ff574c5ac536
