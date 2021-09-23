#!/usr/bin/env bash
function interpolate_options() {
  tmux show-option -gqv "$1"                 \
    | sed -e 's/#{cpu_fan}/${CPU_FAN_CMD}/g' \
    | sed -e 's/#{cpu_tmp}/${CPU_TMP_CMD}/g' \
    | sed -e 's/#{gpu_fan}/${GPU_FAN_CMD}/g' \
    | sed -e 's/#{gpu_tmp}/${GPU_TMP_CMD}/g' \
    | sed -e 's/#{hdd_tmp}/${HDD_TMP_CMD}/g' \
    | sed -e 's/#{sys_fan}/${SYS_FAN_CMD}/g' \
    | envsubst
}

export CPU_FAN_CMD="#(sensors | awk '/nct6798-isa-0290/ {f=1}; (f==1 && /fan1/)       { print int(\$2); exit 0 }')"
export CPU_TMP_CMD="#(sensors | awk '/nct6798-isa-0290/ {f=1}; (f==1 && /CPUTIN/)     { print int(\$2); exit 0 }')°"
export GPU_FAN_CMD="#(sensors | awk '/nct6798-isa-0290/ {f=1}; (f==1 && /fan4/)       { print int(\$2); exit 0 }')"
export GPU_TMP_CMD="#(sensors | awk '/nouveau-pci-0400/ {f=1}; (f==1 && /temp1/)      { print int(\$2); exit 0 }')°"
export HDD_TMP_CMD="#(sensors | awk '/nvme-pci/         {f=1}; (f==1 && /Composite/)  { print int(\$2); exit 0 }')°"
export SYS_FAN_CMD="#(sensors | awk '/nct6798-isa-0290/ {f=1}; (f==1 && /fan2/)       { print int(\$2); exit 0 }')"

for option in status-left status-right; do
  tmux set-option -gq "${option}" "$(interpolate_options "${option}")"
done

