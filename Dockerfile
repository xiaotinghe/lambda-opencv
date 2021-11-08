FROM amazonlinux:2

WORKDIR /
RUN yum update -y

# Install Python 3.9
RUN yum install gcc openssl-devel bzip2-devel libffi-devel wget tar gzip make zip -y
RUN yum install -y mesa-libGL mesa-libGLES
RUN wget https://www.python.org/ftp/python/3.9.0/Python-3.9.0.tgz
RUN tar -xzvf Python-3.9.0.tgz
WORKDIR /Python-3.9.0
RUN ./configure --enable-optimizations
RUN make install

# Install Python packages
RUN mkdir /packages
RUN echo "opencv-python" >> /packages/requirements.txt
RUN echo "Pillow" >> /packages/requirements.txt
RUN mkdir -p /packages/opencv-python-3.9/python/lib/python3.9/site-packages

RUN pip3.9 install --upgrade pip
RUN pip3.9 install -r /packages/requirements.txt -t /packages/opencv-python-3.9/python/lib/python3.9/site-packages

RUN cp -v /usr/lib64/libGL.so.1 /packages/opencv-python-3.9/python/lib/python3.9/site-packages/opencv_python.libs/
RUN cp -v /usr/lib64/libGL.so.1.7.0 /packages/opencv-python-3.9/python/lib/python3.9/site-packages/opencv_python.libs/
RUN cp -v /usr/lib64/libgthread-2.0.so.0 /packages/opencv-python-3.9/python/lib/python3.9/site-packages/opencv_python.libs/
RUN cp -v /usr/lib64/libgthread-2.0.so.0 /packages/opencv-python-3.9/python/lib/python3.9/site-packages/opencv_python.libs/
RUN cp -v /usr/lib64/libglib-2.0.so.0 /packages/opencv-python-3.9/python/lib/python3.9/site-packages/opencv_python.libs/
RUN cp -v /usr/lib64/libGLX.so.0 /packages/opencv-python-3.9/python/lib/python3.9/site-packages/opencv_python.libs/
RUN cp -v /usr/lib64/libX11.so.6 /packages/opencv-python-3.9/python/lib/python3.9/site-packages/opencv_python.libs/
RUN cp -v /usr/lib64/libXext.so.6 /packages/opencv-python-3.9/python/lib/python3.9/site-packages/opencv_python.libs/
RUN cp -v /usr/lib64/libGLdispatch.so.0 /packages/opencv-python-3.9/python/lib/python3.9/site-packages/opencv_python.libs/
RUN cp -v /usr/lib64/libGLESv1_CM.so.1.2.0 /packages/opencv-python-3.9/python/lib/python3.9/site-packages/opencv_python.libs/
RUN cp -v /usr/lib64/libGLX_mesa.so.0.0.0 /packages/opencv-python-3.9/python/lib/python3.9/site-packages/opencv_python.libs/
RUN cp -v /usr/lib64/libGLESv2.so.2.1.0 /packages/opencv-python-3.9/python/lib/python3.9/site-packages/opencv_python.libs/
RUN cp -v /usr/lib64/libxcb.so.1 /packages/opencv-python-3.9/python/lib/python3.9/site-packages/opencv_python.libs/
RUN cp -v /usr/lib64/libXau.so.6 /packages/opencv-python-3.9/python/lib/python3.9/site-packages/opencv_python.libs/
RUN cp -v /usr/lib64/libXau.so.6 /packages/opencv-python-3.9/python/lib/python3.9/site-packages/opencv_python.libs/
RUN cp -v /lib64/libGLdispatch.so.0.0.0 /packages/opencv-python-3.9/python/lib/python3.9/site-packages/opencv_python.libs/

# Create zip files for Lambda Layer deployment
WORKDIR /packages/opencv-python-3.9/
RUN zip -r9 /packages/cv2-python39.zip .
WORKDIR /packages/
RUN rm -rf /packages/opencv-python-3.9/