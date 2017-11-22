#!/bin/bash


DDEFINES=$1


IINCLUDE="-I/usr/local/cuda-8.0-cudnn6.0/include"
LLIBPATH=""
LLIB="-lpthread"
DDEFINES="$DDEFINES -DHAVE_CUDA"


echo "DDEFINES:"$DDEFINES

function B(){
	AAPP=$1
	HH=$2

	rm bin -rf
	mkdir bin
	CPPS=`find ./src -name "*.cpp"`
	g++ --std=c++14 -fPIC -shared -Wall $DDEFINES -o  bin/lib"$AAPP".so $IINCLUDE $CPPS $LLIBPATH $LLIB
	#g++ --std=c++14 -Wall -o  bin/lib"$AAPP".so $IINCLUDE $CPPS $LLIBPATH $LLIB
	mkdir -p $HH
	find ./src -name "*.h" | xargs -i -t cp {} $HH
	find ./src -name "*.hpp" | xargs -i -t cp {} $HH
}


B DeepirUtil bin/deepir/util/
