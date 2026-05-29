# Frostfire-Nord Frisk theme for Oh My Zsh.

GIT_CB="git::"
ZSH_THEME_SCM_PROMPT_PREFIX="%F{#88C0D0}["
ZSH_THEME_GIT_PROMPT_PREFIX="%F{#88C0D0}[${GIT_CB}"
ZSH_THEME_GIT_PROMPT_SUFFIX="]%f "
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{#BF616A}*%F{#88C0D0}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

frisk_precmd() {
  if [[ -n "${FRISK_PROMPT_READY:-}" ]]; then
    print ""
  fi
  FRISK_PROMPT_READY=1

  PROMPT="%F{#F69D50}%/%f $(git_prompt_info)$(bzr_prompt_info)%F{#82AAFF}[%n@%m]%f %F{#4C566A}[%T]%f
%F{#D8DEE9}>%f "
  PROMPT2="%F{#D8DEE9}%_> %f"
}

autoload -U add-zsh-hook
add-zsh-hook precmd frisk_precmd

frisk_precmd
