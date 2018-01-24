If you are using Windows 7, please consider to upgrade PowerShell to 3.0: https://www.microsoft.com/en-us/download/details.aspx?id=34595

* Step 1: install [Vagrant](https://www.vagrantup.com/downloads.html), or follow installation procedure on platform, like on Ubuntu: sudo `apt-get install vagrant`
* Step 2: install [VirtualBox](https://www.virtualbox.org/wiki/Downloads), or follow installation procedure on platform, like on Ubuntu: `sudo apt-get install virtualbox`
* Step 3: rename user.conf.bak to user.conf, and set domain username, password and github username, password, respectively
* Step 4: execute cmd: `vagrant up`. You need to set proxy for your terminal/PowerShell/cmd.
* Step 5: after first time load, which takes several minutes, Data API is on [http://localhost:8888/c3api_data/v2/DataAccess.svc](http://localhost:8888/c3api_data/v2/DataAccess.svc), server side javascript debugger is on chrome-devtools://devtools/bundled/inspector.html?experiments=true&v8only=true&ws=localhost:7778/dbg
    * open `chrome-devtools://devtools/bundled/inspector.html?experiments=true&v8only=true&ws=localhost:7778/dbg` on Google Chrome
* Step 6: once codebase of Data API has changes, execute cmd: `vagrant provision`


Screenshot of Server Side Javascript Debugger:
![](https://raw.githubusercontent.com/rayliutoronto/DataAPISandbox/master/doc/ServerSideJS_Debug.PNG)
