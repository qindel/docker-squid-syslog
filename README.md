Docker container with squid and syslog forwarding
Based on Alpine with 25MB

NOTE: Example assumes you have a "/squid" with your container specific data!
Change as needed with the SRC data that you are mounting into the container.
Example named data is defined in the example subdir.

## Required "DATA" directory - named.conf and zone data:
This container assumes you have a "/squid" folder with your container specific data:
You can change that folder as needed, but make sure you update the "-v" mounts for run time

1.) [ *REQUIRED* ] In your /squid/etc/bind a file "named.conf", which acts as an entry point to your configs

2.) [ *REQUIRED* ] A "/squid/var/cache/bind" directory for all of the master or slave zones. If it's for slave zones, it will populate automatically and you can leave it blank.

3.) [ *OPTIONAL* ] A "/var/log/squid" directory for logs if syslog logging is not enabled

4.) [ *OPTIONAL* ] set environment variable "UDPLOGHOST" or "TCPLOGHOST", if defined rsyslog will be started with remote SYSLOG logging to these hosts. If you use remote syslog, then it might be useful to set the hostname of the container depending on your server syslog configuration (the logs on the syslog server might get stored based on the hostname of the client)


## Run SQUID Container with remote syslog logging:
```
cd docker-squid-syslog # Go to into Git Repo
SRC=/squid
docker run --name=squidserver --hostname=squidserver -p 3128:3128 -e UDPLOGHOST=192.168.0.17 -v $SRC/etc/squid:/etc/squid:ro -v $SRC/var/cache/squid:/var/cache/squid qindel/squid-syslog
```

