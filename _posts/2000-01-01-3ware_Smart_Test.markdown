It is not straight forward how to check out the health of the drives
behind a 3ware raid controller, but here is a nice script that I wrote
to check the health of all 8 behind a 9xxx:

    #!/bin/bash
    for DRIVE in `seq 0 7`
    do
    smartctl --test short --device=3ware,$DRIVE /dev/twa0  >/dev/null 2>&1
    sleep 2m
    HOURS=`smartctl -a --device=3ware,$DRIVE /dev/twa0  | grep "Power_On_Hours" | tr " " "\n" | tail -n 1`
    if [ "$HOURS" == "" ]; then
            HOURS=`smartctl -a --device=3ware,$DRIVE /dev/twa0  | grep "# 1" | cut -c 64-75 | tr -d [:space:]`
    fi
    SERIALNUMBER=`smartctl -a --device=3ware,$DRIVE /dev/twa0  | grep "Serial Number" | head -n 1 | awk '{print $3}'`
    ERRORCOUNT=`smartctl -a --device=3ware,$DRIVE /dev/twa0  | grep "Error" | grep "occurred" | head -n 1 | cut -f 2 -d " "`
    ERRORTIME=`smartctl -a --device=3ware,$DRIVE /dev/twa0  | grep "Error" | grep "occurred" | head -n 1 | cut -f 8 -d " "`
    if [ "$ERRORCOUNT" = "" ] ; then
    ERRORCOUNT=0
    ERRORTIME=0
    fi
    REALLOCATEDSECTORS=`smartctl -a --device=3ware,$DRIVE /dev/twa0  | grep "Reallocated_Sector" | tr " " "\n" | tail -n 1`
    PENDINGSECTORS=`smartctl -a --device=3ware,$DRIVE /dev/twa0  | grep "Current_Pending_Sector" |  tr " " "\n" | tail -n 1`
    echo -e "\033[1;42;37mTest Complete\033[0m"
    echo "Serial No: $SERIALNUMBER"
    echo "`date +%D` $DRIVE:"
    echo "Hours: $HOURS "
    echo -n "SMART Errors: $ERRORCOUNT"
    if [ $ERRORCOUNT -gt 0 ]; then
    let WHENITHAPPEND=$HOURS-$ERRORTIME
    echo " (last $WHENITHAPPEND hours ago)"
    else
    echo
    fi
    echo "Reallocated / Pending: $REALLOCATEDSECTORS / $PENDINGSECTORS"
    echo ""
    done

<Category:Linux> <Category:Sysadmin>
