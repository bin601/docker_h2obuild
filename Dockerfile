FROM i386/ubuntu:14.04
MAINTAINER bin.lain <bin.lain@insyde.com>

ENV DEBIAN_FRONTEND noninteractive

# change mirrot to tw NCHC 
RUN sed -i 's/\w\+.ubuntu.com/free.nchc.org.tw/g' /etc/apt/sources.list

RUN apt-get update && \
    apt-get  -y --no-install-recommends install wget && \
    echo deb http://opensource.wandisco.com/ubuntu trusty svn17 > /etc/apt/sources.list.d/WANdisco-1.7.list && \
    wget -q -O - http://opensource.wandisco.com/wandisco-debian.gpg |  apt-key add - >/dev/null 2>&1  && \
    apt-get -qq update && apt-get -y --no-install-recommends install \
    build-essential gcc-multilib uuid-dev p7zip-full nasm      \
    python-pip                                                 \
    python-dev libjpeg-dev libfreetype6-dev zlib1g-dev         \
    subversion=1.7.* libsvn1=1.7.* && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f /etc/apt/sources.list.d/WANdisco-1.7.list && \ 
    apt-mark hold subversion libsvn1

RUN pip install Pillow==6.0.0 pyinstaller==3.4 && echo PIL > /usr/local/lib/python2.7/dist-packages/PIL.pth

RUN ln -s /usr/lib/i386-linux-gnu/libjpeg.so /usr/lib/ \
 && ln -s /usr/lib/i386-linux-gnu/libfreetype.so.6 /usr/lib/libfreetype.so \
 && ln -s /usr/lib/i386-linux-gnu/libz.so /usr/lib/ \
 && ln -s /usr/include/freetype2 /usr/include/freetype
 