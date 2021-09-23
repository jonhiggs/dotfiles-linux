#!/usr/bin/env bash
function interpolate_options() {
  tmux show-option -gqv "$1"                \
    | sed -e 's/#{load1}/${LOAD_1_CMD}/g'   \
    | sed -e 's/#{load5}/${LOAD_5_CMD}/g'   \
    | sed -e 's/#{load15}/${LOAD_15_CMD}/g' \
    | envsubst
}

export LOAD_1_CMD="#(uptime | awk '{ sub(/,/,\"\",\$(NF-2)); print \$(NF-2) }')"
export LOAD_5_CMD="#(uptime | awk '{ sub(/,/,\"\",\$(NF-1)); print \$(NF-1) }')"
export LOAD_15_CMD="#(uptime | awk '{ sub(/,/,\"\",\$NF); print \$NF }')"

for option in status-left status-right; do
  tmux set-option -gq "${option}" "$(interpolate_options "${option}")"
done

