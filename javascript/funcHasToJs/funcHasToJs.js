/*Haskellの関数をモジュールに頼らずJavascriptで作る頭の体操*/

/*length*/
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

/*head*/
function head(xs) {
 return(xs[0]);
}

/*tail*/
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

/*init*/
function init(xs){
  function makeLastNumber(i){
    if (xs[i] !== undefined){
      y = xs[i]
      return(makeLastNumber(i + 1));
    }else{
      return(y);
    }
  }
  let i = 0;
  let y = undefined;
  let z = makeLastNumber(i);
  return(z);
}

/*delete*/
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

/*reverse*/
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

/*arrPlus*/
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

/*zipper*/
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

/*map*/
function mapping(func,xs){
  function mapCycle(i){
    if(xs[i] !== undefined){
      ys[i] = func(xs[i]);
      return(mapCycle(i + 1));
    }else{
      return(ys);
    }
  }
  let i = 0
  let ys = []
  let zs = mapCycle(i);
  return(ys);
}

/*foldl*/
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

/*null*/
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

/*sum*/
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

/*maximum*/

/*minimum*/

/*insertSort*/

/*bubbleSort*/

/*mergeSort*/

/*quickSort*/
