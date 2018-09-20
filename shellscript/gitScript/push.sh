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
