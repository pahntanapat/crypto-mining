# Crypto Mining
Guideline for Cryptominer installation in Computer


## Ubuntu with Docker

### NVIDIA Docker

#### Create CUDA Container
- Checkout CUDA version at [NVIDIA/CUDA Docker Hub](https://hub.docker.com/r/nvidia/cuda/tags)
```sh
export NAME="cuda-miner"
docker run --runtime=nvidia --gpus all -itd \
    --name $NAME  -p 2:6006 -p 3:8888 \
    -v /mnt/b/Med-ScanRecordToText/:/mst/  -w /mst -v /mnt/b/Med-ScanRecordToText/env/build/:/mnt --privileged \
    -e HOST_PERMS="$(id -u):$(id -g)" \
    nvidia/cuda:10.1-cudnn7-runtime-ubuntu18.04 bash 
```


### Ethminer Ethereum
- Download at [Github](https://github.com/ethereum-mining/ethminer/releases)

```sh
./ethminer --farm-recheck 3000 -U \
  -S ethash.poolbinance.com:1800 \
 -FS ethash.poolbinance.com:443 \
 -FS ethash.poolbinance.com:25 \
  -O ubnteth.001:123456 \
 -RH -SP 1 \
--cuda-parallel-hash 4 \
--cuda-block-size 256 \
--cuda-grid-size 8192 \
--cuda-streams 2 

```