#!/bin/sh
mkdir -p /etc/rsyslog
cat /dev/null > /etc/rsyslog/00-remote.conf
[ -n "$UDPLOGHOST" ] && echo "*.* @$UDPLOGHOST" >> /etc/rsyslog/00-remote.conf
[ -n "$TCPLOGHOST" ] && echo "*.* @@$TCPLOGHOST" >> /etc/rsyslog/00-remote.conf
[ -n "$UDPLOGHOST" -o -n "$TCPLOGHOST" ] && /usr/sbin/rsyslogd -f /etc/rsyslog.conf
mkdir -p /var/cache/squid /var/log/squid /etc/squid
chown -R squid:squid /var/cache/squid /var/log/squid /etc/squid
exec su - squid -c "/usr/sbin/squid -z"
exec su - squid -c "/usr/sbin/squid -N -YC -f /etc/squid/squid.conf"
