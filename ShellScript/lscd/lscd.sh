main() {
  ls
  echo "please diectry name or :.. or :q"
  read y
  if [ "$y" == ":q" ] ; then
    echo "quit"
  elif [ "$y" == ":.." ] ; then
    cd ..
    echo "change directry"
    main  
  else
    cd $y
    echo "change directry"
    main
  fi
}

echo "start lscd script"
main
echo "end lscd script"
