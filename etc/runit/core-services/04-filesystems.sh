# vim: set ts=4 sw=4 et:

[ -n "$IS_CONTAINER" ] && return 0

msg "Level 4"
LIBMOUNT_FORCE_MOUNT2=always mount -o remount,ro / || emergency_shell

[ -f /fastboot ] && FASTBOOT=1
[ -f /forcefsck ] && FORCEFSCK="-f"
for arg in $(cat /proc/cmdline); do
    case $arg in
        fastboot) FASTBOOT=1;;
        forcefsck) FORCEFSCK="-f";;
    esac
done

if [ -z "$FASTBOOT" ]; then
    fsck -A -T -a -t noopts=_netdev $FORCEFSCK
    if [ $? -gt 1 ]; then
        emergency_shell
    fi
fi

LIBMOUNT_FORCE_MOUNT2=always mount -o remount,rw / || emergency_shell
