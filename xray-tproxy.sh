#!/system/bin/sh
scripts_dir="/data/adb/xray-tproxy/scripts"
(until [ "$(getprop sys.boot_completed)" -eq 1 ]; do sleep 3; done; "${scripts_dir}/start.sh") &
