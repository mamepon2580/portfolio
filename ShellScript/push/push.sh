#push.sh
pushScript(){
 dir=${pwd}
 cd ~/github/portfolio
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
 cd $dir
}

echo "start push script"
pushScript
echo "end push script"
