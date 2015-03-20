#!/bin/bash

EDITOR="${vi:-nano}"

while getopts "edr:m:c" opt; do
	case $opt in
	e) eoption=1;;
	d) doption=1;;	

	r) recipient=$OPTARG; defineto=1;;
	m) message=$OPTARG; definemsg=1;;
	c) xclip=1;;
esac
done

function on_exit {
	rm -rf "$dmsg" "$emsg"
}

trap on_exit EXIT

dmsg="$(mktemp)"
emsg="$(mktemp)"

# Mutually Exclusive
if [ "$eoption" = "$doption" ]; then 
	echo "please choose one option"
	exit
fi

# Write an Encrypted message
if [ "$eoption" = "1" ]; then
	if [ "$defineto" = "1" ]; then
		if ! [ "$definemsg" = "1" ]; then
			echo "write your msg:"
			read message
			echo
		fi
	else
		echo "send msg to:"
		read recipient
		if ! [ "$definemsg" = "1" ]; then
			echo "write your msg:"
			read message
		fi
	fi
	echo "$message" >| "$dmsg"
        gpg -r $recipient -o $emsg --batch --yes -a -e $dmsg &> /dev/null
	echo "your encrypted msg:"
	if [ "$xclip" = "1" ]; then
		echo "$(cat $emsg)" | xclip &> /dev/null
	else 
		cat $emsg
	fi

# Decrypt and Read a message
elif [ "$doption" = "1" ]; then
	$EDITOR $emsg
	gpg -o $dmsg --batch --yes -d  $emsg &> /dev/null
	echo
	echo "your decrypted msg:"
	cat $dmsg
	echo
fi
