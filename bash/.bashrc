# ~/.bashrc: executed by bash(1) for non-login shells.
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ ${BASH_VERSION} =~ ^5 ]] || echo "You are not running bash 5."

PATH="${HOME}/.local/bin:${HOME}/.local/bin2:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export TZ="Australia/Melbourne"

# SOURCE EXTRAS
for file in ${HOME}/.local/src/dotfiles-linux/bash/include.d/*; do
  [[ ! -f ${file} ]]            && continue
  [[ ${file} =~ .disabled$ ]]   && continue
  [[ ${file} =~ .example$ ]]    && continue

  if ${TIME_BASH:-false}; then
    echo "sourcing ${file}"
    time source "${file}"
  else
    source "${file}"
  fi

done

true
