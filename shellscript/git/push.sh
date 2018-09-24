#push.sh
pushScript(){
 cd portfolio
 git add .
 echo "all file in staging"
 echo "please comment"
 read x y
 git commit -m $x -m $y
 echo "all file in local repository"
 echo "please :m is master , :b is brunch"
 read z
 if [ "$z" = ":m" ] ; then
  git push origin master
elif [ "$z" = ":b" ] ; then
  echo "please brunch name"
  read w
  git push origin $w:$w
 else
  echo "error"
fi
 cd ..
}

echo "start push script"
pushScript
echo "end push script"
