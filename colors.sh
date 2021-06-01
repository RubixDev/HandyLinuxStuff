#!/bin/bash

with_nums=false

rainbow () {
  for row in {0..95}; do
    str=""
    for gubu in {1..16}; do str+="\033[48;2;255;$(( gubu * 16 - 8 ));0m  \033[0m"; done
    for rdrd in {16..1}; do str+="\033[48;2;$(( rdrd * 16 - 8 ));255;0m  \033[0m"; done
    for bugu in {1..16}; do str+="\033[48;2;0;255;$(( bugu * 16 - 8 ))m  \033[0m"; done
    for gdbd in {16..1}; do str+="\033[48;2;0;$(( gdbd * 16 - 8 ));255m  \033[0m"; done
    for ruru in {1..16}; do str+="\033[48;2;$(( ruru * 16 - 8 ));0;255m  \033[0m"; done
    for bdgd in {16..1}; do str+="\033[48;2;255;0;$(( bdgd * 16 - 8 ))m  \033[0m"; done
    space=""
    for (( i=0; i<row; i++ )); do space+="  "; done
    echo -e "$space$str$str"
  done
  exit
}

while getopts :nrR flag; do
  case $flag in
    n) with_nums=true ;;
    r) rainbow ;;
    *) echo "$0: Invalid option: -$OPTARG" >&2; exit 1 ;;
  esac
done

for num1 in {0..1}; do
  str=""
  for num2 in {0..7}; do
    colnum=$(( num1 * 8 + num2 ))
    if [ $with_nums = true ]; then printf -v colnum_padded "%4d" "$colnum"; else colnum_padded="   "; fi
    str+="\033[48;5;${colnum}m${colnum_padded}\033[0m"
  done
  echo -e "$str"
done

echo

str=""
for num in {232..255}; do
  if [ $with_nums = true ]; then printf -v num_padded "%4d" "$num"; else num_padded="   "; fi
  str+="\033[48;5;${num}m${num_padded}\033[0m"
done
echo -e "$str"

echo

for row in {0..11}; do
  str=""
  for block in {0..2}; do
    for num in {0..5}; do
      colnum=$(( row * 6 + num + block * 36 + 16 ))
      if [ $with_nums = true ]; then printf -v colnum_padded "%4d" "$colnum"; else colnum_padded="   "; fi
      str+="\033[48;5;${colnum}m${colnum_padded}\033[0m"
    done
    str+="  "
  done
  echo -e "$str"
  if [ "$row" -eq 5 ]; then echo; fi
done
