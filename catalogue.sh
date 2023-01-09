script_location=$(pwd)
LOG=/tmp/roboshop.log

status_check()
{
  if [ $? -eq 0 ]; then
   echo SUCCESS
  else
    echo -e "\e[31mFAILURE\e[0m"
    echo "Refer log file for more information, LOG - ${LOG}"
    exit;
  fi
}
echo -e "\e[31mConfiguring the nodejs files\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
status_check

echo -e "\e[32mInstall Nodejs\e[0m"
yum install nodejs -y
status_check

useradd roboshop
mkdir /app
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
rm -rf /app/*
cd /app
unzip /tmp/catalogue.zip
cd /app
echo -e "\e[33mInstall rpm files\e[0m"
npm install
status_check

echo -e "\e[34mCopying files\e[0m"
cp ${script_location}/files/catalogue.service /etc/systemd/system/catalogue.service

systemctl daemon-reload
status_check

systemctl enable catalogue
systemctl start catalogue

cp ${script_location}/files/mongo.repo /etc/yum.repos.d/mongo.repo

yum install mongodb-org-shell -y
mongo --host mongodb-dev.devopsnew9.online </app/schema/catalogue.js


systemctl enable catalogue
echo -e "\e[34mRestart the mechine\e[0m"
systemctl restart catalogue
status_check