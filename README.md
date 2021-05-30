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
<li>

<li>Make sure the script is executable by <code>chmod +x {scriptname}</code></li>
</ol>

Note: If the script requires packages, it will install them using the included package control.
Warning: The included package control does use the default package managers.

## Utilisation

Run the script. All output is shown on the console. 
Give the script input where needed.
