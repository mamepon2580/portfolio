#pull.sh
pullScript(){
 cd portfolio
 git pull origin master
 cd ..
}

echo "start pull script"
pullScript
echo "end pull script"
