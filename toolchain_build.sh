#!/bin/bash


LIBS="-lgnustl_shared" CFLAGS="-DU_STATIC_IMPLEMENTATION -fblocks" CPPFLAGS="-DU_STATIC_IMPLEMENTATION -fblocks" ./configure \
	--prefix=$MIRAI_SDK_PREFIX --host="arm-linux-androideabi" --enable-nxconstantstring \
	--enable-pass-arguments -disable-xslt --disable-tls \
	--with-xml-prefix=$MIRAI_SDK_PREFIX --disable-openssl

make debug=yes
make install debug=yes

pushd $MIRAI_SDK_PREFIX/lib
mv libgnustep-base.so.1.24.6 libgnustep-base.so
rm libgnustep-base.so.1.24
popd