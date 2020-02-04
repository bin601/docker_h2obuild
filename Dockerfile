FROM i386/ubuntu:14.04
MAINTAINER bin.lain <bin.lain@insyde.com>

ENV DEBIAN_FRONTEND noninteractive

ENV SVN_VERSION=1.7.22-1+WANdisco

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
    subversion=${SVN_VERSION} libsvn1=${SVN_VERSION} && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f /etc/apt/sources.list.d/WANdisco-1.7.list && \ 
    apt-mark hold subversion libsvn1

RUN pip install Pillow==6.0.0 pyinstaller==3.4 && echo PIL > /usr/local/lib/python2.7/dist-packages/PIL.pth

RUN ln -s /usr/lib/i386-linux-gnu/libjpeg.so /usr/lib/ \
 && ln -s /usr/lib/i386-linux-gnu/libfreetype.so.6 /usr/lib/libfreetype.so \
 && ln -s /usr/lib/i386-linux-gnu/libz.so /usr/lib/ \
 && ln -s /usr/include/freetype2 /usr/include/freetype
 

#RUN apt-get -qq update && apt-get -y install wget 
#RUN echo deb http://opensource.wandisco.com/ubuntu trusty svn17 > /etc/apt/sources.list.d/WANdisco-1.7.list
#
#
#RUN wget -q -O - http://opensource.wandisco.com/wandisco-debian.gpg |  apt-key add - >/dev/null 2>&1
#
#vv=`apt-cache policy subversion | grep '1.7' | awk '{ print $1 }'`
#
#apt-get -y install subversion=$vv libsvn1=$vv
