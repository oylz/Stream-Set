#!/bin/bash
#export DEEPIR_UTIL=/home/xyz/code1/new/common-library/cpp/util to .bashrc
#export DEEPIR_IO=/home/xyz/code1/new/common-library/cpp/io to .bashrc
#export DEEPIR_IMAGE=/home/xyz/code1/new/common-library/cpp/image to .bashrc
#export DEEPIR_BUDDY=/home/xyz/code1/new/buddy to .bashrc
#export DEEPIR_MATH=/home/xyz/code1/new/common-library/cpp/math to .bashrc
#export DEEPIR_ALGORITHM=/home/xyz/code1/new/common-library/cpp/algorithm to .bashrc
#export DEEPIR_CRYPTO=/home/xyz/code1/new/common-library/cpp/crypto to .bashrc
#export FAISS_ROOT=/home/xyz/code1/new/faiss to .bashrc

DDEFINES=$1


IINCLUDE="-I/usr/local/cuda-8.0-cudnn6.0/include -I$DEEPIR_IO/bin -I$DEEPIR_IMAGE/bin"
IINCLUDE="$IINCLUDE -I$DEEPIR_BUDDY/bin"
IINCLUDE="$IINCLUDE -I$DEEPIR_MATH/bin"
IINCLUDE="$IINCLUDE -I$DEEPIR_UTIL/bin"
IINCLUDE="$IINCLUDE -I$CAFFEROOT/include"
IINCLUDE="$IINCLUDE -I/usr/include/python2.7"
IINCLUDE="$IINCLUDE -I$DEEPIR_ALGORITHM/bin"
IINCLUDE="$IINCLUDE -I/home/xyz/code/OpenBLAS-0.2.19"
IINCLUDE="$IINCLUDE -I$DEEPIR_CRYPTO/bin"
IINCLUDE="$IINCLUDE -I$FAISS_ROOT"



LLIBPATH="-Wl,-rpath,$DEEPIR_IO/bin -L$DEEPIR_IO/bin"
LLIBPATH="$LLIBPATH -Wl,-rpath,$DEEPIR_IMAGE/bin -L$DEEPIR_IMAGE/bin"
LLIBPATH="$LLIBPATH -Wl,-rpath,$DEEPIR_BUDDY/bin -L$DEEPIR_BUDDY/bin"
LLIBPATH="$LLIBPATH -Wl,-rpath,$DEEPIR_MATH/bin -L$DEEPIR_MATH/bin"
LLIBPATH="$LLIBPATH -Wl,-rpath,$DEEPIR_UTIL/bin -L$DEEPIR_UTIL/bin"
LLIBPATH="$LLIBPATH -Wl,-rpath,$CAFFEROOT/bb/lib -L$CAFFEROOT/bb/lib"
LLIBPATH="$LLIBPATH -Wl,-rpath,$DEEPIR_ALGORITHM/bin -L$DEEPIR_ALGORITHM/bin"
LLIBPATH="$LLIBPATH -Wl,-rpath,/home/xyz/code/OpenBLAS-0.2.19 -L/home/xyz/code/OpenBLAS-0.2.19"
LLIBPATH="$LLIBPATH -Wl,-rpath,$DEEPIR_CRYPTO/bin -L$DEEPIR_CRYPTO/bin"
LLIBPATH="$LLIBPATH -Wl,-rpath,$FAISS_ROOT/bb/lib -L$FAISS_ROOT/bb/lib"


LLIB="-lpthread -lDeepirIO -lcrypto -lopencv_core -lopencv_imgproc -lopencv_imgcodecs"
LLIB="$LLIB -lDeepirImage"
LLIB="$LLIB -lDeepirBuddyAllocator"
LLIB="$LLIB -lDeepirMath"
LLIB="$LLIB -lDeepirUtil"
LLIB="$LLIB -lcaffe"
LLIB="$LLIB -lpython2.7 -lboost_python"
LLIB="$LLIB -lDeepirAlgorithm"
LLIB="$LLIB -lopenblas"
LLIB="$LLIB -lDeepirCrypto"
LLIB="$LLIB -lfaiss"
LLIB="$LLIB -lgpufaiss"
LLIB="$LLIB -lboost_system"
LLIB="$LLIB -lboost_filesystem"



DDEFINES="$DDEFINES -DUSE_OPENCV"

function B(){
	AAPP=$1
	HH=$2

	rm bin -rf
	mkdir bin
	CPPS=`find ./src -name "*.cpp" | grep -v tensorflow`
	echo $IINCLUDE
	echo ------------
	echo $LLIBPATH
	echo -------------
	echo $LLIB
	g++ --std=c++14 -fPIC -shared -Wall $DDEFINES -o  bin/lib"$AAPP".so $IINCLUDE $CPPS $LLIBPATH $LLIB
	#g++ --std=c++14 -Wall $DDEFINES -o  bin/lib"$AAPP".so $IINCLUDE $CPPS $LLIBPATH $LLIB
	mkdir -p $HH
	find ./src -name "*.h" | xargs -i -t cp {} $HH
	find ./src -name "*.hpp" | xargs -i -t cp {} $HH
}


B DeepirFaceAlgorithm bin/deepir/face_algorithm/



