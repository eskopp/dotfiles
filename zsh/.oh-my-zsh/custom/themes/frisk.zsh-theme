# Dynamic Frisk theme for Oh My Zsh.
# Keeps the original Frisk layout, but adapts colors based on the current
# theme-switcher selection.

frisk_current_theme() {
  local config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
  local current_name="${config_home}/theme-switcher/current/name"

  if [[ -r "${current_name}" ]]; then
    local theme_name
    theme_name="$(<"${current_name}")"
    [[ -n "${theme_name}" ]] && printf '%s\n' "${theme_name}" && return 0
  fi

  printf 'nord\n'
}

frisk_apply_palette() {
  local theme_name
  theme_name="$(frisk_current_theme)"

  case "${theme_name}" in
    anime)
      FRISK_PATH_COLOR="magenta"
      FRISK_GIT_COLOR="blue"
      FRISK_USERHOST_COLOR="white"
      FRISK_TIME_COLOR="white"
      FRISK_PROMPT_COLOR="magenta"
      FRISK_GIT_BRACKET_COLOR="blue"
      FRISK_GIT_DIRTY_COLOR="red"
      ;;
    berserk)
      FRISK_PATH_COLOR="red"
      FRISK_GIT_COLOR="red"
      FRISK_USERHOST_COLOR="white"
      FRISK_TIME_COLOR="white"
      FRISK_PROMPT_COLOR="red"
      FRISK_GIT_BRACKET_COLOR="red"
      FRISK_GIT_DIRTY_COLOR="yellow"
      ;;
    solstice)
      FRISK_PATH_COLOR="yellow"
      FRISK_GIT_COLOR="yellow"
      FRISK_USERHOST_COLOR="white"
      FRISK_TIME_COLOR="white"
      FRISK_PROMPT_COLOR="yellow"
      FRISK_GIT_BRACKET_COLOR="yellow"
      FRISK_GIT_DIRTY_COLOR="red"
      ;;
    nord|*)
      FRISK_PATH_COLOR="blue"
      FRISK_GIT_COLOR="green"
      FRISK_USERHOST_COLOR="white"
      FRISK_TIME_COLOR="white"
      FRISK_PROMPT_COLOR="black"
      FRISK_GIT_BRACKET_COLOR="green"
      FRISK_GIT_DIRTY_COLOR="red"
      ;;
  esac

  GIT_CB="git::"
  ZSH_THEME_SCM_PROMPT_PREFIX="%{$fg[${FRISK_GIT_BRACKET_COLOR}]%}["
  ZSH_THEME_GIT_PROMPT_PREFIX=$ZSH_THEME_SCM_PROMPT_PREFIX$GIT_CB
  ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%} "
  ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[${FRISK_GIT_DIRTY_COLOR}]%}*%{$fg[${FRISK_GIT_BRACKET_COLOR}]%}"
  ZSH_THEME_GIT_PROMPT_CLEAN=""
}

frisk_precmd() {
  frisk_apply_palette

  if [[ -n "${FRISK_PROMPT_READY:-}" ]]; then
    print ""
  fi
  FRISK_PROMPT_READY=1

  PROMPT="%{$fg[${FRISK_PATH_COLOR}]%}%/%{$reset_color%} \$(git_prompt_info)\$(bzr_prompt_info)%{$fg[${FRISK_USERHOST_COLOR}]%}[%n@%m]%{$reset_color%} %{$fg[${FRISK_TIME_COLOR}]%}[%T]%{$reset_color%}
%{$fg_bold[${FRISK_PROMPT_COLOR}]%}>%{$reset_color%} "
  PROMPT2="%{$fg_bold[${FRISK_PROMPT_COLOR}]%}%_> %{$reset_color%}"
}

autoload -U add-zsh-hook
add-zsh-hook precmd frisk_precmd

frisk_precmd
