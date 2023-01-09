script_location=$(pwd)
LOG=/tmp/roboshop.log
echo -e "\e[31mInstall Nginx\e[0m"
yum install nginx -y &>>${LOG}
echo $?
echo -e "\e[32mEnable\e[0m"
systemctl enable nginx &>>${LOG}
echo $?
echo -e "\e[33mStart\e[0m"
systemctl start nginx &>>${LOG}
echo $?
echo -e "\e[34mRemove old content\e[0m"
rm -rf /usr/share/nginx/html/* &>>${LOG}
echo $?
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}
echo $?
cd /usr/share/nginx/html &>>${LOG}
echo $?
unzip /tmp/frontend.zip &>>${LOG}
echo $?
cp ${script_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}
echo $?
echo -e "\e[35mRestart Nginx\e[0m"
systemctl restart nginx &>>${LOG}
echo $?