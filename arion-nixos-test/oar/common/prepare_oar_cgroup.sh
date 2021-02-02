#!/run/current-system/sw/bin/bash
# This script prepopulates OAR cgroup directory hierarchy, as used in the
# job_resource_manager_cgroups.pl script, in order to have nodes use different
# subdirectories and avoid conflitcs due to having all nodes actually running on
# the same host machine

OS_CGROUPS_PATH="/sys/fs/cgroup"
CGROUP_SUBSYSTEMS="cpuset cpu cpuacct devices freezer blkio"
if [ -e "$OS_CGROUPS_PATH/memory" ]; then
  CGROUP_SUBSYSTEMS="$CGROUP_SUBSYSTEMS memory"
fi
CGROUP_DIRECTORY_COLLECTION_LINKS="/dev/oar_cgroups_links"


if [ "$1" = "init" ]; then
    # mkdir -p /tmp/plop_cgroup_$1
    mkdir -p $CGROUP_DIRECTORY_COLLECTION_LINKS && \
    for s in $CGROUP_SUBSYSTEMS; do
      mkdir -p $OS_CGROUPS_PATH/$s/oardocker/$HOSTNAME
      ln -s $OS_CGROUPS_PATH/$s/oardocker/$HOSTNAME $CGROUP_DIRECTORY_COLLECTION_LINKS/$s
    done
    ln -s $OS_CGROUPS_PATH/cpuset/oardocker/$HOSTNAME /dev/cpuset

    cat $OS_CGROUPS_PATH/cpuset/cpuset.cpus > $OS_CGROUPS_PATH/cpuset/oardocker/cpuset.cpus
    cat $OS_CGROUPS_PATH/cpuset/cpuset.mems > $OS_CGROUPS_PATH/cpuset/oardocker/cpuset.mems
    /run/current-system/sw/bin/echo 0 > $OS_CGROUPS_PATH/cpuset/oardocker/cpuset.cpu_exclusive
    /run/current-system/sw/bin/echo 1000 > $OS_CGROUPS_PATH/cpuset/oardocker/notify_on_release

    cat $OS_CGROUPS_PATH/cpuset/oardocker/cpuset.cpus > $OS_CGROUPS_PATH/cpuset/oardocker/$HOSTNAME/cpuset.cpus
    cat $OS_CGROUPS_PATH/cpuset/oardocker/cpuset.mems > $OS_CGROUPS_PATH/cpuset/oardocker/$HOSTNAME/cpuset.mems
    /run/current-system/sw/bin/echo 0 > $OS_CGROUPS_PATH/cpuset/oardocker/$HOSTNAME/cpuset.cpu_exclusive
    /run/current-system/sw/bin/echo 0 > $OS_CGROUPS_PATH/cpuset/oardocker/$HOSTNAME/notify_on_release
    /run/current-system/sw/bin/echo 1000 > $OS_CGROUPS_PATH/blkio/oardocker/$HOSTNAME/blkio.weight
elif [ "$1" = "clean" ]; then

    CGROOT="$OS_CGROUPS_PATH/cpuset/oardocker/"
    
    if ! [ -d $CGROOT ]; then
        echo "Nothing to clean, no such directory: $CGROOT"
        exit 0;
    fi
    
    echo "kill all cgroup tasks"
    while read task; do
        echo "kill -9 $task"
        kill -9 $task
    done < <(find $CGROOT -name tasks -exec cat {} \;)
    
    wait
    echo "Wipe all cgroup content"
    find $CGROOT -depth -type d -exec rmdir {} \;
    
    echo "Cgroup is cleanded!"
    
fi

exit 0
