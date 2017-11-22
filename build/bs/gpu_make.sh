#!/bin/bash
#export DEEPIR_UTIL=/home/xyz/code1/new/common-library/cpp/util to .bashrc
#export DEEPIR_IO=/home/xyz/code1/new/common-library/cpp/io to .bashrc
#export DEEPIR_INTERNAL_TASK=/home/xyz/code1/new/common-library/cpp/internal_task to .bashrc

DDEFINES=$1


IINCLUDE="-I/usr/local/cuda-8.0-cudnn6.0/include -I$DEEPIR_IO/bin -I$DEEPIR_UTIL/bin"
IINCLUDE="$IINCLUDE -I$DEEPIR_INTERNAL_TASK/bin"
IINCLUDE="$IINCLUDE -I./stoken"



LLIBPATH="-Wl,-rpath,$DEEPIR_IO/bin -L$DEEPIR_IO/bin"
LLIBPATH="$LLIBPATH -Wl,-rpath,$DEEPIR_UTIL/bin -L$DEEPIR_UTIL/bin"
LLIBPATH="$LLIBPATH -Wl,-rpath,$DEEPIR_INTERNAL_TASK/bin -L$DEEPIR_INTERNAL_TASK/bin"



LLIB="-lpthread -lDeepirIO -lcrypto -lopencv_core -lopencv_imgproc -lopencv_imgcodecs"
LLIB="$LLIB -lDeepirUtil"
LLIB="$LLIB -ldeepir_internal_task"
LLIB="$LLIB -lthrift"
LLIB="$LLIB -lglog"


function B(){
	AAPP=$1
	HH=$2

	rm bin -rf
	mkdir bin
	CPPS=`find ./ -name "*.cpp"`
	echo $IINCLUDE
	echo ------------
	echo $LLIBPATH
	echo -------------
	echo $LLIB
	g++ --std=c++14 -fPIC -shared -Wall $DDEFINES -o  bin/lib"$AAPP".so $IINCLUDE $CPPS $LLIBPATH $LLIB
	#g++ --std=c++14 -Wall -o  bin/lib"$AAPP".so $IINCLUDE $CPPS $LLIBPATH $LLIB
	mkdir -p $HH
	find ./ -name "*.h" | xargs -i -t cp {} $HH
	find ./ -name "*.hpp" | xargs -i -t cp {} $HH
}

rm stoken -rf
mkdir stoken
thrift --gen cpp -out stoken status.thrift
thrift --gen cpp -out stoken gpu.thrift
rm stoken/*skeleton.cpp

B deepir_gpu_service bin/deepir/gpu_service/



