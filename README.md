# Linux-System-Resources
A script to automate and simplify simple system tasks, such as service control, package control, system monitoring,
pinging etc.
This script works for RPM and DEB systems. (Tested on CentOS & Fedora & Ubuntu)

## Installation
<ol>
<li>Download this repository to your system.</li>
  <li>Copy this script to the <code>/bin</code> or the <code>~/bin</code> folder.</li>
  If you want this script to be system wide accessible, copy it to the <code>/bin</code> folder
  If you want this script to be accessible by only your user, copy it to the <code>~/bin</code> folder.

  <li>If you want to run the script without <code>*.sh</code> extension or without the <code>./</code> or <code>bash</code> commands, move it to one of the above folders and remove the <code>.sh</code> from the filename.
<li>Make sure the script is executable by <code>chmod +x {scriptname}</code></li>
</ol>

Note: If the script requires packages, it will install them using the included package control.
Warning: The included package control does use the default package managers.

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
<li>disable a service</li>
</ul>
</li>
<li> Manage packages
<ul>
<li>Install a package</li>
<li>Remove a package</li>
<li>Search a package in the repository list</li>
<li>Update the repository list</li>
<li>Update all packages</li>
</ul>
</li>

<li>Ping a system</li>
<li>Check the uptime</li>
<li>Check logged in users</li>

</ul>

## Requirements
For the Tui is the package <code>dialog</code> required. The system will try to install it automatically. If it does not find it, it will use the integrated submenu's.

## Screenshots
example: first item:

![image](https://user-images.githubusercontent.com/73343961/120112174-09855700-c175-11eb-92ee-983fdb13529c.png)

action:

![image](https://user-images.githubusercontent.com/73343961/120112189-1a35cd00-c175-11eb-9c23-186112ff89b3.png)

sometimes submenu: action 7:

![image](https://user-images.githubusercontent.com/73343961/120112200-29b51600-c175-11eb-94af-26f181026806.png)

![image](https://user-images.githubusercontent.com/73343961/120112209-30438d80-c175-11eb-81dd-687ba150dea1.png)







