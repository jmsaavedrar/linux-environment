DEPS_DIR="$1"
if [[ $DEPS_DIR == "" ]]; then exit 1; fi
INSTALL_DIR="$DEPS_DIR/flann"

#sudo apt-get install cmake libhdf5-dev

filename="flann-1.8.4-src.zip"
dirname="${filename/.zip/}"

if [[ ! -f "$filename" ]]; then
	wget "http://www.cs.ubc.ca/research/flann/uploads/FLANN/$filename"
	if [[ $? != 0 ]]; then exit 1; fi
fi
if [[ ! -d "$dirname" ]]; then
	unzip "$filename"
	if [[ $? != 0 ]]; then exit 1; fi
fi


OPT=""
OPT="$OPT -D BUILD_PYTHON_BINDINGS=ON"
OPT="$OPT -D BUILD_MATLAB_BINDINGS=OFF"
OPT="$OPT -D BUILD_CUDA_LIB=OFF"
OPT="$OPT -D BUILD_C_BINDINGS=ON"
OPT="$OPT -D USE_OPENMP=ON"
OPT="$OPT -D CMAKE_BUILD_TYPE=RELEASE"
OPT="$OPT -D CMAKE_VERBOSE=ON"
OPT="$OPT -D CMAKE_VERBOSE_MAKEFILE=ON"

current=`pwd` && \
cd "$dirname" && \
mkdir -p build && \
cd build && \
cmake -D "CMAKE_INSTALL_PREFIX=$INSTALL_DIR" $OPT .. && \
make -j 8 && \
make install
if [[ $? != 0 ]]; then exit 1; fi

#modificar los pc para agregar un rpath a la instalacion
for file in "$INSTALL_DIR"/lib/pkgconfig/*.pc; do
  sed -e 's/^\(Libs:.*\)$/\1 -lflann -Wl,-rpath,${libdir}/' "$file"
done
if [[ $? != 0 ]]; then exit 1; fi

#fin
cd "$current" && \
echo ok
