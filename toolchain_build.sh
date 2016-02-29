#!/bin/bash

checkError()
{
    if [ "${1}" -ne "0" ]; then
        echo "*** Error: ${2}"
        exit ${1}
    fi
}


CC=$CROSS_CLANG LIBS="-lgnustl_shared" CFLAGS="$ARCHFLAGS -DU_STATIC_IMPLEMENTATION -fblocks" CPPFLAGS="$ARCHFLAGS -DU_STATIC_IMPLEMENTATION -fblocks" LDFLAGS="$ARCHLDFLAGS" ./configure \
	--prefix=$MIRAI_SDK_PREFIX --host="$HOSTEABI" --enable-nxconstantstring \
	--enable-pass-arguments -disable-xslt --disable-tls \
	--with-xml-prefix=$MIRAI_SDK_PREFIX --disable-openssl --with-default-config=./Android_GNUstep.conf
checkError $? "configure gnustep-base failed"

make -j4 #debug=yes
checkError $? "make gnustep-base failed"

make install #debug=yes
checkError $? "install gnustep-base failed"


pushd $MIRAI_SDK_PREFIX/lib
mv libgnustep-base.so.1.24.6 libgnustep-base.so
rm libgnustep-base.so.1.24
ln -s libgnustep-base.so libFoundation.so
popd