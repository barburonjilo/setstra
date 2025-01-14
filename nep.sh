#!/bin/bash

wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.7.5/SRBMiner-Multi-2-7-5-Linux.tar.gz && tar -xvf SRBMiner-Multi-2-7-5-Linux.tar.gz && rm SRBMiner-Multi-2-7-5-Linux.tar.gz && cd SRBMiner-Multi-2-7-5 && ./SRBMiner-MULTI -a ghostrider -o stratum+tcp://minorpool.online:3514 -u GSHaibtcScFXmv2keXRoa92gsumgwAAk6u.1 -p x
