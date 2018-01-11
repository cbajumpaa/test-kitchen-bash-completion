__kitchen_instance_list () {
  YAML=${KITCHEN_YAML:-.kitchen.yml}
  LIST=${YAML}.list

  # cache to .kitchen.list.yml
  if [[ ${YAML} -nt ${LIST} ]]; then
    # update list if config has updated
    kitchen list --bare > ${LIST}
  fi
  cat ${LIST}
}

__kitchen_options () {
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  COMPREPLY=()

  case $prev in
    converge|create|destroy|diagnose|list|login|setup|test|verify)
      COMPREPLY=( $(compgen -W "$(__kitchen_instance_list)" -- ${cur} ))
      return 0
      ;;
    driver)
      COMPREPLY=( $(compgen -W "create discover help"  -- ${cur} ))
      return 0
      ;;
    *)
      COMPREPLY=( $(compgen -W "console converge create destroy driver help init list login setup test verify version"  -- ${cur} ))
      return 0
      ;;
  esac
}
complete -F __kitchen_options kitchen
