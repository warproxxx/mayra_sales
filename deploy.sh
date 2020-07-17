find /home/ubuntu/mayra_sales/src -type f -name "*" -print0 | xargs -0 sed -i '' -e 's/mayrasales.local/mayrasales.com/g'
chmod 777 -R /home/ubuntu/mayra_sales/src
