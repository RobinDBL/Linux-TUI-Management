#!/bin/bash
###################
#Author: Robin Deblauwe
#Repository: github.com/RobinDBL/
#Script to check system resources
#works on both RPM based systems as on DEB based systems

######################################################################################
#General functions for output

function header(){
	echo "##########Check system resources##########"
	echo "##########$HOSTNAME##########"
}

function continue(){
	read -p "Press enter to continue" continue
}

function incorrect_argument(){
	echo "Incorrect argument entered, please try again"
	continue
}


#######################################################################################
#General functions

#Get kernel version
function get_kernel_version(){
	echo ""
	echo "Kernel version: "
	uname -r
	echo ""
}

#Get ram usage in readable form
function get_ram_usage(){
	echo ""
	echo "Ram usage: "
	free -h
	echo ""
}

#Get ip address
function get_network_info(){
	echo ""
	echo "Network info: "
	ip addr show | grep 'inet ' | grep -v ' lo' #Get ip address, filter out junk & remove loopback adapter
	echo ""
}

#Get disk usage
function get_disk_usage(){
	echo ""
	echo "Disk usage: "
	df -h /dev/sd* #Filter out most non /dev/sd*
	echo ""
}

#execute a script
function execute_script(){
	read -p "Enter the script path, enter 'stop'(lowercase) to cancel" path
	if [ "$path" != "stop" ]
	then
		bash $path
	fi
}

#Get cpu usage and model name
function get_cpu_usage(){
	echo ""
	echo "CPU"
	cat /proc/cpuinfo | grep 'model name'
	echo "CPU usage in %: "
	top -b -n1 -p 1 | grep 'Cpu' | cut -f 6 -d ' '
	echo ""
}

#Install a package
#Check system type first
function install_package(){
	echo "Trying to install package $1"
	if dpkg -S /bin/ls >/dev/null 2>&1
		#Debian based systems
		then
		  sudo apt-get install $1
	elif rpm -q -f /bin/ls >/dev/null 2>&1
		#RPM based systems
		then
		  sudo yum install $1 #This can also be DNF. Picked yum for servers.
	else
		  echo "Don't know this package system (neither RPM nor DEB)."
		  exit 1
	fi
}

#Remove a package
#Check system type again first
function remove_package(){
	echo "Trying to delete package $1"
	if dpkg -S /bin/ls >/dev/null 2>&1
		#Debian based systems
		then
		  sudo apt-get remove $1
	elif rpm -q -f /bin/ls >/dev/null 2>&1
		#RPM based systems
		then
		  sudo yum remove $1
	else
		  echo "Don't know this package system (neither RPM nor DEB)."
		  exit 1
	fi
}

#Search a package
#Check system type first
function search_package(){
	echo "trying to search package $1"
	if dpkg -S /bin/ls >/dev/null 2>&1
		#Debian based systems
		then
		  sudo apt-get search $1
	elif rpm -q -f /bin/ls >/dev/null 2>&1
		#RPM based systems
		then
		  sudo yum search $1
	else
		  echo "Don't know this package system (neither RPM nor DEB)."
		  exit 1
	fi
}

#Update the repository
#Only needed for deb based systems
function update_repository(){
	echo "trying to update repository"
	if dpkg -S /bin/ls >/dev/null 2>&1
		#Debian based systems
		then
		  sudo apt-get update
	elif rpm -q -f /bin/ls >/dev/null 2>&1
		#RPM based systems
		then
		  echo "RPM based system does not need to update the repository list."
	else
		  echo "Don't know this package system (neither RPM nor DEB)."
		  exit 1
	fi
}

#Get the temperature reading of the cpu sensors.
#Check if package is installed first
#if not, install package
function get_sensor_reading(){
	if dpkg -S /bin/ls >/dev/null 2>&1
		#Debian based systems
		then
		  if dpkg-query -W -f='${Status} ${Version}\n' lm-sensors >/dev/null 2>&1
		  	#If package is installed
		  then
		  	sensors | grep 'Core'
	  		else
	  			#if package is not installed
	  			#install package
	  			echo "package lm-sensors is not installed, installing now"
	  			install_package lm-sensors
			fi
	elif rpm -q -f /bin/ls >/dev/null 2>&1
		#RPM based systems
		then
		  if rpm -q lm_sensors #note, rpm packe is lm_sensors, not with a '-'
		  	#If package is installed
			then
			    sensors | grep 'Core'
			else
				#If packe is not installed
				#install package
	  			echo "package lm_sensors is not installed, installing now"
	  			install_package lm_sensors
			fi
	else
		  echo "Don't know this package system (neither RPM nor DEB)."
		  exit 1
	fi
}

#ping a system 4 times.
function ping_system(){
	ping $1 -c 4
}

##################################################################################################
#The menus

#Submenu for package-control
function packages_menu(){
while :
	do
	clear
	echo "Choose one of the following: "
	echo "1) Install a package"
	echo "2) Remove a package"
	echo "3) search a package in the repository list"
	echo "4) Update the repository list"
	echo "0) Back to main menu"

	#Ask for input
	read -p "Enter your choice: " input

	#ask for packe name if needed
	if [[ $input -ne 0 ]] && [[ $input -ne 4 ]]
	then
		read -p "Enter the correct name of the package: " package
	
	fi
	
	case $input in
			#Install package
			1)
				clear
				install_package $package
				continue
			;;

			#Delete package
			2)
				clear
				echo "Deleting package $package..."
				remove_package $package
				echo "Package $package was removed succesfully."
				continue
			;;

			#Search package
			3)
				clear
				echo "Searching package $package..."
				search_package $package
				continue
			;;

			#Update repository list
			4)
				clear
				echo "Updating repository list"
				update_repository
				continue
			;;

			#Back to main menu
			0)
				break
			;;

			#default
			*)
				incorrect_argument
			;;
		esac
	done
}

#Submenu for service-control
function services_menu(){
	while :
	do
	clear
	echo "Choose one of the following: "
	echo "1) see the status of a service"
	echo "2) Stop a service"
	echo "3) Start a service"
	echo "4) Restart a service"
	echo "5) Enable the starting of a service on boot"
	echo "6) Disable the starting of a service on boot"
	echo "0) Back to main menu"

	#Ask for input
	read -p "Enter your choice: " input

	#Ask servicename if needed
	if [[ $input -ne 0 ]]
	then
		read -p "Enter the servicename: " service
	
	fi
	case $input in
			#Get service status
			1)
				clear
				systemctl status $service --no-pager
				continue
			;;

			#stop service
			2)
				clear
				echo "Stopping $service..."
				systemctl stop $service
				echo "$service was succesfully stopped"
				continue
			;;

			#start service
			3)
				clear
				echo "Starting $service..."
				systemctl start $service
				echo "$service was succesfully started"
				continue
			;;

			#restart service
			4)
				clear
				echo "$service restarting..."
				systemctl restart $service
				echo "$service was succesfully restarted"
				continue
			;;

			#enable service on boot
			5)
				clear
				echo "Enabeling $service"
				systemctl enable $service
				echo "$service was succesfully enabled"
				continue
			;;

			#disable service on boot
			6)
				clear
				echo "Disabeling $service"
				systemctl disable $service
				echo "$service was succesfully disabled"
				continue
			;;

			#Back to main menu
			0)
				break
			;;

			#default
			*)
				incorrect_argument
			;;
		esac
	done
}

function script_logic(){
	while :
	do
		clear
		header
		echo "Choose one of the following: "
		echo "1) Netwerk info"
		echo "2) Disk usage"
		echo "3) RAM usage"
		echo "4) CPU usage"
		echo "5) kernel version"
		echo "6) execute a script"
		echo "7) start / stop / restart / enable / disable services"
		echo "8) Install / remove / update a package"
		echo "9) ping a system"
		echo "10) uptime"
		echo "11) Check logged in users"
		echo "0) Stop script"


		#Get user input
		read -p "Enter your choice: " input

		case $input in
			#Get network info
			1)
				clear
				get_network_info
				continue
			;;

			#disk usage
			2)
				clear
				get_disk_usage
				continue
			;;

			#RAM usage
			3)
				clear
				get_ram_usage
				continue
			;;

			#CPU usage + sensor readings
			4)
				clear
				get_cpu_usage
				get_sensor_reading
				continue
			;;

			#Kernel version
			5)
				clear
				get_kernel_version
				continue
			;;

			#execute script
			6)
				clear
				execute_script
				continue
			;;

			#go to services submenu
			7)
				clear
				services_menu
				continue
			;;

			#go to packages submenu
			8)
				clear
				packages_menu
				continue
			;;

			#ping a system
			9)
				clear
				#Ask for the ip
				read -p "Enter the ip of the system to ping: [x.x.x.x] " ip
				ping_system $ip
				continue
			;;

			#check uptime
			10)
				clear
				uptime
				continue
			;;

			#Check logged in users
			11)
				clear
				users
				continue
			;;

			#stop script
			0)
				clear
				echo "Thank you and goodbye"
				continue
				clear
				exit 1
			;;

			#default
			*)
				incorrect_argument
			;;
		esac
	done
}

#Start the main menu
script_logic