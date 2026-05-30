# Tokyo Night Storm Frisk theme for Oh My Zsh.

GIT_CB="git::"
ZSH_THEME_SCM_PROMPT_PREFIX="%F{#7DCFFF}["
ZSH_THEME_GIT_PROMPT_PREFIX="%F{#7DCFFF}[${GIT_CB}"
ZSH_THEME_GIT_PROMPT_SUFFIX="]%f "
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{#F7768E}*%F{#7DCFFF}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

frisk_precmd() {
  if [[ -n "${FRISK_PROMPT_READY:-}" ]]; then
    print ""
  fi
  FRISK_PROMPT_READY=1

  PROMPT="%F{#FF9E64}%/%f $(git_prompt_info)$(bzr_prompt_info)%F{#7AA2F7}[%n@%m]%f %F{#565F89}[%T]%f
%F{#A9B1D6}>%f "
  PROMPT2="%F{#A9B1D6}%_> %f"
}

autoload -U add-zsh-hook
add-zsh-hook precmd frisk_precmd

frisk_precmd
