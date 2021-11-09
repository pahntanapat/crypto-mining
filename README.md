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


- https://github.com/pooler/cpuminer
- https://www.awesomeminer.com/algorithm/scrypt
- CGMiner
- CCMiner
