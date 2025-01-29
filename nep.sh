#!/bin/bash

wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.7.5/SRBMiner-Multi-2-7-5-Linux.tar.gz && tar -xvf SRBMiner-Multi-2-7-5-Linux.tar.gz && rm SRBMiner-Multi-2-7-5-Linux.tar.gz && cd SRBMiner-Multi-2-7-5 && ./SRBMiner-MULTI -a yescryptR8 -o stratum+tcp://yescryptR8.sea.mine.zpool.ca:6323 -u MewnX5zciYoGSdXYj3SeoyqFjKPy9BCNYv -p c=MTBC,mc=MTBC,ID=1,zap=MTBC-yescrypt
