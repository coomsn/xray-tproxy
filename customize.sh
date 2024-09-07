#!/system/bin/sh
#####################
# xray_lite Customization
#####################
SKIPUNZIP=1
ASH_STANDALONE=1
unzip_path="/data/adb"

# Define the paths of source folder and the destination folder
source_folder="/data/adb/xray_lite"
destination_folder="/data/adb/xray_lite$(date +%Y%m%d_%H%M%S)"

# Check if the source folder exists
if [ -d "$source_folder" ]; then
    # If the source folder exists, execute the move operation
    mv "$source_folder" "$destination_folder"
    ui_print "- 正在备份已有文件"
    # Delete old folders and update them
    rm -rf "$source_folder"
else
    # If the source folder does not exist, output initial installation information 
    ui_print "- 正在初始安装"
fi

ui_print "- 正在释放文件"
unzip -o "$ZIPFILE" 'xray_lite/*' -d $unzip_path >&2
unzip -j -o "$ZIPFILE" 'xray_lite_service.sh' -d /data/adb/service.d >&2
unzip -j -o "$ZIPFILE" 'uninstall.sh' -d $MODPATH >&2
unzip -j -o "$ZIPFILE" "module.prop" -d $MODPATH >&2
ui_print "- 正在设置权限"
set_perm /data/adb/service.d/xray_lite_service.sh 0 0 0755
set_perm_recursive $MODPATH 0 0 0755 0755
set_perm_recursive $unzip_path/xray_lite 0 0 0755 0755

ui_print "-----------------------------------------------------------"
ui_print "- Do you want to download xray and Geox ?"
ui_print "- Make sure you have a good internet connection."
ui_print "- [ Vol UP(+): Yes ]"
ui_print "- [ Vol DOWN(-): No ]"

START_TIME=$(date +%s)
while true ; do
  NOW_TIME=$(date +%s)
  timeout 1 getevent -lc 1 2>&1 | grep KEY_VOLUME > "$TMPDIR/events"
  if [ $(( NOW_TIME - START_TIME )) -gt 9 ] ; then
    ui_print "- No input detected after 10 seconds"
    break
  else
    if $(cat $TMPDIR/events | grep -q KEY_VOLUMEUP) ; then
      ui_print "- It will take a while...."
      /data/adb/xray_lite/scripts/update_xray > /dev/null 2>&1
      if [ -f /data/adb/xray_lite/binary/LICENSE ] ; then
      ui_print "- Download successful!"
      rm -f /data/adb/xray_lite/binary/LICENSE
      else
      ui_print "- Download failed!"
      fi
      break
    elif $(cat $TMPDIR/events | grep -q KEY_VOLUMEDOWN) ; then
      ui_print "- Skip download xray and Geox"
      break
    fi
  fi
done

ui_print "- 完成权限设置"
ui_print "- enjoy!"
