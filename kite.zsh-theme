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
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${KITE_VCS_PROMPT_PREFIX1}${KITE_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[magenta]%}●"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}●"

# Machine name.
function box_name {
	[ -f ~/.box-name ] && cat ~/.box-name || echo $HOST
}

# HG info
local hg_info='$(kite_hg_prompt_info)'
kite_hg_prompt_info() {
	# make sure this is a hg dir
	if [ -d '.hg' ]; then
		echo -n "${KITE_VCS_PROMPT_PREFIX1}hg${KITE_VCS_PROMPT_PREFIX2}"
		echo -n $(hg branch 2>/dev/null)
		if [ -n "$(hg status 2>/dev/null)" ]; then
			echo -n "$ZSH_THEME_GIT_PROMPT_DIRTY"
		else
			echo -n "$ZSH_THEME_GIT_PROMPT_CLEAN"
		fi
		echo -n "$ZSH_THEME_GIT_PROMPT_SUFFIX"
	fi
}

local exit_code="%(?,,C:%{$fg[red]%}%?%{$reset_color%})"

# Prompt format: \n # USER at MACHINE in DIRECTORY on git:BRANCH STATE [TIME] \n $
PROMPT="%{$purple%}%{$reset_color%} \
%{$fg[cyan]%}%n \
%{$fg[white]%}at \
%{$fg[green]%}$(box_name) \
%{$fg[white]%}in \
%{$fg[yellow]%}%~%{$reset_color%}\
${hg_info}\
${git_info} \
%{$fg[white]%}[%*]
%{$fg[magenta]%}$ %{$reset_color%}"

if [[ "$USER" == "root" ]]; then
PROMPT="%{$purple%}#%{$reset_color%} \
%{$bg[yellow]%}%{$fg[cyan]%}%n%{$reset_color%} \
%{$fg[white]%}at \
%{$fg[green]%}$(box_name) \
%{$fg[white]%}in \
%{$fg[yellow]%}%~%{$reset_color%}\
${hg_info}\
${git_info} \
%{$fg[white]%}[%*]
%{$fg[magenta]%}$ %{$reset_color%}"
fi
