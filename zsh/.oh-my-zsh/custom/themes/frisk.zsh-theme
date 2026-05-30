# Tokyo Night Storm Frisk theme for Oh My Zsh.

_frisk_git_prompt() {
  local ref dirty=""
  ref=$(command git symbolic-ref --short HEAD 2>/dev/null) \
    || ref=$(command git rev-parse --short HEAD 2>/dev/null) \
    || return

  [[ -n $(command git status --porcelain 2>/dev/null) ]] \
    && dirty=" %F{#F7768E}*%F{#7DCFFF}"

  print -n "%F{#7DCFFF}[${ref}${dirty}]%f "
}

frisk_precmd() {
  if [[ -n "${FRISK_PROMPT_READY:-}" ]]; then
    print ""
  fi
  FRISK_PROMPT_READY=1

  PROMPT="%F{#7AA2F7}%/%f $(_frisk_git_prompt)%F{#7AA2F7}[%n@%m]%f %F{#565F89}[%T]%f
%F{#A9B1D6}>%f "
  PROMPT2="%F{#A9B1D6}%_> %f"
}

autoload -U add-zsh-hook
add-zsh-hook precmd frisk_precmd

frisk_precmd
