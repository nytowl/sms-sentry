#! /bin/sh
#
# chkconfig: 345 90 20
# processname: python

PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin:/usr/local/sbin
USER=root
NAME=sms-sentry
 
/usr/bin/logger -s "Starting $0 $1"

[ -f /etc/default/rcS ] && . /etc/default/rcS

case "$1" in
    start)
        logger -s "Starting SMS sentry daemon: "
        start-stop-daemon --start --pidfile /var/run/${NAME}.pid --make-pidfile --background -x /usr/bin/sms-sentry
	if [ $? = 0 ]; then
            logger -s "(ok)"
        else
            logger -s "(failed)"
        fi
        ;;
    stop)
        logger -s "Stopping SMS sentry daemon: "
        start-stop-daemon --stop --pidfile /var/run/${NAME}.pid --oknodo
        rm -f /var/run/${NAME}.pid
        logger -s "(done)"
        ;;
    restart|force-reload)
        $0 stop
        $0 start
        ;;
    *)
        logger -s  "Usage: $0 {start|stop|restart|force-reload}"
        exit 1
        ;;
esac

exit 0
