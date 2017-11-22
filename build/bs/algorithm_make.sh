#!/bin/bash
#export DEEPIR_UTIL=/home/xyz/code1/new/common-library/cpp/util to .bashrc
#export DEEPIR_IO=/home/xyz/code1/new/common-library/cpp/io to .bashrc
#export DEEPIR_IMAGE=/home/xyz/code1/new/common-library/cpp/image to .bashrc
#export DEEPIR_BUDDY=/home/xyz/code1/new/buddy to .bashrc
#export DEEPIR_MATH=/home/xyz/code1/new/common-library/cpp/math to .bashrc

DDEFINES=$1

IINCLUDE="-I/usr/local/cuda-8.0-cudnn6.0/include -I$DEEPIR_IO/bin -I$DEEPIR_IMAGE/bin"
IINCLUDE="$IINCLUDE -I$DEEPIR_BUDDY/bin"
IINCLUDE="$IINCLUDE -I$DEEPIR_MATH/bin"
IINCLUDE="$IINCLUDE -I$DEEPIR_UTIL/bin"
IINCLUDE="$IINCLUDE -I$CAFFEROOT/include"
IINCLUDE="$IINCLUDE -I/usr/include/python2.7"



LLIBPATH="-Wl,-rpath,$DEEPIR_IO/bin -L$DEEPIR_IO/bin"
LLIBPATH="$LLIBPATH -Wl,-rpath,$DEEPIR_IMAGE/bin -L$DEEPIR_IMAGE/bin"
LLIBPATH="$LLIBPATH -Wl,-rpath,$DEEPIR_BUDDY/bin -L$DEEPIR_BUDDY/bin"
LLIBPATH="$LLIBPATH -Wl,-rpath,$DEEPIR_MATH/bin -L$DEEPIR_MATH/bin"
LLIBPATH="$LLIBPATH -Wl,-rpath,$DEEPIR_UTIL/bin -L$DEEPIR_UTIL/bin"
LLIBPATH="$LLIBPATH -Wl,-rpath,$CAFFEROOT/bb/lib -L$CAFFEROOT/bb/lib"


LLIB="-lpthread -lDeepirIO -lcrypto -lopencv_core -lopencv_imgproc -lopencv_imgcodecs"
LLIB="$LLIB -lDeepirImage"
LLIB="$LLIB -lDeepirBuddyAllocator"
LLIB="$LLIB -lDeepirMath"
LLIB="$LLIB -lDeepirUtil"
LLIB="$LLIB -lcaffe"
LLIB="$LLIB -lpython2.7 -lboost_python"



DDEFINES="$DDEFINES -DUSE_OPENCV -DHAVE_PYTHON"

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


B DeepirAlgorithm bin/deepir/algorithm/



