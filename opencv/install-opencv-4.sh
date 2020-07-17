DEPS_DIR="$1"
if [[ $DEPS_DIR == "" ]]; then exit 1; fi
INSTALL_DIR="$DEPS_DIR/opencv"

#para Python: -D BUILD_PYTHON_SUPPORT=ON
#sudo apt-get install python-dev python-numpy

#para TBB: -D WITH_TBB=ON
#sudo apt-get install libtbb-dev

#para TBB: -D WITH_EIGEN=ON
#sudo apt-get install libeigen3-dev

#para ventanas GTK: -D WITH_GTK=ON
#sudo apt-get install libgtk2.0-dev
#para ventanas QT: -D WITH_QT=ON
#sudo apt-get install libqt4-dev

#para otros modulos
#sudo apt-get install libdc1394-22-dev libxine-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev libtiff4-dev libjpeg-dev libjasper-dev
#sudo pat-get install tesseract-ocr-dev
#/opt/opencv/release$ cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D OPENCV_EXTRA_MODULES_PATH=/opt/opencv_contrib/modules ..

OPT=""
OPT="$OPT -D BUILD_SHARED_LIBS=ON"
OPT="$OPT -D WITH_VTK=OFF"
OPT="$OPT -D BUILD_TESTS=OFF"
OPT="$OPT -D BUILD_TBB=ON"
OPT="$OPT -D BUILD_PYTHON_SUPPORT=ON"
OPT="$OPT -D BUILD_OPENCV_PYTHON=ON"
OPT="$OPT -D BUILD_TIFF=ON"
#----defining specific python libs
OPT="$OPT -D PYTHON3_EXECUTABLE=$HOME/anaconda3/bin/python3" 
OPT="$OPT -D PYTHON3_INCLUDE_DIR=$HOME/anaconda3/include/python3.6m" 
OPT="$OPT -D PYTHON3_LIBRARY=$HOME/anaconda3/lib/libpython3.6m.so" 
OPT="$OPT -D PYTHON2_INCLUDE_DIR=/usr/include/python2.7" 
OPT="$OPT -D BUILD_opencv_python3=yes"
#-----------------------------------
OPT="$OPT -D BUILD_EXAMPLES=ON"
OPT="$OPT -D WITH_FFMPEG=ON"
OPT="$OPT -D WITH_GTK=ON"
OPT="$OPT -D WITH_GTK3=ON"
OPT="$OPT -D WITH_OPENMP=ON"
#---------------------- CUDA
OPT="$OPT -D CUDA_GENERATION=Auto"
OPT="$OPT -D WITH_CUDA=ON"
OPT="$OPT -D BUILD_opencv_cudacodec=OFF"
OPT="$OPT -D WITH_CUBLAS=ON"
#---defining cuda directory
OPT="$OPT -D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda"
#----------------------
OPT="$OPT -D BUILD_EXAMPLES=ON"
#----------------------
OPT="$OPT -D WITH_QT=OFF"
OPT="$OPT -D WITH_OPENGL=ON"
OPT="$OPT -D ENABLE_FAST_MATH=1"
#OPT="$OPT -D CUDA_FAST_MATH=1"
OPT="$OPT -D WITH_CUBLAS=1"
#----------------------
OPT="$OPT -DWITH_IPP=ON"
OPT="$OPT -D WITH_EIGEN=ON"
OPT="$OPT -D WITH_1394=OFF"
OPT="$OPT -D WITH_LIBV4L=ON"
OPT="$OPT -D INSTALL_C_EXAMPLES=ON"
OPT="$OPT -D INSTALL_PYTHON_EXAMPLES=ON"
OPT="$OPT -D CMAKE_BUILD_TYPE=RELEASE"
OPT="$OPT -D CMAKE_VERBOSE=ON"
OPT="$OPT -D CMAKE_VERBOSE_MAKEFILE=ON"
OPT="$OPT -DBUILD_opencv_cnn_3dobj=OFF"
#---- compliling opencv4 with c++11
OPT="$OPT -DCMAKE_CXX_FLAGS=-std=c++11"
OPT="$OPT -DCUDA_PROPAGATE_HOST_FLAGS=off" 
#---- to produce *.pc file
OPT="$OPT -DOPENCV_GENERATE_PKGCONFIG=YES"
version="4.1.0"
filename="${version}.zip"
dirname="opencv-${version}"
dirname_extra="opencv_contrib-${version}"

if [[ ! -f "$filename" ]]; then
        wget "https://github.com/opencv/opencv/archive/$filename"
        if [[ $? != 0 ]]; then exit 1; fi
fi
if [[ ! -d "$dirname" ]]; then
        unzip "$filename"
        #unzip "$filename" -d opencv-static
        if [[ $? != 0 ]]; then exit 1; fi
fi
#download opencv contribs
if [[ ! -f "${dirname_extra}".zip ]]; then
        wget https://github.com/opencv/opencv_contrib/archive/${version}.zip -O ${dirname_extra}.zip
        if [[ $? != 0 ]]; then exit 1; fi
fi
if [[ ! -d "${dirname_extra}" ]]; then
        unzip "${dirname_extra}".zip
        if [[ $? != 0 ]]; then exit 1; fi
fi
#in order to work in ubuntu 16.04 due to a new version of gcc 
#ya esta incluido
#sed '11i set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D_FORCE_INLINES")' -i  ${dirname}/CMakeLists.txt && \
current=`pwd` && \
OPT="$OPT -D OPENCV_EXTRA_MODULES_PATH=${current}/${dirname_extra}/modules"
cd "$dirname" && \
mkdir -p build && \
cd build && \
cmake -D "CMAKE_INSTALL_PREFIX=$INSTALL_DIR" $OPT .. && \
make -j 12 && \
make install && \
cd "$current" && \
#modifying opencv.pc to include cuda libs
if [[ -d /usr/local/cuda && ! -d ${CUDA_HOME} ]]; then
        CUDA_HOME=/usr/local/cuda
fi && \
if [[ -d ${CUDA_HOME} ]]; then
        CUDA_LIBS="-L${CUDA_HOME}/lib64 -Wl,-rpath,${CUDA_HOME}"
        CUDA_INCLUDE="-I${CUDA_HOME}/include"
fi && \
for file in "$INSTALL_DIR"/lib/pkgconfig/*.pc; do
	sed  -e "s#^Libs:\(.*\)\$#Libs:  \1 ${CUDA_LIBS} -Wl,-rpath,\${libdir}#" -i  $file && \
  	sed  -e "s#^\(Cflags:.*\)\$#\1 ${CUDA_INCLUDE}#" -i $file  
done && \
echo ok

