#!/bin/sh
# 每秒检测 ps 输出，出现 MHD-single 则终止 httpd
while :; do
  out=$(ps -eo pid=,comm=)
  case "$out" in
    *MHD-single*)
      # 发送 SIGTERM 给所有 httpd
      while IFS= read -r line; do
        set -- $line
        pid=$1; cmd=$2
        if [ "$cmd" = "httpd" ]; then
          kill "$pid" 2>/dev/null || true
        fi
      done <<EOF
$out
EOF
      sleep 3
      # 强制杀掉仍然存在的 httpd
      out2=$(ps -eo pid=,comm=)
      while IFS= read -r line; do
        set -- $line
        pid=$1; cmd=$2
        if [ "$cmd" = "httpd" ]; then
          kill -9 "$pid" 2>/dev/null || true
        fi
      done <<EOF
$out2
EOF
      ;;
  esac
  sleep 1
done
