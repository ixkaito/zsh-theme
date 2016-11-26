local cyan="$fg[cyan]"
local magenta="$fg[magenta]"
local yellow="$fg[yellow]"
local red="$fg[red]"
local green="$fg[green]"
local purple="$fg[blue]"

# VCS
YS_VCS_PROMPT_PREFIX1=" %{$fg[white]%}on%{$reset_color%} "
YS_VCS_PROMPT_PREFIX2="%{$cyan%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY=" %{$magenta%}●"
YS_VCS_PROMPT_CLEAN=" %{$green%}●"

# Git info
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}${YS_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"

# Machine name.
function box_name {
	[ -f ~/.box-name ] && cat ~/.box-name || echo $HOST
}

# HG info
local hg_info='$(ys_hg_prompt_info)'
ys_hg_prompt_info() {
	# make sure this is a hg dir
	if [ -d '.hg' ]; then
		echo -n "${YS_VCS_PROMPT_PREFIX1}hg${YS_VCS_PROMPT_PREFIX2}"
		echo -n $(hg branch 2>/dev/null)
		if [ -n "$(hg status 2>/dev/null)" ]; then
			echo -n "$YS_VCS_PROMPT_DIRTY"
		else
			echo -n "$YS_VCS_PROMPT_CLEAN"
		fi
		echo -n "$YS_VCS_PROMPT_SUFFIX"
	fi
}

local exit_code="%(?,,C:%{$red%}%?%{$reset_color%})"

# Prompt format: \n # USER at MACHINE in DIRECTORY on git:BRANCH STATE [TIME] \n $
PROMPT="
%{$purple%}#%{$reset_color%} \
%{$cyan%}%n \
%{$fg[white]%}at \
%{$green%}$(box_name) \
%{$fg[white]%}in \
%{$yellow%}${current_dir}%{$reset_color%}\
${hg_info}\
${git_info} \
%{$fg[white]%}[%*]
%{$magenta%}$ %{$reset_color%}"

if [[ "$USER" == "root" ]]; then
PROMPT="
%{$purple%}#%{$reset_color%} \
%{$bg[yellow]%}%{$cyan%}%n%{$reset_color%} \
%{$fg[white]%}at \
%{$green%}$(box_name) \
%{$fg[white]%}in \
%{$yellow%}${current_dir}%{$reset_color%}\
${hg_info}\
${git_info} \
%{$fg[white]%}[%*]
%{$magenta%}$ %{$reset_color%}"
fi
