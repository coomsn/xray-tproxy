#!/system/bin/sh
clear
scripts=$(realpath $0)
scripts_dir=$(dirname ${scripts})
parent_dir=$(dirname ${scripts_dir})
module_dir="/data/adb/modules/xray_tproxy-module"

source ${scripts_dir}/xray_tproxy.service
log Info "The process is starting, please wait"

# Check if the disable file does not exist, then run the proxy
if [ ! -f "${module_dir}/disable" ]; then
  start_tproxy # >/dev/null 2>&1
  else
  log Warn "module is not enabled"
fi

start_xray_tproxy.inotify() {
  PIDs=($(busybox pidof inotifyd))
  for PID in "${PIDs[@]}"; do
    if grep -q "xray_tproxy.inotify" "/proc/$PID/cmdline"; then
      kill -9 "$PID"
    fi
  done
  inotifyd "${scripts_dir}/xray_tproxy.inotify" "${module_dir}" >/dev/null 2>&1 &
}

# Create inotifyd.
start_xray_tproxy.inotify
# version2.0
