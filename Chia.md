
```sh
sudo apt-get update
sudo apt-get upgrade -y

# Install Git
sudo apt install git -y
git clone https://github.com/Chia-Network/chia-blockchain.git -b latest --recurse-submodules
cd chia-blockchain

sh install.sh

. ./activate


```

```sh
sudo mkfs.ext4 -m 0 -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/sdb
sudo mkfs.ext4 -m 0 -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/sdc

sudo lsblk

sudo cp /etc/fstab /etc/fstab.backup
sudo blkid /dev/

```


## Copy private key
https://github.com/Chia-Network/chia-blockchain/wiki/Moving-plots

```sh
chia keys show --show-mnemonic-seed
```

```
chia keys add
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
for i in `seq 0 400`
do
    echo "$i"
    sudo mkdir /mnt/tmp/$i
    start_time=`date +%s`
    chia plots create -k 32 -n 1 -b 3000 -t /mnt/tmp/ -d /mnt/final/ -e 
    end_time=`date +%s`
    echo plot create `expr $end_time - $start_time` s.
    
    start_time=`date +%s`
    (gsutil mv -R /mnt/tmp/$i/ gs://bucket/complete/ && echo "upload to storage $i : $(expr `date +%s` - $start_time) s") 2>&1 &
done
sudo shutdown -h
```


