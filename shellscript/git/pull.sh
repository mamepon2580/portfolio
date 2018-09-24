#pull.sh
pullScript(){
 dir=${pwd}
 cd ~/github/portfolio
 git pull origin master
 cd $dir
}

echo "start pull script"
pullScript
echo "end pull script"
