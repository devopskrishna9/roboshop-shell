source common.sh

echo -e "\e[31mConfiguring the nodejs files\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${LOG}
status_check

echo -e "\e[32mInstall Nodejs\e[0m"
yum install nodejs -y &>>${LOG}
status_check

useradd roboshop &>>${LOG}
mkdir /app &>>${LOG}
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>${LOG}
rm -rf /app/* &>>${LOG}
cd /app &>>${LOG}
unzip /tmp/catalogue.zip &>>${LOG}
cd /app &>>${LOG}
echo -e "\e[33mInstall rpm files\e[0m"
npm install &>>${LOG}
status_check

echo -e "\e[34mCopying files\e[0m"
cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service &>>${LOG}

systemctl daemon-reload &>>${LOG}
status_check

systemctl enable catalogue &>>${LOG}
systemctl start catalogue &>>${LOG}

cp ${script_location}/files/mongo.repo /etc/yum.repos.d/mongo.repo &>>${LOG}

yum install mongodb-org-shell -y &>>${LOG}
mongo --host mongodb-dev.devopsnew9.online </app/schema/catalogue.js &>>${LOG}


systemctl enable catalogue &>>${LOG}
echo -e "\e[34mRestart the mechine\e[0m"
systemctl restart catalogue &>>${LOG}
status_check