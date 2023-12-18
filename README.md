# ye3tftp

A docker TFTP server based on tftp-hpa and Alpine. Light, below 10 Mb. GNS3 ready.

The /data folder is persistent.

# Simple usage

```bash
docker run -dt --name mytftp -e Y_CREATE=yes -e Y_CHMOD=777 palw3ey/ye3tftp
```

# Test

-   From the host

```bash
# create a test file :
docker exec -it mytftp sh --login -c "echo it_works > /data/test.txt"

# get container IP :
docker inspect --format='{{.NetworkSettings.IPAddress}}' mytftp

# install a tftp client
apt install tftp-hpa

# get the test file through the tftp client
tftp 192.168.9.150 69
  get test.txt
  quit

# show the content of the test file
cat test.txt
```

# HOWTOs

- Mount to host folder /home/tux/Downloads
```bash
docker run -dt --name mytftp -v /home/tux/Downloads:/data -e Y_CREATE=yes -e Y_CHMOD=777 palw3ey/ye3tftp
```

- Map to your host port 1069
```bash
docker run -dt --name mytftp -p 1069:69/udp -e Y_CREATE=yes -e Y_CHMOD=777 palw3ey/ye3tftp
```

# GNS3

To run through GNS3, download and import the appliance : [ye3tftp.gns3a](https://raw.githubusercontent.com/palw3ey/ye3tftp/master/ye3tftp.gns3a)

# Environment Variables

These are the env variables and their default values.

| variables | format | default | description |
| :- |:- |:- |:- |
|Y_LANGUAGE | text | fr_FR | Language. The list is in the folder /i18n/ |
|Y_DEBUG | yes/no | no | yes, Run tftpd with verbose (--verbosity 4) option |
|Y_IP | IP address | 0.0.0.0 | IP address to listen to |
|Y_PORT | port number | 69 | Port to listen to |
|Y_CREATE | yes/no | no | yes, Allow new files to be created |
|Y_CHMOD | integer permission | | chmod to apply to /data/ folder. Has no default value by default, this mean : *dont modify permission.* Useful number 444 or 777. |
|Y_CHMOD_RECURSIVE | yes/no | no | apply chmod recursively, this mean : to all files and folder in /data/ |

# Build

To customize and create your own images.

```bash
git clone https://github.com/palw3ey/ye3tftp.git
cd ye3tftp
# Make all your modifications, then :
docker build --no-cache --network=host -t ye3tftp .
docker run -dt --name my_customized_tftp ye3tftp
```
# Documentation

[tftpd man page](https://linux.die.net/man/8/tftpd)

# Version

| name | version |
| :- |:- |
|ye3tftp | 1.0.0 |
|tftp-hpa | 5.2 |
|alpine | 3.18.4 |

# ToDo

- ~~need to document env variables~~ (2023-12-18)
- add more translation files in i18n folder. Contribute ! Send me your translations by mail ;)

Don't hesitate to send me your contributions, issues, improvements on github or by mail.

# License

MIT  
author: palw3ey  
maintainer: palw3ey  
email: palw3ey@gmail.com  
website: https://github.com/palw3ey/ye3tftp  
docker hub: https://hub.docker.com/r/palw3ey/ye3tftp
