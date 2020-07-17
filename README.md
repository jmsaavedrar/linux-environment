# linux-environment
Here, you will find the required intructions to install basic libraries to compile most of my projects.
Ubuntu 18.04
# CUDA
1. Install CUDA 10.0
- sudo dpkg -i cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
- sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
- sudo apt update
- sudo apt install cuda-10-0
- Modify /etc/environment to include
  - CUDA_HOME="/usr/local/cuda"
  - LD_LIBRARY_PATH="/usr/local/cuda/lib64"
  - Add /usr/local/cuda/bin to "PATH" variable
2. Add cudnn
The required version is cudnn-10.0-linux-x64-v7.4.1.5.tgz. Please, decompress the file. After that you will get the folder "cuda" containing include and lib files.
- sudo cp cuda/include/cudnn.h /usr/local/cuda/include
- sudo cp cuda/lib64/libcudnn*  /usr/local/cuda/lib64/
- sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*
Great!! Cuda is already installed!
# Python
1. Prepare the Python environment
To this end, I recommend to use Anaconda following the next link 
https://www.ceos3c.com/open-source/install-anaconda-ubuntu-18-04/
- Once anancoda was installed, proceed to create an environment to run tensorflow
  - conda create -n python3.6 python=3.6
  - source activate python3.6
  - pip install  numpy
  - pip install scikit-image
  - pip install scikit-learn  
  - pip install tensorflow-gpu==1.13.1 *Now we are moving to tf 2.2*
  - Note: After getting inside the python3.6 environment the LD_LIBRARY_PATH must be set to export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"/usr/local/cuda/lib64"
# OpenCV
1. Basic Dependencies
    - sudo apt install ffmpeg cmake
    - sudo apt install libgtk2.0-dev  libcanberra-gtk-module libcanberra-gtk3-module [graphic interface]  
2. Installing OpenCV 4.1
    We'll use the script install.sh inside opencv dir
    - bash opencv/install.sh 
3. Installing FLANN
    We'll use the script install.sh inside flann dir
    - bash flann/install.sh 
4. Test opencv
    - git clone opencv [https://github.com/jmsaavedrar/opencv]
    - Go to the folder "test" inside "opencv"
    - make
    - ./build/test [image file]. You can find some images in the folder "images" inside "opencv".
  
# Tensorflow API C
1. Dowloand it from https://www.tensorflow.org/install/lang_c
2. After uncomprissing the file, you will have the folder tensorflow (tf). Please copy it to the dependecies location. I recommend adding a pkgconfig (tf.pc) file to this lib. 






