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

## office preview

```
sudo apt-get install libcairo2-dev zlib1g-dev libpng12-dev libopenjpeg-dev libpango1.0-dev libreoffice libreoffice-script-provider-python
```

- fontforge

`git clone git@github.com:coolwanglu/fontforge.git`

```
./configure
make
sudo make install
```

- poppler

`wget http://poppler.freedesktop.org/poppler-0.34.0.tar.xz`
```
./configure --enable-xpdf-headers
make
sudo make install
```

- pdf2htmlEX

`git clone git://github.com/coolwanglu/pdf2htmlEX.git`
```
cmake .
make
sudo make install
```

- events.conf
```
[OFFICE CONVERTER]
enabled = true
max-size = 30
```
