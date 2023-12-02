# ye3tftp

A docker TFTP server based on tftp-hpa and Alpine. Light, below 10 Mb. GNS3 ready.

The /data folder is persistent.

# Quickstart

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

# GNS3

To run through GNS3, download and import the appliance : [ye3tftp.gns3a](https://raw.githubusercontent.com/palw3ey/ye3tftp/master/ye3tftp.gns3a)

# Environment Variables

These are the env variables and their default values.

| variables | format | default |
| :- |:- |:- |
|Y_LANGUAGE | text | fr_FR |
|Y_DEBUG | yes/no | no |
|Y_IP | IP address | 0.0.0.0 |
|Y_PORT | port number | 69 |
|Y_CREATE | yes/no | no |
|Y_CHMOD | number | |
|Y_CHMOD_RECURSIVE | yes/no | no |

Y_CHMOD has no default value, this mean : *dont modify permission.* Useful number 444 or 777.

# Build

To customize and create your own images.

```bash
git clone https://github.com/palw3ey/ye3tftp.git
cd ye3tftp
# Make all your modifications, then :
docker build --no-cache --network=host -t ye3tftp .
docker run -dt --name my_customized_tftp ye3tftp
```

# License

MIT  
author: palw3ey  
maintainer: palw3ey  
email: palw3ey@gmail.com  
website: https://github.com/palw3ey/ye3tftp  
docker hub: https://hub.docker.com/r/palw3ey/ye3tftp
