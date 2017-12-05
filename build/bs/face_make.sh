#!/bin/bash
#export DEEPIR_UTIL=/home/xyz/code1/new/common-library/cpp/util to .bashrc
#export DEEPIR_IO=/home/xyz/code1/new/common-library/cpp/io to .bashrc
#export DEEPIR_INTERNAL_TASK=/home/xyz/code1/new/common-library/cpp/internal_task to .bashrc

#export DEEPIR_MATH=/home/xyz/code1/new/common-library/cpp/math to .bashrc
#export DEEPIR_IMAGE=/home/xyz/code1/new/common-library/cpp/image to .bashrc
#export DEEPIR_GPU_SERVICE=/home/xyz/code1/new/internalservice/gpu to .bashrc
#export DEEPIR_FACE_ALGORITHM=/home/xyz/code1/new/face-algorithm to .bashrc
#export DEEPIR_ALGORITHM=/home/xyz/code1/new/common-library/cpp/algorithm


DDEFINES=$1


IINCLUDE="-I/usr/local/cuda-8.0-cudnn6.0/include -I$DEEPIR_IO/bin -I$DEEPIR_UTIL/bin"
IINCLUDE="$IINCLUDE -I$DEEPIR_INTERNAL_TASK/bin"
IINCLUDE="$IINCLUDE -I./stoken"
IINCLUDE="$IINCLUDE -I$DEEPIR_MATH/bin"
IINCLUDE="$IINCLUDE -I$DEEPIR_IMAGE/bin"
IINCLUDE="$IINCLUDE -I$DEEPIR_GPU_SERVICE/bin"
IINCLUDE="$IINCLUDE -I$DEEPIR_FACE_ALGORITHM/bin"
IINCLUDE="$IINCLUDE -I$CAFFEROOT/include"
IINCLUDE="$IINCLUDE -I$DEEPIR_ALGORITHM/bin"



LLIBPATH="-Wl,-rpath,$DEEPIR_IO/bin -L$DEEPIR_IO/bin"
LLIBPATH="$LLIBPATH -Wl,-rpath,$DEEPIR_UTIL/bin -L$DEEPIR_UTIL/bin"
LLIBPATH="$LLIBPATH -Wl,-rpath,$DEEPIR_INTERNAL_TASK/bin -L$DEEPIR_INTERNAL_TASK/bin"
LLIBPATH="$LLIBPATH -Wl,-rpath,$DEEPIR_MATH/bin -L$DEEPIR_MATH/bin"
LLIBPATH="$LLIBPATH -Wl,-rpath,$DEEPIR_IMAGE/bin -L$DEEPIR_IMAGE/bin"
LLIBPATH="$LLIBPATH -Wl,-rpath,$DEEPIR_GPU_SERVICE/bin -L$DEEPIR_GPU_SERVICE/bin"
LLIBPATH="$LLIBPATH -Wl,-rpath,$DEEPIR_FACE_ALGORITHM/bin -L$DEEPIR_FACE_ALGORITHM/bin"
LLIBPATH="$LLIBPATH -Wl,-rpath,$CAFFEROOT/bb/lib -L$CAFFEROOT/bb/lib"
LLIBPATH="$LLIBPATH -Wl,-rpath,$DEEPIR_ALGORITHM/bin -L$DEEPIR_ALGORITHM/bin"




LLIB="-lpthread -lDeepirIO -lcrypto -lopencv_core -lopencv_imgproc -lopencv_imgcodecs"
LLIB="$LLIB -lDeepirUtil"
LLIB="$LLIB -ldeepir_internal_task"
LLIB="$LLIB -lthrift"
LLIB="$LLIB -lthriftnb"
LLIB="$LLIB -lglog"
LLIB="$LLIB -lDeepirMath"
LLIB="$LLIB -lDeepirImage"
LLIB="$LLIB -ldeepir_gpu_service"
LLIB="$LLIB -lDeepirFaceAlgorithm"
LLIB="$LLIB -lcaffe"
LLIB="$LLIB -lDeepirAlgorithm"
LLIB="$LLIB -lgflags"
LLIB="$LLIB -lsqlite3"
LLIB="$LLIB -lboost_serialization"
LLIB="$LLIB -levent"


DDEFINES="$DDEFINES -DUSE_OPENCV"


function B(){
	AAPP=$1

	rm bin -rf
	mkdir bin
	CPPS=`find ./ -name "*.cpp"`
	echo $IINCLUDE
	echo ------------
	echo $LLIBPATH
	echo -------------
	echo $LLIB
	g++ --std=c++14 -Wall $DDEFINES -o  bin/$AAPP $IINCLUDE $CPPS $LLIBPATH $LLIB
}

cp ../gpu/status.thrift ./
cp ../gpu/gpu.thrift ./

rm stoken -rf
mkdir stoken
thrift --gen cpp -out stoken status.thrift
thrift --gen cpp -out stoken gpu.thrift
thrift --gen cpp -out stoken face.thrift
rm stoken/*skeleton.cpp
rm status.thrift gpu.thrift


B face_server



