# linux-environment
Here, you will find the required intructions to install basic libraries to compile most of my projects.
These instructions work for Ubuntu 18.04 or 20.04
# CUDA
The following steps are based on the specifications given by https://www.tensorflow.org/install/gpu#ubuntu_1804_cuda_101.
## Add NVIDIA repositories
- wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.1.243-1_amd64.deb
- sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
- sudo dpkg -i cuda-repo-ubuntu1804_10.1.243-1_amd64.deb
- sudo apt update
- wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
- sudo apt install ./nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
- sudo apt update
## Install NVIDIA driver
- sudo apt install nvidia-driver-455
- Reboot
- Test driver with nvidia-smi
## Install cuda and libcudnn
- sudo apt-get install cuda-10-1 libcudnn7=7.6.5.32-1+cuda10.1 libcudnn7-dev=7.6.5.32-1+cuda10.1
## Install TensorRT
- sudo apt-get install -y libnvinfer6=6.0.1-1+cuda10.1 libnvinfer-dev=6.0.1-1+cuda10.1 libnvinfer-plugin6=6.0.1-1+cuda10.1
## libcublas
- libcublas is installed in the folder cuda-10.2, check it. You will need to add this folder to LD_LIBRARY_PATH in ~/.profile.
- source ~/.profile

Great!! Cuda is already installed!

# Python
1. Prepare the Python environment
To this end, I recommend to install Anaconda following the next link
https://www.anaconda.com/download/#linux
- Once anancoda was installed, proceed to create an environment to run tensorflow
  - conda create -n python3.6 python=3.6
  - source activate python3.6
  - pip install  numpy
  - pip install scikit-image
  - pip install scikit-learn  
  - pip install tensorflow-gpu *Now we are moving to tf 2.2*
  - Note: After getting inside the python3.6 environment the LD_LIBRARY_PATH must be set to export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"/usr/local/cuda/lib64"
# OpenCV
1. Basic Dependencies
    - sudo apt install ffmpeg cmake
    - sudo apt install libgtk2.0-dev  libcanberra-gtk-module libcanberra-gtk3-module [graphic interface]  
    - sudo apt install build-essential cmake unzip pkg-config
    - sudo apt install libgtk-3.dev
    - sudo apt install libjpeg-dev libpng-dev libtiff-dev
    - sudo apt install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
    - sudo apt install libxvidcore-dev libx264-dev
    - sudo apt install libatlas-base-dev gfortran
    - Install libjasper-dev. If possible that you need to import the repository. An example for Ubuntu 18.06 is show:
    >sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main" & sudo apt update
3. Python Support.
For generating cv2.so for Python3, please check out the python's variables in the installation script.
4. Installing OpenCV 4.5.
We'll use the script install.sh inside opencv dir
    - bash opencv/install.sh 
5. Installing FLANN [optional, in case of installing jmsr].
We'll use the script install.sh inside flann dir
    - bash flann/install.sh 
6. Test opencv
    - git clone opencv [https://github.com/jmsaavedrar/opencv]
    - Go to the folder "test" inside "opencv"
    - make
    - ./build/test [image file]. You can find some images in the folder "images" inside "opencv".
  
# Tensorflow API C
1. Dowloand it from https://www.tensorflow.org/install/lang_c
2. After uncomprissing the file, you will have the folder tensorflow (tf). Please copy it to the dependecies location. I recommend adding a pkgconfig (tf.pc) file to this lib. 






