sudo apt-get update

sudo apt-get install apache2 -y
sudo apt-get install php -y
sudo apt-get install php libapache2-mod-php php-mysql php-sqlite3 php-mbstring php-zip php-xml php-xmlrpc php-gd php-dom php-cli php-json php-common php-opcache php-readline php-curl -y

sudo a2enmod rewrite
sudo service apache2 restart
