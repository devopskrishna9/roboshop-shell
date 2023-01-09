source common.sh

print_head "Configuring the nodejs files"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
status_check

print_head "Install Nodejs"
yum install nodejs -y &>>${LOG}
status_check

useradd roboshop &>>${LOG}
mkdir /app &>>${LOG}
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${LOG}
rm -rf /app/* &>>${LOG}
cd /app &>>${LOG}
unzip /tmp/catalogue.zip &>>${LOG}
cd /app &>>${LOG}

print_head "Install rpm files"
npm install &>>${LOG}
status_check

print_head "Copying files"
cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service &>>${LOG}

systemctl daemon-reload &>>${LOG}
status_check

systemctl enable catalogue &>>${LOG}
systemctl start catalogue &>>${LOG}

cp ${script_location}/files/mongo.repo /etc/yum.repos.d/mongo.repo &>>${LOG}

yum install mongodb-org-shell -y &>>${LOG}
mongo --host mongodb-dev.devopsnew9.online </app/schema/catalogue.js &>>${LOG}


systemctl enable catalogue &>>${LOG}
print_head "Restart the mechine"
systemctl restart catalogue &>>${LOG}
status_check