script_location=$(pwd)

#front end web content
echo  this is sample front end web content from nginx webserver
echo -e "\e[31mInstall Nginx\e[0m"
yum install nginx -y
echo -e "\e[32mEnable\e[0m"
systemctl enable nginx
echo -e "\e[33mStart\e[0m"
systemctl start nginx
echo -e "\e[34mRemove old content\e[0m"
rm -rf /usr/share/nginx/html/*
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
cp ${script_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf
echo -e "\e[35mRestart Nginx\e[0m"
systemctl restart nginx