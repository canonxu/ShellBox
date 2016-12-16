#!/bin/bash

# Function: install nginx

# Example: sudo bash installNginx

# download from sohu mirror site: http://mirrors.sohu.com/nginx/, relly quick
# here, version is 1.9.10

# if nginx dictionary exists, remove it
if [ -d /usr/local/nginx ]; then
    rm -r /usr/local/nginx
    echo "primary nginx is removed"
fi

URL=http://mirrors.sohu.com/nginx/nginx-1.9.10.tar.gz

cd /usr/local

echo "start download nginx source..."
wget -cq $URL 
tar xf nginx-1.9.10.tar.gz && rm nginx-1.9.10.tar.gz
mv nginx-1.9.10 nginx && cd nginx


# configure for make, 
# note: must define --conf-path, and should NOT be /usr/local/nginx/conf/nginx.conf, as the program will copy file from /conf to target --conf-path(may cause cp conflicts)
echo "start configure nginx..."
./configure\
    --prefix=/usr/local/nginx\
    --conf-path=/usr/local/nginx/config/nginx.conf\
    --with-http_ssl_module\
    >> install.log

echo "start make and install nginx..."
make >> install.log
make install >> install.log &&  echo "nginx installed successfully ^-^"
