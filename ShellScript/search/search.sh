#chrome.sh
#main関数
main(){
 url=$(sed 's/＋/+/g' <<EOF
https://www.google.co.jp/search?q=$1
EOF
)
 google-chrome --disable-javascript $url
}

echo "start chrome sh script"
main $1
echo "end chrome.sh script"
