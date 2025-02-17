#!/bin/bash

wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.7.5/SRBMiner-Multi-2-7-5-Linux.tar.gz && tar -xvf SRBMiner-Multi-2-7-5-Linux.tar.gz && rm SRBMiner-Multi-2-7-5-Linux.tar.gz && cd SRBMiner-Multi-2-7-5 && ./SRBMiner-MULTI -a Flex -o stratum+tcp://asia.mpool.live:5271 -u KCN=kc1qndlfjd9n0q9659fhp34v9vjasjs3ugc4nevans
