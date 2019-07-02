FROM i386/ubuntu:14.04
MAINTAINER bin.lain <bin.lain@insyde.com>

# change mirrot to tw NCHC 
RUN sed -i 's/\w\+.ubuntu.com/free.nchc.org.tw/g' /etc/apt/sources.list

RUN apt-get -qq update && apt-get -y --no-install-recommends install subversion        \
    build-essential gcc-multilib uuid-dev p7zip-full nasm      \
    python-pip                                                 \
    python-dev libjpeg-dev libfreetype6-dev zlib1g-dev         \
    && rm -rf /var/lib/apt/lists/*   
    
RUN pip install pyinstaller pillow && echo PIL > /usr/local/lib/python2.7/dist-packages/PIL.pth

RUN ln -s /usr/lib/i386-linux-gnu/libjpeg.so /usr/lib/ \
 && ln -s /usr/lib/i386-linux-gnu/libfreetype.so.6 /usr/lib/libfreetype.so \
 && ln -s /usr/lib/i386-linux-gnu/libz.so /usr/lib/ \
 && ln -s /usr/include/freetype2 /usr/include/freetype
 

