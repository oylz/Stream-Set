#!/bin/bash



PPATH=`pwd`

DDEFINES="-DCAFFE_DIR=$CAFFEROOT -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-8.0-cudnn6.0 -DBLAS=/home/xyz/code/OpenBLAS"

echo $DDEFINES
rm $CAFFEROOT/include/caffe/proto -rf
ln -s $CAFFEROOT/bb/include/caffe/proto $CAFFEROOT/include/caffe/proto


function BUILD(){
	SPATH=$1
	SFILE=$2

	echo "================now begin build $SPATH====================="
	cd $PPATH
	cp bs/"$SFILE"_make.sh $SPATH/make.sh

	cd $SPATH
	rm bin -rf
	#./make.sh "-ggdb -DHAVE_GPU_MAT -DHAVE_PYTHON -DHAVE_CUDA -DNEWATTRNET"
	./make.sh "-DHAVE_GPU_MAT -DHAVE_PYTHON -DHAVE_CUDA -DNEWATTRNET"
	S=$?
	if [  $S -gt 0  ] 
	then
		echo "=====build error, exit======================"
		exit
	fi
}



function DELETE(){
	SPATH=$1
	rm $SPATH/bin -rf	
}


#delete
DELETE buddy

DELETE common-library/cpp/util
DELETE common-library/cpp/io
DELETE common-library/cpp/crypto
DELETE common-library/cpp/image
DELETE common-library/cpp/dedup
DELETE common-library/cpp/math
DELETE common-library/cpp/network
DELETE common-library/cpp/algorithm
DELETE common-library/cpp/internal_task


DELETE face-algorithm

DELETE internalservice/gpu

DELETE internalservice/face




#build



BUILD buddy buddy

BUILD common-library/cpp/util util
BUILD common-library/cpp/io io
BUILD common-library/cpp/crypto crypto
BUILD common-library/cpp/image image
BUILD common-library/cpp/dedup dedup
BUILD common-library/cpp/math math
BUILD common-library/cpp/network network
BUILD common-library/cpp/algorithm algorithm
BUILD common-library/cpp/internal_task internal_task



BUILD face-algorithm face-algorithm

BUILD internalservice/gpu gpu

BUILD internalservice/face face








