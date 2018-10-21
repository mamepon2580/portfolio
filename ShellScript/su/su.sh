#su.sh
#main :: password -> IO
main(){
 password=$1
 expect -c "
 set timeout 5
 spawn su
 expect \"Password:\"
 send \"${password}\n\"
 expect \"$\"
 interact
 exit 0
"

}

echo "start su.sh script"
main $1
echo "end su.sh script"
