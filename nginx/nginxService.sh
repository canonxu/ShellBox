#!/bin/bash
#
# Function: nginx service, including start, stop, restart, reload, status and congig

# Example: bash nginxService satrt


SERVICE_PATH=/etc/init.d/

NGINX_CONF_FILE="/usr/local/nginx/conf/nginx.conf"

NGINX="/usr/local/sbin/nginx"


LOCK_FILE=/var/lock/subsys/nginx

start() {
    [ -x $nginx ] || exit 5
    [ -f $NGINX_CONF_FILE ] || exit 6
    echo -n $"Starting nginx... "
    daemon $NGINX -c $NGINX_CONF_FILE
    retval=$?
    echo
    [ $retval -eq 0 ] && touch $LOCK_FILE
    return $retval
}

stop() {
    echo -n $"Stopping nginx... "
    killproc $NGINX -QUIT
    retval=$?
    echo
    [ $retval -eq 0 ] && rm -f $LOCK_FILE
    return $retval
}

restart() {
    configtest || return $?
    stop
    start
}

reload() {
    configtest || return $?
    echo -n $"Reloading nginx: "
    killproc $nginx -HUP
    RETVAL=$?
    echo
}


configtest() {
  $nginx -t -c $NGINX_CONF_FILE
}

rh_status() {
    status $NGINX
}

rh_status_q() {
    rh_status >/dev/null 2>&1
}

case "$1" in
    start)
        rh_status_q && exit 0
        $1
        ;;
    stop)
        rh_status_q || exit 0
        $1
        ;;
    restart|configtest)
        $1
        ;;
    reload)
        rh_status_q || exit 7
        $1
        ;;
    status)
        rh_status
        ;;
    condrestart|try-restart)
        rh_status_q || exit 0
            ;;
    *)
        echo $"Usage: $0 {start|stop|status|restart|condrestart|try-restart|reload|force-reload|configtest}"
        exit 2
esac
