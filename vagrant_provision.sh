sudo -i

while read line
do
    if echo $line | grep -F = &>/dev/null
    then
        varname=$(echo "$line" | cut -d '=' -f 1)
        varval=$(echo "$line" | cut -d '=' -f 2- | tr '\r' ' ')
        export $varname=$varval
        #echo $varname=$varval
    fi
done < /vagrant/user.conf

echo "==========set proxy=========="
export http_proxy="http://$domainUser:$domainPassword@proxy.toronto.ca:8080/"
export https_proxy="http://$domainUser:$domainPassword@proxy.toronto.ca:8080/"
echo http_proxy="http://$domainUser:$domainPassword@proxy.toronto.ca:8080/" >> /etc/environment
echo https_proxy="http://$domainUser:$domainPassword@proxy.toronto.ca:8080/" >> /etc/environment
. /etc/environment


if  ! [ -x "$(command -v java)" ]; then
	echo "==========installing Oracle java 8=========="
	apt-get install -y software-properties-common python-software-properties
	echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
	add-apt-repository ppa:webupd8team/java -y
	apt-get update
	apt-get install oracle-java8-installer -y
	echo "==========Setting environment variables for Java 8=========="
	apt-get install -y oracle-java8-set-default
	echo "==========Java Home: " $JAVA_HOME "=========="
fi

if  ! [ -x "$(command -v git)" ]; then
	echo "==========installing git=========="
	apt-get update
	apt-get install git-core -y
fi

if  [ ! -d "/opt/gradle" ]; then
	echo "==========install gradle=========="
	apt-get install unzip -y
	mkdir /opt/gradle
	unzip -d /opt/gradle /vagrant/data/gradle/gradle-4.2.1-bin.zip
	echo "export PATH=$PATH:/opt/gradle/gradle-4.2.1/bin" >> ~/.bashrc
	source ~/.bashrc
fi



if  [ ! -d "/opt/tomcat" ]; then
	echo "==========Installing Tomcat=========="
	groupadd tomcat
	useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
	mkdir /opt/tomcat
	tar xvf /vagrant/data/tomcat/apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1
	cp /vagrant/data/tomcat/lib/* /opt/tomcat/lib
	chgrp -R tomcat /opt/tomcat
	chown -R tomcat /opt/tomcat
	chmod -R 755 /opt/tomcat
	cp /vagrant/data/tomcat/tomcat.service /etc/systemd/system/
	cp /vagrant/data/tomcat/manager/context.xml /opt/tomcat/webapps/manager/META-INF/
	cp /vagrant/data/tomcat/server.xml /opt/tomcat/conf
	cp /vagrant/data/tomcat/context.xml /opt/tomcat/conf
	sed -i "s#</tomcat-users>#  <role rolename=\"manager-gui\"/><role rolename=\"admin-gui\"/><user username=\"admin\" password=\"admin\" roles=\"admin-gui,manager-gui\"/>\n</tomcat-users>#" /opt/tomcat/conf/tomcat-users.xml
	systemctl daemon-reload
	systemctl restart tomcat
	systemctl status tomcat
	systemctl enable tomcat

	#cp /vagrant/data/ncdbg-0.6.0/bin/ncdbg.service /etc/systemd/system/
	#systemctl daemon-reload
	#systemctl restart ncdbg
	#systemctl status ncdbg
	#systemctl enable ncdbg
fi

echo "==========Pulling source code=========="
if [ ! -d ~/git ]; then
	mkdir ~/git
	cd ~/git
	git clone https://${githubUser//@/%40}:$githubPassword@github.com/CityofToronto/c3api_data.git
	cd c3api_data
	git checkout master
fi
cd ~/git/c3api_data
git pull
/opt/gradle/gradle-4.2.1/bin/gradle clean war
cp build/libs/c3api_data.war /vagrant/data/app
cp build/libs/c3api_data.war /opt/tomcat/webapps

echo "restarting tomcat....."
systemctl restart tomcat
echo "restarting SSJS debugger....."
/vagrant/data/ncdbg-0.6.0/bin/stop.sh
/vagrant/data/ncdbg-0.6.0/bin/start.sh