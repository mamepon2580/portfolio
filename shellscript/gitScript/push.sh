pushScript(){
 cd portfolio
 git add .
 git commit -m $(cat -)
 git push origin master
 cd ..
}

echo "start script"
pushScript  
echo "end script"
