source common.sh

print_head "Install nginx"
yum install nginx -y &>>${LOG}
status_check

print_head "Enable nginx "
systemctl enable nginx &>>${LOG}
status_check

print_head "Start nginx"
systemctl start nginx &>>${LOG}
status_check

print_head "Remove old content"
rm -rf /usr/share/nginx/html/* &>>${LOG}
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${LOG}
cd /usr/share/nginx/html &>>${LOG}
unzip /tmp/frontend.zip &>>${LOG}
cp ${script_location}/files/nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${LOG}
status_check

print_head "Restart Nginx"
systemctl restart nginx &>>${LOG}
status_check
