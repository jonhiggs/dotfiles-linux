#!/usr/bin/env bash
function interpolate_options() {
  tmux show-option -gqv "$1" \
    | sed -e 's/#{email}/✉ ${FM_EMAIL_CMD} ${RB_EMAIL_CMD}/g' \
    | envsubst
}

export RB_EMAIL_CMD='#(/usr/local/bin/notmuch --config=/home/jon/.config/notmuch/notmuch-config search "tag:redbubble AND tag:inbox AND tag:unread" | wc -l)'
export FM_EMAIL_CMD='#(/usr/local/bin/notmuch --config=/home/jon/.config/notmuch/notmuch-config search "tag:fastmail AND tag:inbox AND tag:unread" | wc -l)'

for option in status-left status-right; do
  tmux set-option -gq "${option}" "$(interpolate_options "${option}")"
done

