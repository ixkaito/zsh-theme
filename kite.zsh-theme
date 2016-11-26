# Clean, simple, compatible and meaningful.
# Tested on Linux, Unix and Windows under ANSI colors.
# It is recommended to use with a dark background and the font Inconsolata.
# Colors: black, red, green, yellow, *blue, magenta, cyan, and white.
#
# http://ysmood.org/wp/2013/03/my-ys-terminal-theme/
# Mar 2013 ys

# Machine name.
function box_name {
	[ -f ~/.box-name ] && cat ~/.box-name || echo $HOST
}

# Directory info.
local current_dir="${PWD/#$HOME/~}"

#use extended color pallete if available
# if [[ $TERM = *256color* || $TERM = *rxvt* ]]; then
# 	cyan="%F{81}"
# 	magenta="%F{197}"
# 	yellow="%F{185}"
# 	red="%F{160}"
# 	# green="%F{154}"
# 	green="%F{119}"
# 	purple="%F{141}"
# else
# 	cyan="$fg[cyan]"
# 	magenta="$fg[magenta]"
# 	yellow="$fg[yellow]"
# 	red="$fg[red]"
# 	green="$fg[green]"
# 	purple="$fg[blue]"
# fi

cyan="$fg[cyan]"
magenta="$fg[magenta]"
yellow="$fg[yellow]"
red="$fg[red]"
green="$fg[green]"
purple="$fg[blue]"

# VCS
YS_VCS_PROMPT_PREFIX1=" %{$fg[white]%}on%{$reset_color%} "
YS_VCS_PROMPT_PREFIX2="%{$cyan%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY=" %{$magenta%}●"
YS_VCS_PROMPT_CLEAN=" %{$green%}●"

# Git info.
local git_info="$(git_prompt_info)"
ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}${YS_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"

# HG info
local hg_info="$(ys_hg_prompt_info)"
ys_hg_prompt_info() {
	# make sure this is a hg dir
	if [ -d ".hg" ]; then
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
