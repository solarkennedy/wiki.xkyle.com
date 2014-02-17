    #
    # mysql_X - where 'X' is the instance number used by mysqld_multi.
    #
    #   tummy.com wrapper for Percona mysqld_multi starting/stopping/reporting.
    #   - change $instance
    #   - change chkconfig order, e.g. 64, 65, 66 or higher as needed by existing
    #     versions of this script.
    #
    # MySQL daemon start/stop script.

    # Comments to support chkconfig on RedHat Linux
    # chkconfig: 2345 64 36
    # description: A very fast and reliable SQL database engine.

    # Comments to support LSB init script conventions
    ### BEGIN INIT INFO
    # Provides: mysql
    # Required-Start: $local_fs $network $remote_fs
    # Should-Start: ypbind nscd ldap ntpd xntpd
    # Required-Stop: $local_fs $network $remote_fs
    # Default-Start:  2 3 4 5
    # Default-Stop: 0 1 6
    # Short-Description: start and stop MySQL
    # Description: MySQL is a very fast and reliable SQL database engine.
    ### END INIT INFO

    # $instance is the instance used by mysqld_multi
    instance=1
    multi=/etc/init.d/mysqld_multi
     
    # Default value, in seconds, afterwhich the script should timeout waiting
    # for server start. 
    # Value here is overriden by value in my.cnf. 
    # 0 means don't wait at all
    # Negative numbers mean to wait indefinitely
    service_startup_timeout=900

    #
    # Use LSB init script functions for printing messages, if possible
    #
    lsb_functions="/lib/lsb/init-functions"
    if test -f $lsb_functions ; then
      . $lsb_functions
    else
      log_success_msg()
      {
        echo " SUCCESS! $@"
      }
      log_failure_msg()
      {
        echo " ERROR! $@"
      }
    fi

    PATH=/sbin:/usr/sbin:/bin:/usr/bin:$basedir/bin
    export PATH

    mode=$1    # start or stop
    shift
    other_args="$*"   # uncommon, but needed when called from an RPM upgrade action
               # Expected: "--skip-networking --skip-grant-tables"
               # They are not checked here, intentionally, as it is the resposibility
               # of the "spec" file author to give correct arguments only.

    case `echo "testing\c"`,`echo -n testing` in
        *c*,-n*) echo_n=   echo_c=     ;;
        *c*,*)   echo_n=-n echo_c=     ;;
        *)       echo_n=   echo_c='\c' ;;
    esac


    case "$mode" in
      'start')
        $multi start $instance
        ;;

      'stop')
        $multi stop $instance
        ;;

      'restart')
        # Stop the service and regardless of whether it was
        # running or not, start it again.
        if $0 stop  $other_args; then
          $0 start $other_args
        else
          log_failure_msg "Failed to stop running server, so refusing to try to start."
          exit 1
        fi
        ;;

      'status')
        $multi report $instance
        ;;
        *)
          # usage
          echo "Usage: $0  {start|stop|restart|status}  [ MySQLd_multi server options ]"
          exit 1
        ;;
    esac

    exit 0

<Category:Mysql>
