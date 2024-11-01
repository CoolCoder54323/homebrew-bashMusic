#!/bin/bash/

#Check dependencies

codeName=$(uname -s)
echo $OS
case $codeName in
	Darwin)
		OS=mac
		;;
	Linux)
		OS=linux
		;;
	*)
		OS=linux
		;;
esac
echo $OS
for dep in sox ffmpeg; do
	check=$(whereis -q $dep)
	if [ -z "$check" ]; then
		echo "'$dep' is not installed. Would you like to (yes/no)"
		read -n 10 install
		if [ "yes" = $install ];then
			echo "$dep dkpdwddw"
			[ $OS = linux ] && sudo apt-get -y install $dep || [ $OS = mac ] && echo "mac install" && brew install $dep 
		else
			exit 1
		fi

	fi
done

