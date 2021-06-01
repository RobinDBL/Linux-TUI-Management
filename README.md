# Linux-TUI-Management
A script to automate and simplify simple system tasks, such as service control, package control, system monitoring,
pinging etc.
This script works for RPM and DEB systems. (Tested on CentOS & Fedora & Ubuntu)

## Installation
<ol>
<li>Download this repository to your system.</li>
  <li>Copy this script to the <code>/bin</code> or the <code>~/bin</code> folder.</li>
  If you want this script to be system wide accessible, copy it to the <code>/bin</code> folder.
  If you want this script to be accessible by only your user, copy it to the <code>~/bin</code> folder.

  <li>If you want to run the script without <code>*.sh</code> extension or without the <code>./</code> or <code>bash</code> commands, move it to one of the above folders and remove the <code>.sh</code> from the filename.
<li>Make sure the script is executable by <code>chmod +x {scriptname}</code></li>
</ol>

Note: If the script requires packages, it will install them using the included package control.
Warning: The included package control does use the default package managers (RPM: yum & DEB: apt-get).

## Usage

Run the script. All output is shown on the console (if possible tui). 
Give the script input where needed.

## Functions
<ul>
  <li>Check the cpu-, ram-, disk-usage and network info all with one command</li>
  <li>List only the network info</li>
  <li>List only the disk usage</li>
  <li>List only the ram usage</li> 
  <li>List only the CPU usage</li>
  <li>List the Kernel version</li>
  <li>Execute a script by giving a path to the script</li>
  <li>Service management
    <ul>
      <li>Check the status of a service</li>
      <li>Start a service</li>
      <li>Stop a service</li>
      <li>Restart a service</li>
      <li>Enable a service</li>
      <li>Disable a service</li>
      <li>List all available services</li>
      <li>List all running services</li>
    </ul>
  </li>
  <li> Manage packages
    <ul>
      <li>Install a package</li>
      <li>Remove a package</li>
      <li>Search a package in the repository list</li>
      <li>Update the repository list</li>
      <li>Update all packages</li>
      <li>Update one package</li>
      <li>List all packages that have updates</li>
    </ul>
  </li>
  <li>Ping a system</li>
  <li>Check the uptime</li>
  <li>Check logged in users</li>
  <li>Reboot the system</li>
  <li>Shut down the system</li>
</ul>

## Requirements
For the Tui is the package <code>dialog</code> required. The system will try to install it automatically. If it does not find it, it will use the integrated submenu's.

## Screenshots
example: first item:

![image](https://user-images.githubusercontent.com/73343961/120290569-bfaa8700-c2c2-11eb-8953-d4b9679826fe.png)

action:

![image](https://user-images.githubusercontent.com/73343961/120291003-2891ff00-c2c3-11eb-8bf8-0ee41825c5e8.png)

sometimes submenu: action 7:

![image](https://user-images.githubusercontent.com/73343961/120290645-d650de00-c2c2-11eb-82af-a6fe935e611e.png)

![image](https://user-images.githubusercontent.com/73343961/120290609-cb964900-c2c2-11eb-9419-c47a808fd7a5.png)







