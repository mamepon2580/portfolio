
# gitのリポジトリにpull、pushするだけの簡単なShellScript

サルでも覚えられると巷でウワサされるgitコマンドを忘れ、Qiitaの記事を開いてそのまま入力することに疲れてたんだ…

簡単なpull、pushのコマンドをまとめたshellscriptです。

プログラムはgitのレポジトリに置いてあります。
https://github.com/mamepon2580/portfolio/tree/master/shellscript/gitScript

↓↓↓ここからが内容↓↓↓

## ShellScript

### pull

- **`pull.sh`** はそのまま一緒に、リモートリポジトリ送りにされるのが嫌なので、ローカルリポジトリのすぐ上のディレクトリに保存しておきます。`pullScript` 中身はコマンドを固めただけです。

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
push.sh
- **`push.sh`** も `pull.sh`と同様に、ローカルリポジトリのすぐ上のディレクトリに保存しておきます。`$(cat -)` は入力を受け付け`git commit -m` 引数としてコミットコメントを渡します。

```shell
#push.sh
pushScript(){
 cd portfolio
 git add .
 echo "please comment"
 git commit -m $(cat -)
 git push origin master
 cd ..
}

echo "start push script"
pushScript
echo "end push script"
```
