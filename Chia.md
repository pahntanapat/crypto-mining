

## Install Chia
```sh
sudo apt-get update && \
    sudo apt-get upgrade -y && \
    sudo apt install git screen -y

git clone https://github.com/Chia-Network/chia-blockchain.git -b latest --recurse-submodules
cd chia-blockchain

sh install.sh

. ./activate


```



## Copy private key
https://github.com/Chia-Network/chia-blockchain/wiki/Moving-plots

```sh
chia keys show --show-mnemonic-seed
```

```
chia init
chia keys add

chmod 0644 mozilla-ca/cacert.pem
chia start node
```

## Chia Plot

```sh
chia plots create -k 32 -n 1 -b 3000 -t /mnt/tmp/ -d /mnt/final/ -e 
```

## Loop command

```sh
. ./chia-blockchain/activate
name="`date +%Y-%m-%dT%H-%M-%S.%NZ`" #  0/#date

tmp="/mnt/b"
final="/media/pahn/1blackSanDisk"
mx=5

mkdir -m 777 -p $tmp/$name/

ram=16384
parallel=2
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

```


```sh
. ./chia-blockchain/activate
name="`date +%Y-%m-%dT%H-%M-%S.%NZ`" #  0/#date

tmp="/mnt/d"
final="/media/pahn/2blackSandisk"
mx=5

mkdir -m 777 -p $tmp/$name/

ram=4096
parallel=16

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

```

## Compare result

 RAM (GB) | No. Parallel Plot | time 
 --|--|--
 1 | 1 | ... 