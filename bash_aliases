alias dns='host'
alias sl='ls'
alias fix='reset'
alias tracert="traceroute -A"
alias apt-cahce='apt-cache'
alias mv='mv -i'
alias cp='cp -i'

mkcd() {
	mkdir -p $1 && cd $1
}

# Remove trailing whitespace from file
rtrail() {
	sed -i 's/\s*$//g' $*
}
