# Machine name
kite_box_name() {
	[ -f ~/.box-name ] && cat ~/.box-name || echo $HOST
}

# Git info
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}on %{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

#
# Git status
#
kite_git_status() {
  local INDEX git_status=""
	local kite_git_status_untracked="?"
	local kite_git_status_added="+"
	local kite_git_status_modified="!"
	local kite_git_status_renamed="»"
	local kite_git_status_deleted="✘"
	local kite_git_status_stashed="$"
	local kite_git_status_unmerged="="
	local kite_git_status_ahead="⇡"
	local kite_git_status_behind="⇣"
	local kite_git_status_diverged="⇕"

  INDEX=$(command git status --porcelain -b 2> /dev/null)

  # Check for untracked files
  if $(echo "$INDEX" | command grep -E '^\?\? ' &> /dev/null); then
    git_status="$kite_git_status_untracked$git_status"
  fi

  # Check for staged files
  if $(echo "$INDEX" | command grep '^A[ MDAU] ' &> /dev/null); then
    git_status="$kite_git_status_added$git_status"
  elif $(echo "$INDEX" | command grep '^M[ MD] ' &> /dev/null); then
    git_status="$kite_git_status_added$git_status"
  elif $(echo "$INDEX" | command grep '^UA' &> /dev/null); then
    git_status="$kite_git_status_added$git_status"
  fi

  # Check for modified files
  if $(echo "$INDEX" | command grep '^[ MARC]M ' &> /dev/null); then
    git_status="$kite_git_status_modified$git_status"
  fi

  # Check for renamed files
  if $(echo "$INDEX" | command grep '^R[ MD] ' &> /dev/null); then
    git_status="$kite_git_status_renamed$git_status"
  fi

  # Check for deleted files
  if $(echo "$INDEX" | command grep '^[MARCDU ]D ' &> /dev/null); then
    git_status="$kite_git_status_deleted$git_status"
  elif $(echo "$INDEX" | command grep '^D[ UM] ' &> /dev/null); then
    git_status="$kite_git_status_deleted$git_status"
  fi

  # Check for stashes
  if $(command git rev-parse --verify refs/stash >/dev/null 2>&1); then
    git_status="$kite_git_status_stashed$git_status"
  fi

  # Check for unmerged files
  if $(echo "$INDEX" | command grep '^U[UDA] ' &> /dev/null); then
    git_status="$kite_git_status_unmerged$git_status"
  elif $(echo "$INDEX" | command grep '^AA ' &> /dev/null); then
    git_status="$kite_git_status_unmerged$git_status"
  elif $(echo "$INDEX" | command grep '^DD ' &> /dev/null); then
    git_status="$kite_git_status_unmerged$git_status"
  elif $(echo "$INDEX" | command grep '^[DA]U ' &> /dev/null); then
    git_status="$kite_git_status_unmerged$git_status"
  fi

  # Check whether branch is ahead
  local is_ahead=false
  if $(echo "$INDEX" | command grep '^## [^ ]\+ .*ahead' &> /dev/null); then
    is_ahead=true
  fi

  # Check whether branch is behind
  local is_behind=false
  if $(echo "$INDEX" | command grep '^## [^ ]\+ .*behind' &> /dev/null); then
    is_behind=true
  fi

  # Check wheather branch has diverged
  if [[ "$is_ahead" == true && "$is_behind" == true ]]; then
    git_status="$kite_git_status_diverged$git_status"
  else
    [[ "$is_ahead" == true ]] && git_status="$kite_git_status_ahead$git_status"
    [[ "$is_behind" == true ]] && git_status="$kite_git_status_behind$git_status"
  fi

  if [[ -n $git_status ]]; then
		echo "%{$fg[magenta]%}[$git_status] "
	else
		echo "%{$fg[green]%}● "
  fi
}

# Node.js version
kite_node_info() {
  # Show NODE status only for JS-specific folders
  [[ -f package.json || -d node_modules ]] || return

  local node_version=$(node -v 2>/dev/null)

  [[ -z $node_version ]] && return

	echo "%{$fg[white]%}via %{$fg[green]%}⬢ ${node_version} "
}

# Prompt format: \n # USER at MACHINE in DIRECTORY on GIT_BRANCH STATE via NODE [TIME] \n $
PROMPT="
%{$fg[white]%} %{$fg[cyan]%}%n \
%{$fg[white]%}at %{$fg[green]%}$(kite_box_name) \
%{$fg[white]%}in %{$fg[yellow]%}%~%{$reset_color%} \
$(kite_git_status)\
$(kite_node_info)\
%{$fg[white]%}[%*]
%{$fg[magenta]%}$ %{$reset_color%}"

unset -f kite_box_name
unset -f kite_git_status
unset -f kite_node_info
