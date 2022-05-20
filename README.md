sudo docker build -t rtmp-failover .

sudo docker run -ti --rm -p 1995:1935 -e NAME=ln1 -e DEST=rtmp://192.168.90.91/orbita_titan/test rtmp-failover

Env variables:
NAME - is name of input stream
input rtmp url:    rtmp://server_ip_addr:1995/in/$NAME
DEST - is destenation rtpm/ if empty rtmp://server_ip_addr:1995/out/$NAME by default