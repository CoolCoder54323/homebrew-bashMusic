

codeName=$(uname -s)
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
for dep in sox ffmpeg; do
	check=$(whereis -q $dep)
	if [ -z "$check" ]; then
		echo "'$dep' is not installed. Would you like to (yes/no)"
		read -n 10 install
		if [ "yes" = $install ]; then
			[ $OS = linux ] && sudo apt-get -y install $dep || [ $OS = mac ] && echo "mac install" && brew install $dep 
		else
			exit 1
		fi

	fi
done

