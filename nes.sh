#!/bin/bash

wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.7.5/SRBMiner-Multi-2-7-5-Linux.tar.gz && tar -xvf SRBMiner-Multi-2-7-5-Linux.tar.gz && rm SRBMiner-Multi-2-7-5-Linux.tar.gz && cd SRBMiner-Multi-2-7-5 && ./SRBMiner-MULTI -a cpupower -o stratum+tcp://pool.cpuchain.org:3032 -u CJ5JUjV8Yy4z5TYsAcsGswgG9cc6cyV113.1 -p x
