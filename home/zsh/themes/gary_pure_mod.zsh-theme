#!/usr/bin/env zsh

#
# zsh-async
#
# version: 1.0.0
# author: Mathias Fredriksson
# url: https://github.com/mafredri/zsh-async
#

# Wrapper for jobs executed by the async worker, gives output in parseable format with execution time
_async_job() {
  # Store start time as double precision (+E disables scientific notation)
  float -F duration=$EPOCHREALTIME

  # Run the command
  #
  # What is happening here is that we are assigning stdout, stderr and ret to
  # variables, and then we are printing out the variable assignment through
  # typeset -p. This way when we run eval we get something along the lines of:
  # 	eval "
  # 		typeset stdout=' M async.test.sh\n M async.zsh'
  # 		typeset ret=0
  # 		typeset stderr=''
  # 	"
  unset stdout stderr ret
  eval "$(
    {
      stdout=$(eval "$@")
      ret=$?
      typeset -p stdout ret
    } 2> >(stderr=$(cat); typeset -p stderr)
  )"

  # Calculate duration
  duration=$(( EPOCHREALTIME - duration ))

  # stip all null-characters from stdout and stderr
  stdout="${stdout//$'\0'/}"
  stderr="${stderr//$'\0'/}"

  # if ret is missing for some unknown reason, set it to -1 to indicate we
  # have run into a bug
  ret=${ret:--1}

  # Grab mutex lock
  read -ep >/dev/null

  # return output (<job_name> <return_code> <stdout> <duration> <stderr>)
  print -r -N -n -- "$1" "$ret" "$stdout" "$duration" "$stderr"$'\0'

  # Unlock mutex
  print -p "t"
}

# The background worker manages all tasks and runs them without interfering with other processes
_async_worker() {
  local -A storage
  local unique=0

  # Process option parameters passed to worker
  while getopts "np:u" opt; do
    case "$opt" in
    # Use SIGWINCH since many others seem to cause zsh to freeze, e.g. ALRM, INFO, etc.
    n) trap 'kill -WINCH $ASYNC_WORKER_PARENT_PID' CHLD;;
    p) ASYNC_WORKER_PARENT_PID=$OPTARG;;
    u) unique=1;;
    esac
  done

  # Create a mutex for writing to the terminal through coproc
  coproc cat
  # Insert token into coproc
  print -p "t"

  while read -r cmd; do
    # Separate on spaces into an array
    cmd=(${=cmd})
    local job=$cmd[1]

    # Check for non-job commands sent to worker
    case "$job" in
    _killjobs)
      kill -KILL ${${(v)jobstates##*:*:}%\=*} &>/dev/null
      continue
      ;;
    esac

    # If worker should perform unique jobs
    if ((unique)); then
      # Check if a previous job is still running, if yes, let it finnish
      for pid in ${${(v)jobstates##*:*:}%\=*}; do
        if [[ "${storage[$job]}" == "$pid" ]]; then
          continue 2
        fi
      done
    fi

    # run task in background
    _async_job $cmd &
    # store pid because zsh job manager is extremely unflexible (show jobname as non-unique '$job')...
    storage[$job]=$!
  done
}

#
#  Get results from finnished jobs and pass it to the to callback function. This is the only way to reliably return the
#  job name, return code, output and execution time and with minimal effort.
#
# usage:
# 	async_process_results <worker_name> <callback_function>
#
# callback_function is called with the following parameters:
# 	$1 = job name, e.g. the function passed to async_job
# 	$2 = return code
# 	$3 = resulting stdout from execution
# 	$4 = execution time, floating point e.g. 2.05 seconds
# 	$5 = resulting stderr from execution
#
async_process_results() {
  integer count=0
  local worker=$1
  local callback=$2
  local -a items
  local IFS=$'\0'

  typeset -gA ASYNC_PROCESS_BUFFER
  # Read output from zpty and parse it if available
  while zpty -rt "$worker" line 2>/dev/null; do
    # Remove unwanted \r from output
    ASYNC_PROCESS_BUFFER[$worker]+=${line//$'\r'$'\n'/$'\n'}
    # Split buffer on null characters, preserve empty elements
    items=("${(@)=ASYNC_PROCESS_BUFFER[$worker]}")
    # Remove last element since it's due to the return string separator structure
    items=("${(@)items[1,${#items}-1]}")

    # Continue until we receive all information
    (( ${#items} % 5 )) && continue

    # Work through all results
    while (( ${#items} > 0 )); do
      "$callback" "${(@)=items[1,5]}"
      shift 5 items
      count+=1
    done

    # Empty the buffer
    ASYNC_PROCESS_BUFFER[$worker]=""
  done

  # If we processed any results, return success
  (( $count )) && return 0

  # No results were processed
  return 1
}

#
# Start a new asynchronous job on specified worker, assumes the worker is running.
#
# usage:
# 	async_job <worker_name> <my_function> [<function_params>]
#
async_job() {
  local worker=$1; shift
  zpty -w "$worker" "$@"
}

# This function traps notification signals and calls all registered callbacks
_async_notify_trap() {
  for k in ${(k)ASYNC_CALLBACKS}; do
    async_process_results "${k}" "${ASYNC_CALLBACKS[$k]}"
  done
}

#
# Register a callback for completed jobs. As soon as a job is finnished, async_process_results will be called with the
# specified callback function. This requires that a worker is initialized with the -n (notify) option.
#
# usage:
# 	async_register_callback <worker_name> <callback_function>
#
async_register_callback() {
  typeset -gA ASYNC_CALLBACKS
  local worker=$1; shift

  ASYNC_CALLBACKS[$worker]="$*"

  trap '_async_notify_trap' WINCH
}

#
# Unregister the callback for a specific worker.
#
# usage:
# 	async_unregister_callback <worker_name>
#
async_unregister_callback() {
  typeset -gA ASYNC_CALLBACKS

  unset "ASYNC_CALLBACKS[$1]"
}

#
# Flush all current jobs running on a worker. This will terminate any and all running processes under the worker, use
# with caution.
#
# usage:
# 	async_flush_jobs <worker_name>
#
async_flush_jobs() {
  local worker=$1; shift

  # Check if the worker exists
  zpty -t "$worker" &>/dev/null || return 1

  # Send kill command to worker
  zpty -w "$worker" "_killjobs"

  # Clear all output buffers
  while zpty -r "$worker" line; do true; done

  # Clear any partial buffers
  typeset -gA ASYNC_PROCESS_BUFFER
  ASYNC_PROCESS_BUFFER[$worker]=""
}

#
# Start a new async worker with optional parameters, a worker can be told to only run unique tasks and to notify a
# process when tasks are complete.
#
# usage:
# 	async_start_worker <worker_name> [-u] [-n] [-p <pid>]
#
# opts:
# 	-u unique (only unique job names can run)
# 	-n notify through SIGWINCH signal
# 	-p pid to notify (defaults to current pid)
#
async_start_worker() {
  local worker=$1; shift
  zpty -t "$worker" &>/dev/null || zpty -b "$worker" _async_worker -p $$ "$@" || async_stop_worker "$worker"
}

#
# Stop one or multiple workers that are running, all unfetched and incomplete work will be lost.
#
# usage:
# 	async_stop_worker <worker_name_1> [<worker_name_2>]
#
async_stop_worker() {
  local ret=0
  for worker in "$@"; do
    async_unregister_callback "$worker"
    zpty -d "$worker" 2>/dev/null || ret=$?
  done

  return $ret
}

#
# Initialize the required modules for zsh-async. To be called before using the zsh-async library.
#
# usage:
# 	async_init
#
async_init() {
  zmodload zsh/zpty
  zmodload zsh/datetime
}

async() {
  async_init
}

async "$@"

# Pure
# by Sindre Sorhus
# https://github.com/sindresorhus/pure
# MIT License

# For my own and others sanity
# git:
# %b => current branch
# %a => current action (rebase/merge)
# prompt:
# %F => color dict
# %f => reset color
# %~ => current path
# %* => time
# %n => username
# %m => shortname host
# %(?..) => prompt conditional - %(condition.true.false)
# terminal codes:
# \e7   => save cursor position
# \e[2A => move cursor 2 lines up
# \e[1G => go to position 1 in terminal
# \e8   => restore cursor position
# \e[K  => clears everything after the cursor on the current line
# \e[2K => clear everything on the current line


# turns seconds into human readable time
# 165392 => 1d 21h 56m 32s
# https://github.com/sindresorhus/pretty-time-zsh
prompt_pure_human_time_to_var() {
	local human=" " total_seconds=$1 var=$2
	local days=$(( total_seconds / 60 / 60 / 24 ))
	local hours=$(( total_seconds / 60 / 60 % 24 ))
	local minutes=$(( total_seconds / 60 % 60 ))
	local seconds=$(( total_seconds % 60 ))
	(( days > 0 )) && human+="${days}d "
	(( hours > 0 )) && human+="${hours}h "
	(( minutes > 0 )) && human+="${minutes}m "
	human+="${seconds}s"

	# store human readable time in variable as specified by caller
	typeset -g "${var}"="${human}"
}

# stores (into prompt_pure_cmd_exec_time) the exec time of the last command if set threshold was exceeded
prompt_pure_check_cmd_exec_time() {
	integer elapsed
	(( elapsed = EPOCHSECONDS - ${prompt_pure_cmd_timestamp:-$EPOCHSECONDS} ))
	prompt_pure_cmd_exec_time=
	(( elapsed > ${PURE_CMD_MAX_EXEC_TIME:=5} )) && {
		prompt_pure_human_time_to_var $elapsed "prompt_pure_cmd_exec_time"
	}
}

prompt_pure_clear_screen() {
	# enable output to terminal
	zle -I
	# clear screen and move cursor to (0, 0)
	print -n '\e[2J\e[0;0H'
	# print preprompt
	prompt_pure_preprompt_render precmd
}

prompt_pure_check_git_arrows() {
	# reset git arrows
	prompt_pure_git_arrows=

	# check if there is an upstream configured for this branch
	command git rev-parse --abbrev-ref @'{u}' &>/dev/null || return

	local arrow_status
	# check git left and right arrow_status
	arrow_status="$(command git rev-list --left-right --count HEAD...@'{u}' 2>/dev/null)"
	# exit if the command failed
	(( !$? )) || return

	# left and right are tab-separated, split on tab and store as array
	arrow_status=(${(ps:\t:)arrow_status})
	local arrows left=${arrow_status[1]} right=${arrow_status[2]}

	(( ${right:-0} > 0 )) && arrows+="${PURE_GIT_DOWN_ARROW:-⇣}"
	(( ${left:-0} > 0 )) && arrows+="${PURE_GIT_UP_ARROW:-⇡}"

	[[ -n $arrows ]] && prompt_pure_git_arrows=" ${arrows}"
}

prompt_pure_preexec() {
	prompt_pure_cmd_timestamp=$EPOCHSECONDS

	# tell the terminal we are setting the title
	print -Pn "\e]0;"
	# show hostname if connected through ssh
	[[ "$SSH_CONNECTION" != '' ]] && print -Pn "(%m) "
	# shows the current dir and executed command in the title when a process is active
	# (use print -r to disable potential evaluation of escape characters in cmd)
	print -nr "$PWD:t: $2"
	print -Pn "\a"
}

# string length ignoring ansi escapes
prompt_pure_string_length_to_var() {
	local str=$1 var=$2 length
	# perform expansion on str and check length
	length=$(( ${#${(S%%)str//(\%([KF1]|)\{*\}|\%[Bbkf])}} ))

	# store string length in variable as specified by caller
	typeset -g "${var}"="${length}"
}

prompt_pure_preprompt_render() {
	# check that no command is currently running, the preprompt will otherwise be rendered in the wrong place
	[[ -n ${prompt_pure_cmd_timestamp+x} && "$1" != "precmd" ]] && return

	# set color for git branch/dirty status, change color if dirty checking has been delayed
	local git_color=242
	[[ -n ${prompt_pure_git_last_dirty_check_timestamp+x} ]] && git_color=red

	# construct preprompt, beginning with path
	local preprompt="$(box_name) "
  preprompt+="%F{blue}%~%f"

  # git info
	preprompt+="%F{$git_color}${vcs_info_msg_0_}${prompt_pure_git_dirty}%f"
	# git pull/push arrows
	preprompt+="%F{cyan}${prompt_pure_git_arrows}%f"
	# username and machine if applicable
	preprompt+=$prompt_pure_username
	# execution time
	preprompt+="%F{yellow}${prompt_pure_cmd_exec_time}%f"

	# if executing through precmd, do not perform fancy terminal editing
	if [[ "$1" == "precmd" ]]; then
		print -P "\n${preprompt}"
	else
		# only redraw if preprompt has changed
		[[ "${prompt_pure_last_preprompt}" != "${preprompt}" ]] || return

		# calculate length of preprompt and store it locally in preprompt_length
		integer preprompt_length lines
		prompt_pure_string_length_to_var "${preprompt}" "preprompt_length"

		# calculate number of preprompt lines for redraw purposes
		(( lines = ( preprompt_length - 1 ) / COLUMNS + 1 ))

		# calculate previous preprompt lines to figure out how the new preprompt should behave
		integer last_preprompt_length last_lines
		prompt_pure_string_length_to_var "${prompt_pure_last_preprompt}" "last_preprompt_length"
		(( last_lines = ( last_preprompt_length - 1 ) / COLUMNS + 1 ))

		# clr_prev_preprompt erases visual artifacts from previous preprompt
		local clr_prev_preprompt
		if (( last_lines > lines )); then
			# move cursor up by last_lines, clear the line and move it down by one line
			clr_prev_preprompt="\e[${last_lines}A\e[2K\e[1B"
			while (( last_lines - lines > 1 )); do
				# clear the line and move cursor down by one
				clr_prev_preprompt+='\e[2K\e[1B'
				(( last_lines-- ))
			done

			# move cursor into correct position for preprompt update
			clr_prev_preprompt+="\e[${lines}B"
		# create more space for preprompt if new preprompt has more lines than last
		elif (( last_lines < lines )); then
			# move cursor using newlines because ansi cursor movement can't push the cursor beyond the last line
			printf $'\n'%.0s {1..$(( lines - last_lines ))}

			# redraw the prompt since it has been moved by print
			zle && zle .reset-prompt
		fi

		# disable clearing of line if last char of preprompt is last column of terminal
		local clr='\e[K'
		(( COLUMNS * lines == preprompt_length )) && clr=

		# modify previous preprompt
		print -Pn "\e7${clr_prev_preprompt}\e[${lines}A\e[1G${preprompt}${clr}\e8"
	fi

	# store previous preprompt for comparison
	prompt_pure_last_preprompt=$preprompt
}

prompt_pure_precmd() {
	# check exec time and store it in a variable
	prompt_pure_check_cmd_exec_time

	# by making sure that prompt_pure_cmd_timestamp is defined here the async functions are prevented from interfering
	# with the initial preprompt rendering
	prompt_pure_cmd_timestamp=

	# check for git arrows
	prompt_pure_check_git_arrows

	# tell the terminal we are setting the title
	print -Pn "\e]0;"
	# show hostname if connected through ssh
	[[ "$SSH_CONNECTION" != '' ]] && print -Pn "(%m) "
	# shows the full path in the title
	print -Pn "%~\a"

	# get vcs info
	vcs_info

	# preform async git dirty check and fetch
	prompt_pure_async_tasks

	# print the preprompt
	prompt_pure_preprompt_render "precmd"

	# remove the prompt_pure_cmd_timestamp, indicating that precmd has completed
	unset prompt_pure_cmd_timestamp
}

# fastest possible way to check if repo is dirty
prompt_pure_async_git_dirty() {
	local untracked_dirty=$1; shift

	# use cd -q to avoid side effects of changing directory, e.g. chpwd hooks
	cd -q "$*"

	if [[ "$untracked_dirty" == "0" ]]; then
		command git diff --no-ext-diff --quiet --exit-code
	else
		test -z "$(command git status --porcelain --ignore-submodules -unormal)"
	fi

	(( $? )) && echo "*"
}

prompt_pure_async_git_fetch() {
	# use cd -q to avoid side effects of changing directory, e.g. chpwd hooks
	cd -q "$*"

	# set GIT_TERMINAL_PROMPT=0 to disable auth prompting for git fetch (git 2.3+)
	GIT_TERMINAL_PROMPT=0 command git -c gc.auto=0 fetch
}

prompt_pure_async_tasks() {
	# initialize async worker
	((!${prompt_pure_async_init:-0})) && {
		async_start_worker "prompt_pure" -u -n
		async_register_callback "prompt_pure" prompt_pure_async_callback
		prompt_pure_async_init=1
	}

	# store working_tree without the "x" prefix
	local working_tree="${vcs_info_msg_1_#x}"

	# check if the working tree changed (prompt_pure_current_working_tree is prefixed by "x")
	if [[ ${prompt_pure_current_working_tree#x} != $working_tree ]]; then
		# stop any running async jobs
		async_flush_jobs "prompt_pure"

		# reset git preprompt variables, switching working tree
		unset prompt_pure_git_dirty
		unset prompt_pure_git_last_dirty_check_timestamp

		# set the new working tree and prefix with "x" to prevent the creation of a named path by AUTO_NAME_DIRS
		prompt_pure_current_working_tree="x${working_tree}"
	fi

	# only perform tasks inside git working tree
	[[ -n $working_tree ]] || return

	# do not preform git fetch if it is disabled or working_tree == HOME
	if (( ${PURE_GIT_PULL:-1} )) && [[ $working_tree != $HOME ]]; then
		# tell worker to do a git fetch
		async_job "prompt_pure" prompt_pure_async_git_fetch "${working_tree}"
	fi

	# if dirty checking is sufficiently fast, tell worker to check it again, or wait for timeout
	integer time_since_last_dirty_check=$(( EPOCHSECONDS - ${prompt_pure_git_last_dirty_check_timestamp:-0} ))
	if (( time_since_last_dirty_check > ${PURE_GIT_DELAY_DIRTY_CHECK:-1800} )); then
		unset prompt_pure_git_last_dirty_check_timestamp
		# check check if there is anything to pull
		async_job "prompt_pure" prompt_pure_async_git_dirty "${PURE_GIT_UNTRACKED_DIRTY:-1}" "${working_tree}"
	fi
}

prompt_pure_async_callback() {
	local job=$1
	local output=$3
	local exec_time=$4

	case "${job}" in
		prompt_pure_async_git_dirty)
			prompt_pure_git_dirty=$output
			prompt_pure_preprompt_render

			# When prompt_pure_git_last_dirty_check_timestamp is set, the git info is displayed in a different color.
			# To distinguish between a "fresh" and a "cached" result, the preprompt is rendered before setting this
			# variable. Thus, only upon next rendering of the preprompt will the result appear in a different color.
			(( $exec_time > 2 )) && prompt_pure_git_last_dirty_check_timestamp=$EPOCHSECONDS
			;;
		prompt_pure_async_git_fetch)
			prompt_pure_check_git_arrows
			prompt_pure_preprompt_render
			;;
	esac
}

prompt_pure_setup() {
	# prevent percentage showing up
	# if output doesn't end with a newline
	export PROMPT_EOL_MARK=''

	prompt_opts=(subst percent)

	zmodload zsh/datetime
	zmodload zsh/zle
	autoload -Uz add-zsh-hook
	autoload -Uz vcs_info
	autoload -Uz async && async

	add-zsh-hook precmd prompt_pure_precmd
	add-zsh-hook preexec prompt_pure_preexec

	zstyle ':vcs_info:*' enable git
	zstyle ':vcs_info:*' use-simple true
	# only export two msg variables from vcs_info
	zstyle ':vcs_info:*' max-exports 2
	# vcs_info_msg_0_ = ' %b' (for branch)
	# vcs_info_msg_1_ = 'x%R' git top level (%R), x-prefix prevents creation of a named path (AUTO_NAME_DIRS)
	zstyle ':vcs_info:git*' formats ' %b' 'x%R'
	zstyle ':vcs_info:git*' actionformats ' %b|%a' 'x%R'

	# if the user has not registered a custom zle widget for clear-screen,
	# override the builtin one so that the preprompt is displayed correctly when
	# ^L is issued.
	if [[ $widgets[clear-screen] == 'builtin' ]]; then
		zle -N clear-screen prompt_pure_clear_screen
	fi

	# show username@host if logged in through SSH
	[[ "$SSH_CONNECTION" != '' ]] && prompt_pure_username=' %F{242}%n@%m%f'

	# show username@host if root, with username in white
	[[ $UID -eq 0 ]] && prompt_pure_username=' %F{white}%n%f%F{242}@%m%f'

	# prompt turns red if the previous command didn't exit with 0
	PROMPT="%(?.%F{magenta}.%F{red})${PURE_PROMPT_SYMBOL:-❯}%f "
}

prompt_pure_setup "$@"
