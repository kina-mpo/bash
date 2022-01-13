#!/bin/bash

function lock {
	if [ -e $LOCKFILE ] ; then
		LOCKPID=$(cat $LOCKFILE)
		if ps $LOCKPID >/dev/null ; then
			return 1
		else
			echo "$$" > $LOCKFILE
			return 0
		fi
	else
		echo "$$" > $LOCKFILE
		return 0
	fi
}

function unlock {
	if [ -e $LOCKFILE ] ; then
		rm $LOCKFILE
		return 0
	else
		return 1
	fi
}

function stage {
	if [ -n $STAGE ] ; then
		STAGE=$((STAGE+1))
	else
		STAGE=1
	fi
	if [ $STAGE -lt 10 ] ; then
		echo -e "[${CYAN}0${STAGE}${RESET}] STAGE - $1"
	else
		echo -e "[${CYAN}${STAGE}${RESET}] STAGE - $1"
	fi
}

function OK {
	echo -e "$OK $1"
	return 0
}

function KO {
	echo -e "$KO $1"
	return 1
}
