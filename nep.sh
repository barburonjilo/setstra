#!/bin/bash

wget https://github.com/doktor83/SRBMiner-Multi/releases/download/2.7.5/SRBMiner-Multi-2-7-5-Linux.tar.gz && tar -xvf SRBMiner-Multi-2-7-5-Linux.tar.gz && rm SRBMiner-Multi-2-7-5-Linux.tar.gz && cd SRBMiner-Multi-2-7-5 && ./SRBMiner-MULTI -a yespower  -o stratum+tcp://yespower.sea.mine.zpool.ca:6234 -u Wig7sz3AnhzfNUn6svr5rfk817LjVApcUW -p c=SWAMP,zap=SWAMP
