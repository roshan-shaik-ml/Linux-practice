num=1
val=10

while [ $num -le $val ]
do
    num=`expr $num + 1`
done

echo $num
