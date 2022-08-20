# Machine name
kite_box_name() {
	[ -f ~/.box-name ] && cat ~/.box-name || echo $HOST
}

# Git info
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}on %{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[magenta]%}●"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}●"

# Node.js version
kite_node_info() {
  # Show NODE status only for JS-specific folders
  [[ -f package.json || -d node_modules ]] || return

  local node_version=$(node -v 2>/dev/null)

  [[ -z $node_version ]] && return

	echo "%{$fg[white]%}via %{$fg[green]%}⬢ ${node_version} "
}

# Prompt format: \n # USER at MACHINE in DIRECTORY on GIT_BRANCH STATE via NODE [TIME] \n $
PROMPT="%{$fg[white]%} %{$fg[cyan]%}%n \
%{$fg[white]%}at %{$fg[green]%}$(kite_box_name) \
%{$fg[white]%}in %{$fg[yellow]%}%~%{$reset_color%} \
$(git_prompt_info)\
$(kite_node_info)\
%{$fg[white]%}[%*]
%{$fg[magenta]%}$ %{$reset_color%}"

unset -f kite_box_name
unset -f kite_node_info
