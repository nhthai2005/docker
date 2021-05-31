FROM tensorflow/tensorflow:1.15.2-py3-jupyter
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install git cmake wget unzip -y
ADD opencv.sh /home/opencv.sh
RUN /home/opencv.sh
RUN pip install Cython
RUN pip install contextlib2
RUN pip install pillow
RUN pip install lxml
ADD tfmodels.sh /home/tfmodels.sh
RUN /home/tfmodels.sh