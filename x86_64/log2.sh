#!/bin/bash
log2(){
x=0;
for (( i=$1-1; $i > 0; i >>= 1 )) 
do
    #let "x=$x+1"
    (( x=$x+1 ))
done
echo $x
}

log2 $1

