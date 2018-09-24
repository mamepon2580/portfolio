##rmCycle
main(){
  x=$(ls)
  for i in $x
  do
    echo "remove file $i ? y/n"
    read y
    if [ "$y" == "y" ];then
      rm -r $i
      echo "$i remove"
    elif [ "$y == "n ]; then
      echo "$i didn't"
    else
      echo "error"
    fi
  done
  ls
}

echo "start script"
main
echo "end script"
