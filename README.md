# Crypto Mining
Guideline for Cryptominer installation in Computer


## Ubuntu with Docker

### Ubuntu Docker
```sh
export NAME="cuda-miner"
docker run -itd \
    --name $NAME  --net=host\
    -v /mnt/b/miner/:/miner/  -w /miner --privileged \
    -e HOST_PERMS="$(id -u):$(id -g)" \
    ethereum/client-go:alltools-latest
```

### NVIDIA Docker

#### Create CUDA Container
- Checkout CUDA version at [NVIDIA/CUDA Docker Hub](https://hub.docker.com/r/nvidia/cuda/tags)
```sh
export NAME="cuda-miner"
docker run --runtime=nvidia --gpus all -itd \
    --name $NAME  --net=host\
    -v /mnt/b/miner/:/miner/  -w /miner --privileged \
    -e HOST_PERMS="$(id -u):$(id -g)" \
    nvidia/cuda:10.1-cudnn7-runtime-ubuntu18.04 bash 
```


### Ethminer Ethereum
- CPU, NVIDIA GPU, AMD GPU
- Download at [Github](https://github.com/ethereum-mining/ethminer/releases)

```sh
./ethminer \
  -P stratum+tcp://ubnteth.001:123456@ethash.poolbinance.com:1800\
 -P stratum+tcp://ubnteth.001:123456@ethash.poolbinance.com:443 \
 -P stratum+tcp://ubnteth.001:123456@ethash.poolbinance.com:25 \
  --HWMON 2 \
--cu-block-size 256 \
--cu-grid-size 8192 \
--cu-streams 24 \
--cu-schedule auto 

```

### CPU Miner

```sh
docker run -it --rm --name cpuminer --net=host --privileged -e HOST_PERMS="$(id -u):$(id -g)" cpuminer   \
 --url stratum+tcp://ltc.poolbinance.com:443 \
 --user ubntscrpyt.001 --pass 123456
```


- https://github.com/pooler/cpuminer
- https://www.awesomeminer.com/algorithm/scrypt
- CGMiner
- CCMiner


## XMRIG
```sh
./xmrig --cuda --cuda-loader=libxmrig-cuda.so --no-cpu \
-o kp.unmineable.com:3333 \
-a kawpow \
-u CAKE:0xfe80650bf12fb5b55f96eaa594e808aa9481da40.RTX2080Ti#q8xd-bq8c \
-p x -k
```
```sh
./xmrig-cpu -a rx \
-o stratum+ssl://rx.unmineable.com:443 \
-u CAKE:0xfe80650bf12fb5b55f96eaa594e808aa9481da40.RTX2080Ti#q8xd-bq8c \
-p x -k
```

ethash.unmineable.com:3333
ethash.unmineable.com:13333

etchash.unmineable.com:3333
etchash.unmineable.com:13333

kp.unmineable.com:3333
kp.unmineable.com:13333

rx.unmineable.com:3333
rx.unmineable.com:13333