# local cyan="$fg[cyan]"
# local magenta="$fg[magenta]"
# local yellow="$fg[yellow]"
# local red="$fg[red]"
# local green="$fg[green]"
local purple="$fg[blue]"

# VCS
KITE_VCS_PROMPT_PREFIX1=" %{$fg[white]%}on%{$reset_color%} "
KITE_VCS_PROMPT_PREFIX2="%{$fg[cyan]%}"
# KITE_VCS_PROMPT_SUFFIX="%{$reset_color%}"
# KITE_VCS_PROMPT_DIRTY=" %{$fg[magenta]%}●"
# KITE_VCS_PROMPT_CLEAN=" %{$fg[green]%}●"

# Git info
# local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}on %{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[magenta]%}●"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}●"

# Machine name.
function box_name {
	[ -f ~/.box-name ] && cat ~/.box-name || echo $HOST
}

node_info() {
  # Show NODE status only for JS-specific folders
  [[ -f package.json || -d node_modules || -n *.js(#qN^/) ]] || return

  local node_version=$(node -v 2>/dev/null)

  [[ -z $node_version ]] && return

	echo "%{$fg[green]%}⬢ ${node_version}"
}

# Prompt format: \n # USER at MACHINE in DIRECTORY on git:BRANCH STATE [TIME] \n $
PROMPT="%{$fg[white]%} %{$fg[cyan]%}%n \
%{$fg[white]%}at %{$fg[green]%}$(box_name) \
%{$fg[white]%}in %{$fg[yellow]%}%~%{$reset_color%} \
$(git_prompt_info) \
$(node_info) \
%{$fg[white]%}[%*]
%{$fg[magenta]%}$ %{$reset_color%}"
