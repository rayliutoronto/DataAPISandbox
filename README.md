# Local Development Environment with DataAccess API & Server Side Javascript (Nashorn) Debugger
Thanks [Vagrant](https://www.vagrantup.com/), [VirtualBox](https://www.virtualbox.org/) and [ncdbg](https://github.com/provegard/ncdbg)
* Step 1: install [Vagrant](https://www.vagrantup.com/downloads.html), or follow installation procedure on platform, like on Ubuntu 16.04: `sudo apt-get install vagrant`
* Step 2: install [VirtualBox](https://www.virtualbox.org/wiki/Downloads), or follow installation procedure on platform, like on Ubuntu 16.04: `sudo apt-get install virtualbox`
* Step 3: rename user.conf.bak to user.conf, and set domain username, password and github username, password, respectively
* Step 4: execute cmd: `vagrant up` to start local server instance. You need to set proxy for your terminal/PowerShell/cmd. And If you are using Windows 7, please consider to upgrade PowerShell to 3.0: https://www.microsoft.com/en-us/download/details.aspx?id=34595 when you find the process hangs on.
    * Config API on Bugatti is used, all changes done on [Config UI on SIT](https://was-intra-sit.toronto.ca/webapps/c3api-selfserv/) takes affect on this local instance as well
    * database on SIT is used, all changes are shared on Bugatti, SIT and this local server instance
    * tomcat 8.5 and java 8 is setup, and API is built and deployed
* Step 5: after first time load, which takes several minutes, Data API is on [http://localhost:8888/c3api_data/v2/DataAccess.svc](http://localhost:8888/c3api_data/v2/DataAccess.svc), server side javascript debugger is on chrome-devtools://devtools/bundled/inspector.html?experiments=true&v8only=true&ws=localhost:7778/dbg
    * open `chrome-devtools://devtools/bundled/inspector.html?experiments=true&v8only=true&ws=localhost:7778/dbg` on Google Chrome
* Step 6: once codebase of Data API has changes, execute cmd: `vagrant provision`, the latest API is built and deployed
* Step 7: stop everything: `vagrant halt`


Screenshot of Server Side Javascript Debugger, for [example 2](https://github.com/CityofToronto/c3api_data/wiki/Advanced:-Extension#example-2):
![](https://raw.githubusercontent.com/rayliutoronto/DataAPISandbox/master/doc/ServerSideJS_Debug.PNG)
