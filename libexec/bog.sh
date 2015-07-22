#!/bin/bash
function _set_bog_profile {
  local stop_flag=''
  local current_directory=${PWD}
  while [[ ${current_directory} != '/' ]] && [[ -z ${stop_flag} ]]; do

    if [[ -e "${current_directory}/.bog-profile" ]]; then
      bog $(cat "${current_directory}/.bog-profile")
      stop_flag='.'
    fi

    current_directory=$(dirname ${current_directory})
  done

  # If we've never found a dotfile use the default
  if [[ -z ${stop_flag} ]]; then
    if [[ -e ~/.bog/default ]]; then
      bog $(cat ~/.bog/default)
    else
      echo 'bog cannot find a default profile.'
      echo 'You may set one with `bog PROFILE default`.'
      echo 'If you choose not to do this your current'
      echo 'profile will be set by the last .bog-profile.'
    fi
  fi
}

old_prompt_command=${PROMPT_COMMAND}
export PROMPT_COMMAND="_set_bog_profile; ${old_prompt_command}"
