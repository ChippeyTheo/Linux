#!/usr/bin/bash
# theo
# 04/03/2024

machine_name=$(hostnamectl | grep Static | cut -d' ' -f4)
echo "Machine name : ${machine_name}"


source /etc/os-release
kernel_version=$(uname -r)
echo "OS ${PRETTY_NAME} and kernel version is ${kernel_version}"


my_ip=$(ip a | grep -E '^2:' -A 2 | grep inet | tr -s ' ' | cut -d' ' -f3)
echo "IP : ${my_ip}"


RAM_free=$(free --mega | grep Mem: | tr -s ' ' | cut -d' ' -f4)
RAM_total=$(free --mega | grep Mem: | tr -s ' ' | cut -d' ' -f2)
echo "RAM : ${RAM_free}Mo memory available on ${RAM_total}Mo total memory"


Space_left=$(df / -h | grep / | tr -s ' ' | cut -d' ' -f4)
echo "Disk : ${Space_left} space left"


echo "Top 5 processes by RAM usage :"

while read theo_coucou; do

  prog=$(cut -d' ' -f1 <<< "$theo_coucou" | rev | cut -d'/' -f1 | rev)
  echo "  - $prog"

done <<< "$(ps -eo cmd= --sort=-%mem | head -n5)"


echo "Listening ports :"

while read theo_ecoute; do

  proto=$(cut -d' ' -f1 <<< "$theo_ecoute")
  port=$(cut -d':' -f2  <<< "$theo_ecoute" | cut -d ' ' -f1)
  prog=$(cut -d'"' -f2 <<< "$theo_ecoute")
  echo "  - $port $proto : $prog"

done <<< "$(sudo ss -lnputH4 | tr -s ' ')"


echo "PATH directories :"

res="${PATH//[^:]}"
end=$(( ${#res} + 1))

for i in $(seq 1 $end)
do
  result=$(cut -d':' -f$i <<< "$(echo $PATH)")
  echo "  - $result"
  (( i++ ))
done


urldechat=https://api.thecatapi.com/v1/images/search

avantlechat=$(curl -SL $urldechat -s)
monchat=$(cut -d'"' -f8 <<< "$avantlechat")
ext=$(cut -d'.' -f4 <<< "$monchat")
echo "Here is your random cat ($ext file) : $monchat" 
