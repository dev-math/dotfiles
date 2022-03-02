#!/usr/bin/env bash

function msg() {
  local text="$1"
  local div_width="80"
  printf "%${div_width}s\n" ' ' | tr ' ' -
  printf "%s\n" "$text"
}

function print_missing_dep_msg() {
  echo "[ERROR]: Unable to find dependency [$1]"
  echo "Please install it first and re-run the installer."
}

print_line() {
	printf "%$(tput cols)s\n" | tr ' ' '-'
}

pause_function() {
	print_line
	if [[ $AUTOMATIC_MODE -eq 0 ]]; then
		read -e -sn 1 -p "Press enter to continue..."
	fi
}

invalid_option() {
	print_line
	echo "Invalid option. Try another one."
	pause_function
}

prompt1="Enter your option: "
prompt2="Enter n° of options (ex: 1 2 3 or 1-3): "

read_input() {
	printf "%s" "$prompt1"
	read -r OPTION
}

read_input_options() {
	local line
	local packages

  printf "%s" "$prompt2"
  read -r OPTION
  IFS=' ' read -r -a array <<<"${OPTION}"

	for line in "${array[@]/,/ }"; do
		if [[ ${line/-/} != "$line" ]]; then
			for ((i = ${line%-*}; i <= ${line#*-}; i++)); do
				packages+=("$i")
			done
		else
			packages+=("$line")
		fi
	done
	OPTIONS=("${packages[@]}")
}
