source common.sh

print_head "Configuring the nodejs files"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
status_check

print_head "Install Nodejs"
yum install nodejs -y &>>${LOG}
status_check

print_head "add user roboshop"
useradd roboshop &>>${LOG}
status_check

print_head "make a app dir"
mkdir /app &>>${LOG}
status_check

print_head "user zip file "
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>${LOG}
status_check

print_head "remove old content in app dir"
rm -rf /app/* &>>${LOG}
status_check

print_head "change dir to app"
cd /app &>>${LOG}
status_check

print_head "unzip file"
unzip /tmp/user.zip &>>${LOG}
status_check

print_head "again chage dir to app"
cd /app &>>${LOG}
status_check

print_head "Install npm files"
npm install &>>${LOG}
status_check

print_head "Copying files"
cp ${script_location}/files/user.service /etc/systemd/system/user.service &>>${LOG}
status_check

print_head "daemon reload"
systemctl daemon-reload &>>${LOG}
status_check

print_head "enable user"
systemctl enable user &>>${LOG}
status_check

print_head "start user"
systemctl start user &>>${LOG}
status_check

print_head "copy mongodb repo file"
cp ${script_location}/files/mongo.repo /etc/yum.repos.d/mongo.repo &>>${LOG}
status_check

print_head "install mongodb org client file"
yum install mongodb-org-shell -y &>>${LOG}
status_check

print_head "load schema"
mongo --host mongodb-dev.devopsnew9.online </app/schema/user.js &>>${LOG}

print_head "again enable user"
systemctl enable user &>>${LOG}
status_check

print_head "Restart the mechine"
systemctl restart user &>>${LOG}
status_check