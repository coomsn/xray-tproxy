#!/system/bin/sh
clear
scripts=$(realpath $0)
scripts_dir=$(dirname ${scripts})
parent_dir=$(dirname ${scripts_dir})
module_dir="/data/adb/modules/xray-tproxy"
# Environment variable settings
export PATH="/data/adb/ap/bin:/data/adb/ksu/bin:/data/adb/magisk:$PATH"

source ${scripts_dir}/xray-tproxy.service
if [ ! -f "${module_dir}/disable" ]; then
  log Info "The process is starting, please wait"
else
  log Warn "Please turn on the mask switch"
fi

# Check if the disable file does not exist, then run the proxy
if [ ! -f "${module_dir}/disable" ]; then
  start_tproxy # >/dev/null 2>&1
  else
  log Warn "module is not enabled"
fi

start_inotifyd() {
  PIDs=($(busybox pidof inotifyd))
  for PID in "${PIDs[@]}"; do
    if grep -q "xray-tproxy.inotify" "/proc/$PID/cmdline"; then
      kill -9 "$PID"
    fi
  done
  inotifyd "${scripts_dir}/xray-tproxy.inotify" "${module_dir}" >/dev/null 2>&1 &
}

start_inotifyd

# {version2.1}