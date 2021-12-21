# Firo Mining

## Miner

### Firo Official miner
https://github.com/firoorg/firominer

```sh
#Dashboard at https://mintpond.com/#!/firo:aB4Hq55j9fCq1b5KyyFMiPGyucznCZLohs
./firominer \
 -P stratum+tcp://aB4Hq55j9fCq1b5KyyFMiPGyucznCZLohs.rtx2080ti:1@firo.mintpond.com:3000 \
 --cu-schedule auto \
 --HWMON 2 \
 -R
```

### T-Rex
https://t-rex.tileserver.ch/doc/setup/

```sh
./t-rex -a firopow -o stratum+tcp://firo.mintpond.com:3000 -u aB4Hq55j9fCq1b5KyyFMiPGyucznCZLohs.trexrtx2080ti -p 1
```

## Guide
https://firo.org/guide/how-to-mine-firo.html


## Use Docker
```sh
docker run -tid \
--gpus all \
--name firo-official \
-v /mnt/c/firo/:/firo/ \
-w /firo \
 nvidia/cuda:11.4.2-runtime-ubuntu20.04
```


```sh
docker run -tid \
--gpus all \
--name firo-t-rex \
-v /mnt/c/firo/:/firo/ \
-w /firo \
 nvidia/cuda:11.4.2-runtime-ubuntu20.04
```