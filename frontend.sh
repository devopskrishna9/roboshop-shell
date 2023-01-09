source common.sh

echo -e "\e[31mInstall Nginx\e[0m"
yum install nginx -y &>>${LOG}
status_check

echo -e "\e[32mEnable\e[0m"
systemctl enable nginx &>>${LOG}
status_check

echo -e "\e[33mStart\e[0m"
systemctl start nginx &>>${LOG}
status_check

echo -e "\e[34mRemove old content\e[0m"
rm -rf /usr/share/nginx/html/* &>>${LOG}
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}
cd /usr/share/nginx/html &>>${LOG}
unzip /tmp/frontend.zip &>>${LOG}
cp ${script_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}
status_check

echo -e "\e[35mRestart Nginx\e[0m"
systemctl restart nginx &>>${LOG}
status_check
