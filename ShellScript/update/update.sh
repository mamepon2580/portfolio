#update.sh
main(){
  func(){
    echo "copy $i ? y/n"
    read w
    if [ "$w" == "y" ]; then
      y=$(pwd)
      z=$(sed 's/\/home\/aki\/program//g' <<END
$y
END
)
      cp -r $i ~/github/portfolio$z/
      echo "$i copy"
    elif [ "$w" == "n" ]; then
      echo "$i didn't"
    else
      echo "error"
      func
    fi
  }
  x=$(ls)
  for i in $x
  do
    func
  done
}

echo "script start"
main
echo "script end"
