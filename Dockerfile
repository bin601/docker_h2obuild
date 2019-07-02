FROM ubuntu:16.04
MAINTAINER bin.lain <bin.lain@insyde.com>

# change mirrot to tw NCHC 
RUN sed -i 's/\w\+.ubuntu.com/free.nchc.org.tw/g' /etc/apt/sources.list

RUN dpkg --add-architecture i386

RUN apt-get -qq update && apt-get -qqy install                          \
    sudo subversion                                                     \
    build-essential gcc-4.8-multilib g++-4.8-multilib p7zip-full nasm   \
    libc6-dev-i386 lib32stdc++6 lib32z1                                 \
    curl                                                                \
    python2.7:i386 python-dev:i386 libjpeg-dev:i386 libfreetype6-dev:i386 zlib1g-dev:i386 uuid-dev:i386  \
    && rm -rf /var/lib/apt/lists/*
    
RUN  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 1000 --slave /usr/bin/g++ g++ /usr/bin/g++-4.8

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py

RUN python get-pip.py && pip install pyinstaller pillow 

RUN echo PIL > /usr/local/lib/python2.7/dist-packages/PIL.pth

RUN ln -s /usr/lib/i386-linux-gnu/libjpeg.so /usr/lib/ \
 && ln -s /usr/lib/i386-linux-gnu/libfreetype.so.6 /usr/lib/libfreetype.so \
 && ln -s /usr/lib/i386-linux-gnu/libz.so /usr/lib/ \
 && ln -s /usr/include/freetype2 /usr/include/freetype
 
