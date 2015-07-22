#!/bin/bash
function _set_bog_profile {
  local stop_flag=''
  local current_directory=${PWD}
  while [[ ! -z ${current_directory} ]] && [[ -z ${stop_flag} ]]; do

    if [[ -e "${current_directory}/.bog-profile" ]]; then
      bog $(cat "${current_directory}/.bog-profile")
      stop_flag='.'
    fi

    if [[ ! -z ${current_directory} ]]; then
      current_directory=$(dirname ${current_directory})
    fi
  done
}

old_prompt_command=${PROMPT_COMMAND}
export PROMPT_COMMAND="_set_bog_profile; ${old_prompt_command}"
