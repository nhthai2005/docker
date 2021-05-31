cd /
git clone https://github.com/opencv/opencv.git --single-branch 3.4.9
mv 3.4.9 cv
cd cv
mkdir build
cd build
cmake ..
make
make install