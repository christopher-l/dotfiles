# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.profile

if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} ]]
then
	exec fish
fi
