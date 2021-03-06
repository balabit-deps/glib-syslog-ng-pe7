set -e

zbs-get update
cat tgz2build/tgz2deps | xargs -I{} zbs-get install {}
ls /opt/syslog-ng/lib/

export PKG_CONFIG_PATH="/opt/syslog-ng/lib/pkgconfig:$PKG_CONFIG_PATH"
export LIBRARY_PATH="$LIBRARY_PATH:/opt/syslog-ng/lib"
export CFLAGS='-O2 -isystem /opt/syslog-ng/include -Wl,-z,origin,-rpath,\$$ORIGIN/../lib'

sh autogen.sh
./configure --prefix=/opt/syslog-ng/ --disable-static --enable-shared --disable-gtk-doc --with-libiconv=gnu --enable-debug
make all
make DESTDIR=`pwd`/artifacts/=install/ install
