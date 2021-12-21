. ../chia-blockchain/activate
ram=8192
name="`date +%Y-%m-%dT%H-%M-%S.%NZ`" #  0/#date

tmp="/mnt/b"
final="/media/pahn/1blackSanDisk"
parallel=1
mx=5

mkdir -m 777 -p $tmp/$name/

for i in `seq 0 $mx`
do
    echo "$i"
    mkdir -m 777 -p $final/$name/$i/
    mkdir -m 777 -p $tmp/$name/$i/
    start_time=`date +%s`

    chia plots create -k 32 -n 1 -r $parallel -b $ram -t $tmp/$name/ -d $final/$name/$i/ -e 
    rm -r  $tmp/$name/$i/  2>&1 &
    
    echo "$name\t$i\t$mx\tplot created\t`nproc`\t$ram\t$parallel\t$(expr `date +%s` - $start_time) s." >> stat.txt 2>&1
    
done
rm -r $tmp/$name/ &
fg
fg
fg
