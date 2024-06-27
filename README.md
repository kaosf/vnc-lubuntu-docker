# VNC Lubuntu Docker

```sh
docker image build . -t vld:1
docker container run -d -p 127.0.0.1:5901:5901 --name vld vld:1
docker exec -it vld bash
```

```sh
# Set password
vncpasswd

export USER=root

# To create a default ~/.vnc/xstartup file
vncserver :1 -geometry 1920x1080 -depth 24
vncserver -kill :1

echo 'lxsession -s LXDE &' >> ~/.vnc/xstartup
vncserver :1 -geometry 1920x1080 -depth 24
```

```sh
gvncviewer :1
```

## License

[![Public Domain](http://i.creativecommons.org/p/mark/1.0/88x31.png)](http://creativecommons.org/publicdomain/mark/1.0/ "license")

This work is free of known copyright restrictions.
