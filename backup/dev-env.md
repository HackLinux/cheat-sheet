- Complie libsearpc with

```
cd ~/dev/libsearpc
./autogen.sh
./configure
make -j4
make install
```
- Compile ccnet with

```
cd ~/dev/ccnet
./autogen.sh
./configure --disable-client --enable-server --enable-ldap
make -j4
make install
```

> `export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig` if libsearpc is not found

- Compile seafile with

```
cd ~/dev/seafile
./autogen.sh
./configure --disable-client --enable-server
make -j4
make install
```

> sudo make clean
