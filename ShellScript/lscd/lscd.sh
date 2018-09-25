##lscd.sh
main() {
  x=$(ls)
  y=$(sed 's/ /\n/g' <<EOF
$x
EOF
)
  cat -n <<EOF
$y
EOF
  y=($y)
  echo "please diectry name or .. or q or number"
  read z
  if [ "$z" == "q" ] ; then
    echo "quit"
  elif [ "$z" == ".." ] ; then
    cd ..
    echo "change directry"
    main
  else
    z=$(expr $z + 1)
    cd ${y[$z]}
    echo "change directry"
    main
  fi
}

echo "start lscd script"
main
echo "end lscd script"
