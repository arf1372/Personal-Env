# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.tar.xz)    tar xvf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Prints codes for terminal colours
colours() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

# Functions to help logging in to university of tehran's internet access hotspot with a headless system
ut_hotspot_login () {
	wget --save-cookies=.hotspot_cookies --keep-session-cookies --post-data="user=$1&password=$2" "https://internet.ut.ac.ir/login"

	if [ $? -eq 0 ]; then
	  echo "Logged in successfully."
	else
	  echo "Login failed."
	fi

	rm login
}

ut_hotspot_logout () {
	wget --save-cookies=.hotspot_cookies --keep-session-cookies "https://internet.ut.ac.ir/logout"

	if [ $? -eq 0 ]; then
	  echo "Logged out successfully."
	else
	  echo "Logout failed."
	fi

	rm logout
}

# Securely deletes all files in a given folder
shred_dir () {
	RNG_FNAME="$(uuidgen | sed -r -e s"/([[:alnum:]]+)-.*$/\1/")"
	RNG_FILE="/tmp/rng_fifo_$RNG_FNAME"

	mkfifo $RNG_FILE
	gpg --gen-random 2 >> $RNG_FILE &

	find $1 -type f -execdir shred -n 3 --random-source=$RNG_FILE -z -u --remove {} \+
	rm -rf $1
	echo "shred of directory $1 finished!"
	kill $!
	rm $RNG_FILE
}
