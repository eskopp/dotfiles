# Static Nord-flavored Frisk theme for Oh My Zsh.

FRISK_PATH_COLOR="blue"
FRISK_GIT_COLOR="green"
FRISK_USERHOST_COLOR="white"
FRISK_TIME_COLOR="white"
FRISK_PROMPT_COLOR="black"
FRISK_GIT_BRACKET_COLOR="green"
FRISK_GIT_DIRTY_COLOR="red"

GIT_CB="git::"
ZSH_THEME_SCM_PROMPT_PREFIX="%{$fg[${FRISK_GIT_BRACKET_COLOR}]%}["
ZSH_THEME_GIT_PROMPT_PREFIX=$ZSH_THEME_SCM_PROMPT_PREFIX$GIT_CB
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[${FRISK_GIT_DIRTY_COLOR}]%}*%{$fg[${FRISK_GIT_BRACKET_COLOR}]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

frisk_precmd() {
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
