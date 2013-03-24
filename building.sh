#!/bin/sh

#Before running the script, copy it to home, check if the machine is connected to internet, mount the partition Archive

# Useful commands:
# echo "senha" | sudo -S ./a.sh
# sudo -S su -c "passwd root" < passwd

# Remember:
# add extensions ; brighten the terminal ; add plugins in eclipse:
#(sheelEd - https://downloads.sourceforge.net/project/shelled/shelled/ShellEd%202.0.2/update and 
# Maven http://download.eclipse.org/technology/m2e/releases and
# create key ssh
# Heroku https://eclipse-plugin.herokuapp.com/install - doubts? -> https://devcenter.heroku.com/articles/getting-started-with-heroku-eclipse)

nameUser=diego
homeUser=/home/diego
folderScript=$homeUser/buildingMyAmbientLinux
folderDownload=$folderScript/Download
passSudo=$folderScript/passSudo
passwd=$folderScript/passwd
folderDevelopmentArquivo=/media/Arquivos/Start/Programas/Unix/Ubuntu/Desenvolvimento/Java
folderDevelopmentHome=$homeUser/Development
profile=/etc/profile

echo "=============================================="
echo "Download applications or use existing in buildingMyAmbientLinux/Download (y/n)?"
read installAplication

echo "=============================================="
echo "create passwd root"
echo ""
sudo -S passwd root < $passwd

echo "=============================================="
echo "add dependency"
echo ""
sudo -S add-apt-repository ppa:gnome3-team/gnome3 < $passSudo

echo "=============================================="
echo "Update System"
echo ""
sudo -S apt-get -y update --fix-missing < $passSudo

echo "=============================================="
echo "Add application by apt-get"
echo ""

echo "installing gnome-shell"
sudo -S apt-get install -y --force-yes gnome-shell < $passSudo

echo "installing vlc"
sudo -S apt-get install -y --force-yes vlc < $passSudo

echo "installing blueman"
sudo -S apt-get install -y --force-yes blueman < $passSudo
	
echo "installing apache2"
sudo -S apt-get install -y --force-yes apache2 < $passSudo
	
echo "installing Unetbootin"
sudo -S apt-get install -y --force-yes unetbootin < $passSudo

echo "installing Wine"
sudo -S apt-get install -y --force-yes wine1.4 < $passSudo

echo "installing git"
sudo -S apt-get install -y --force-yes git-core git-svn< $passSudo

echo "installing ssh"
sudo -S apt-get install -y --force-yes ssh< $passSudo
ssh-keygen -b 1024 -t rsa -P "" -f ~/.ssh/id_rsa

echo "installing curl"
sudo -S apt-get install -y --force-yes curl< $passSudo

echo "installing pptview"
sudo -S apt-get install -y --force-yes pptview< $passSudo

echo "installing axel"
sudo -S apt-get install -y --force-yes axel < $passSudo			

echo "installing vim"
sudo -S apt-get install -y --force-yes vim < $passSudo

echo "installing samba"
sudo -S apt-get install -y --force-yes samba < $passSudo

echo "installing wireshark"
sudo -S apt-get install -y --force-yes wireshark < $passSudo

echo "installing nmap"
sudo -S apt-get install -y --force-yes nmap < $passSudo

echo "installing rar"
sudo -S apt-get install -y --force-yes rar < $passSudo

echo "installing and configuring postgresql"
sudo -S apt-get install -y --force-yes postgresql < $passSudo
sudo -S passwd postgres < $passwd
sudo -S -u postgres psql -c "ALTER USER postgres PASSWORD 'postgres';" < passSudo 
sudo -S /etc/init.d/postgresql restart < passSudo 

echo "installing dependences of pgadmin"
sudo -S apt-get install -y --force-yes build-essential libxml2-dev libgtk2.0-dev libxslt1-dev libwxbase2.8-dev libwxgtk2.8-dev postgresql-server-dev-all < passSudo

cd $folderDownload

if [ "$installAplication" == "y" ]; then
echo "=============================================="
echo "Downloading application using wget and axel"
echo ""

wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb

axel -n 50 http://dlc.sun.com.edgesuite.net/virtualbox/4.2.4/virtualbox-4.2_4.2.4-81684~Ubuntu~quantal_i386.deb

axel -n 50 http://dlc.sun.com.edgesuite.net/virtualbox/4.2.4/Oracle_VM_VirtualBox_Extension_Pack-4.2.4-81684.vbox-extpack

wget -O - "https://www.dropbox.com/download?plat=lnx.x86" | tar xzf -
./.dropbox-dist/dropbox 

else
	echo "Installing applications folder download"	
fi

echo "=============================================="
echo "cleaning up broken dependencies"
echo ""
sudo -S apt-get install -f -y --force-yes < $passSudo

echo "=============================================="
echo "installing application"
echo ""
sudo -S su -c "dpkg -i google-chrome-stable_current_i386.deb && dpkg -i virtualbox-4.2_4.2.4-81684~Ubuntu~quantal_i386.deb && ./.dropbox-dist/dropboxd" < $passSudo

echo "=============================================="
echo "adding extension in virtualBox"
echo ""
sudo -S virtualbox Oracle_VM_VirtualBox_Extension_Pack-4.2.4-81684.vbox-extpack < $passSudo

sudo -S /etc/init.d/vboxdrv setup < $passSudo

echo "=============================================="
echo "adding user in groups (ps.: need to restart the machine to take effect)"
echo ""
sudo usermod -aG vboxusers $nameUser

echo "=============================================="
echo "Refactoring folder from home"
echo ""
sudo -S rm -R $homeUser/Documents $homeUser/Music $homeUser/Pictures $homeUser/Public  $homeUser/Templates $homeUser/Videos < $passSudo

mkdir $homeUser/tmp

echo "=============================================="
echo "config ambient of development"
echo ""

echo ""
echo "copying and uncompressing files"
echo ""

cp -R $folderDevelopmentArquivo $homeUser

tar -zxvf $homeUser/Development/zip\ file\ of\ the\ instalation/apache-maven-3.0.4-bin.tar.gz -C Development/

tar -zxvf $homeUser/Development/zip\ file\ of\ the\ instalation/apache-tomcat-7.0.29.tar.gz -C Development/

tar -zxvf $homeUser/Development/zip\ file\ of\ the\ instalation/eclipse-jee-juno-linux-gtk.tar.gz -C Development/

tar -zxvf $homeUser/Development/zip\ file\ of\ the\ instalation/pgadmin3-1.14.3.tar.gz -C Development/

tar -jxvf Development/zip\ file\ of\ the\ instalation/Sublime\ Text\ 2.0.1.tar.bz2 -C Development/ 

echo "=============================================="
echo "installing pgadmin"
echo ""

cd $folderDevelopmentHome/pgadmin3-1.14.3
./configure
make 
sudo -S make install < $passSudo

echo "=============================================="
echo "installing jdk"
echo ""

cd  $homeUser/Development/zip\ file\ of\ the\ instalation/

chmod +x jdk-6u33-linux-i586.bin

./jdk-6u33-linux-i586.bin

cp -R jdk1.6.0_33/ ../

sudo -S rm -R jdk1.6.0_33/ < $passSudo

echo "=============================================="
echo "creating links"
echo ""

cd /usr/bin

sudo -S ln $folderDevelopmentHome/jdk1.6.0_33/bin/java . -s
sudo -S ln $folderDevelopmentHome/jdk1.6.0_33/bin/javac . -s
sudo -S ln $folderDevelopmentHome/apache-maven-3.0.4/bin/mvn . -s
sudo -S ln $folderDevelopmentHome/Sublime\ Text\ 2/sublime_text . -s
sudo -S ln $folderDevelopmentHome/eclipse/eclipse . -s
sudo -S ln $folderDevelopmentHome/pgadmin3-1.14.3/pgadmin/pgadmin3 . -s

echo "=============================================="
echo "Setting environment variables"
echo ""

sudo -S su -c "echo '' >> $profile" < passSudo

sudo -S su -c "echo 'export M2_HOME='"$folderDevelopmentHome"'/apache-maven-3.0.4
export JAVA_HOME='"$folderDevelopmentHome"'/jdk1.6.0_33' >> $profile" < $passSudo

sudo -S su -c "echo export PATH='$'PATH:'$'M2_HOME:'$'JAVA_HOME:'$'JAVA_HOME/bin:'$'M2_HOME/bin >> $profile" < $passSudo

echo "=============================================="
echo "Adding java to Google Chrome"
echo ""

sudo -S mkdir /opt/google/chrome/plugins < $passSudo
cd /opt/google/chrome/plugins 
sudo -S $homeUser/Development/jdk1.6.0_33/jre/lib/i386/libnpjp2.so . -s

#echo "=============================================="
#echo "Remove application"
#sudo -S apt-get purge -y --force-yes rhythmbox

echo "=============================================="
echo "update pagination"
echo ""
sudo -S updatedb < $passSudo

echo "=============================================="
echo ""
echo "Finish"
echo ""

echo "To complete configuration is necessary to restart the machine. Want to restart now? (y/n)"
read result

if [ "$result" == "y" ]; then
	sudo -S reboot < $passSudo
else
	echo "Reboot Canceled"	
fi





