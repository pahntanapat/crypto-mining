
```sh
sudo mkfs.ext4 -m 0 -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/sdb
sudo mkfs.ext4 -m 0 -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/nvme0n4 &

sudo lsblk

sudo cp /etc/fstab /etc/fstab.backup
sudo blkid /dev/


# UUID=----UUID--HERE-------- /mnt/nv ext4 discard,defaults,defaults 0 2
sudo echo "/dev/nvme0n1 /mnt/nv ext4 discard,defaults,defaults 0 2" >> /etc/fstab
cat /etc/fstab
```
```
/dev/nvme0n4 /mnt/nv/0 ext4 discard,defaults,defaults 0 2
/dev/nvme0n1 /mnt/nv/1 ext4 discard,defaults,defaults 0 2
/dev/nvme0n2 /mnt/nv/2 ext4 discard,defaults,defaults 0 2
/dev/nvme0n3 /mnt/nv/3 ext4 discard,defaults,defaults 0 2
```

## Mount Drive
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

## Command time usage
https://stackoverflow.com/questions/1656425/print-execution-time-of-a-shell-command
```sh
start_time=`date +%s`

end_time=`date +%s`
echo execution time was `expr $end_time - $start_time` s.
```

## Move file to GCP bucket
https://cloud.google.com/storage/docs/gsutil/commands/mv
```sh
gsutil mv -R . gs://bucket/complete/
```

## All of command
```sh
. ./activate
. ./chia-blockchain/activate
ram=4096
name="0/`date +%Y-%m-%dT%H-%M-%S.%NZ`" #  0/#date

tmp="/mnt/nv/tmp"
final="/mnt/nv/final"
storage="gs://ch-us-west-1/$name/"

sudo mkdir -m 777 -p $tmp/$name/

for i in `seq 0 2`
do
    echo "$i"
    sudo mkdir -m 777 -p $final/$name/$i/
    sudo mkdir -m 777 -p $tmp/$name/$i/
    start_time=`date +%s`

    chia plots create -k 32 -n 1 -r `nproc` -b $ram -t $tmp/$name/ -d $final/$name/$i/ -e 
    sudo rm -r  $tmp/$name/$i/  2>&1 &
    
    echo "$name/$i\tplot created\t`nproc`\t$ram\t$(expr `date +%s` - $start_time) s." >> $final/$name/stat.txt 2>&1
    
    start_time=`date +%s`
    (sudo gsutil -o GSUtil:parallel_composite_upload_threshold=150M  mv -R $final/$name/$i/ $storage && \
        echo "uploaded to storage $name/$i : $(expr `date +%s` - $start_time) s") >> $final/$name/stat.txt 2>&1 &
done
sudo gsutil -o GSUtil:parallel_composite_upload_threshold=150M  mv $final/$name/stat.txt $storage
sudo rm -r $tmp/$name/
sudo rm -r $final/$name/
fg
fg
fg
sudo shutdown -h
```

```sh
. ./activate
. ./chia-blockchain/activate
ram=4096
name="`date +%Y-%m-%dT%H-%M-%S.%NZ`" #  0/#date

tmp="/mnt/nv2/tmp"
final="/mnt/nv2/final"
storage="gs://ch-us-west-1/$name/"
parallel=1

sudo mkdir -m 777 -p $tmp/$name/

for i in `seq 0 2`
do
    echo "$i"
    sudo mkdir -m 777 -p $final/$name/$i/
    sudo mkdir -m 777 -p $tmp/$name/$i/
    start_time=`date +%s`

    chia plots create -k 32 -n 1 -r $parallel -b $ram -t $tmp/$name/ -d $final/$name/$i/ -e 
    sudo rm -r  $tmp/$name/$i/  2>&1 &
    
    echo "$name/$i\tplot created\t`nproc`\t$ram\t$(expr `date +%s` - $start_time) s." >> $final/$name/stat.txt 2>&1
    
    start_time=`date +%s`
    (sudo gsutil -o GSUtil:parallel_composite_upload_threshold=150M  mv -R $final/$name/$i/ $storage && \
        echo "uploaded to storage $name/$i : $(expr `date +%s` - $start_time) s") >> $final/$name/stat.txt 2>&1 &
done
sudo rm -r $tmp/$name/ &
sudo gsutil -o GSUtil:parallel_composite_upload_threshold=150M  mv $final/$name/stat.txt $storage
sudo rm -r $final/$name/ &
fg
fg
fg
#sudo shutdown -h
exit
```




```sh
. ./chia-blockchain/activate
. ./activate
ram=3840
name="`date +%Y-%m-%dT%H-%M-%S.%NZ`" #  0/#date

tmp="/mnt/nv/tmp"
final="/mnt/nv/final"
storage="gs://ch-us-west-1/$name/"
parallel=1

# sudo mkdir -m 777 -p $tmp/$name/

for i in `seq 1 1000`
do
    mod=`expr $i % $(nproc)`
    echo "$mod/$i"
    
    tmp="/mnt/nv/$mod/tmp"
    final="/mnt/nv/$mod/final"
    sudo mkdir -m 777 -p $final/$name/$i/
    sudo mkdir -m 777 -p $tmp/$name/$i/
    echo $final/$name/$i/
    echo $tmp/$name/$i/
    start_time=`date +%s`

    if [ `expr $i % $(nproc)` -eq 0 ]
    then
        # do something
        chia plots create -k 32 -n 1 -r $parallel -b $ram -t $tmp/$name/$i/ -d $final/$name/$i/ -e -x
    
        echo "$name/$i\tplot created\t`nproc`\t$ram\t$(expr `date +%s` - $start_time) s." >> /mnt/stat.txt 2>&1
    
        start_time=`date +%s`
        (sudo gsutil -o GSUtil:parallel_composite_upload_threshold=150M  mv -R $final/$name/$i/ $storage && \
            echo "uploaded to storage $name/$i : $(expr `date +%s` - $start_time) s") >> /mnt/stat.txt 2>&1 &
        sudo rm -r  $tmp/$name/$i/  2>&1 &
    else
        (chia plots create -k 32 -n 1 -r $parallel -b $ram -t $tmp/$name/$i/ -d $final/$name/$i/ -e -x >> $final/$name/$i/log.txt) && \
            (echo "$name/$i\tplot created\t`nproc`\t$ram\t$(expr `date +%s` - $start_time) s." >> /mnt/stat.txt) && \
            start_time=`date +%s` && \
            ( (sudo gsutil -o GSUtil:parallel_composite_upload_threshold=150M  mv -R $final/$name/$i/ $storage && \
                echo "uploaded to storage $name/$i : $(expr `date +%s` - $start_time) s") >> /mnt/stat.txt 2>&1 & ) && \
            (sudo rm -r  $tmp/$name/$i/) 2>&1 &
    fi

    
    
done
sudo gsutil -o GSUtil:parallel_composite_upload_threshold=150M  mv /mnt/stat.txt $storage
sudo rm -r $tmp/$name/
sudo rm -r $final/$name/
fg
fg
fg
sudo shutdown -h
# exit
```


## Plot in local machine

```sh
. ./activate
. ./chia-blockchain/activate
ram=8192
name="`date +%Y-%m-%dT%H-%M-%S.%NZ`" #  0/#date

tmp="/mnt/b"
final="/media/pahn/1blackSanDisk"
parallel=1
mx=5

sudo mkdir -m 777 -p $tmp/$name/

for i in `seq 0 $mx`
do
    echo "$i"
    sudo mkdir -m 777 -p $final/$name/$i/
    sudo mkdir -m 777 -p $tmp/$name/$i/
    start_time=`date +%s`

    chia plots create -k 32 -n 1 -r $parallel -b $ram -t $tmp/$name/ -d $final/$name/$i/ -e 
    sudo rm -r  $tmp/$name/$i/  2>&1 &
    
    echo "$name\t$i\t$mx\tplot created\t`nproc`\t$ram\t$parallel\t$(expr `date +%s` - $start_time) s." >> stat.txt 2>&1
    
done
sudo rm -r $tmp/$name/ &
fg
fg
fg
#sudo shutdown -h
exit
```


## Exp

Temp: Local SSD
Final: Same, Cross, Another Local, Standard, Balance, SSD


vCPU | RAM | No. Parallel Plot | Final disk | price | time | %CPU
2 | 4 | 1 | same | $83.52 | ... | %

