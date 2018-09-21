
# gitのリポジトリにpull、pushするだけの簡単なShellScript

サルでも覚えられると巷でウワサされるgitコマンドを忘れ、Qiitaの記事を開いてそのまま入力することに疲れてたんだ…

簡単なpull、pushのコマンドをまとめたshellscriptです。

プログラムはgitのレポジトリに置いてあります。
https://github.com/mamepon2580/portfolio/tree/master/shellscript/gitScript

↓↓↓ここからが内容↓↓↓

## ShellScript

### pull

- **`pull.sh`** はそのまま一緒にリモートリポジトリ送りにされるのが嫌なので、ローカルリポジトリのすぐ上のディレクトリに保存しておきます。`pullScript` 中身はコマンドを固めただけです。

```shell
#pull.sh
pullScript(){
 cd portfolio
 git pull origin master
 cd ..
}

echo "start pull script"
pullScript
echo "end pull script"
```

### push

- **`push.sh`** も `pull.sh`と同様に、ローカルリポジトリのすぐ上のディレクトリに保存しておきます。`read` で変数 x を入力として受け付け`git commit -m` 引数としてコミットコメントを渡します。また変数 y を定義しその値によって分岐させます。※注意if文の条件は[スペース 条件式 スペース]にしないとうまくいきません←ここで二時間位悩んだ。

```shell
#push.sh
pushScript(){
 cd portfolio
 git add .
 echo "all file in staging"
 echo "please comment"
 read x
 git commit -m $x
 echo "all file in local repository"
 echo "please :m is master , :b is brunch"
 read y
 if [ "$y" = ":m" ] ; then
  git push origin master
elif [ "$y" = ":b" ] ; then
  echo "please brunch name"
  read z
  git push origin $z:$z
 else
  echo "error"
fi
 cd ..
}

echo "start push script"
pushScript
echo "end push script"
