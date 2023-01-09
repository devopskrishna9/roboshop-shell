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

print_head()
{
  echo -e "\e[1m $1\e[0m"
}

Nodejs()
{
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

  print_head "${component} zip file "
  curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${LOG}
  status_check
  status_check


  print_head "remove old content in app dir"
  rm -rf /app/* &>>${LOG}
  print_head "change dir to app"
  cd /app &>>${LOG}
  status_check

  print_head "unzip file"
  unzip /tmp/${component}.zip &>>${LOG}
  status_check

  print_head "again chage dir to app"
  cd /app &>>${LOG}
  status_check

  print_head "Install npm files"
  npm install &>>${LOG}
  status_check

  print_head "Copying files"
  cp ${script_location}/files/${component}.service /etc/systemd/system/${component}.service &>>${LOG}
  status_check

  print_head "daemon reload"
  systemctl daemon-reload &>>${LOG}
  status_check

  print_head "enable ${component}"
  systemctl enable ${component} &>>${LOG}
  status_check

  print_head "start ${component}"
  systemctl start ${component} &>>${LOG}
  status_check

  print_head "copy mongodb repo file"
  cp ${script_location}/files/mongo.repo /etc/yum.repos.d/mongo.repo &>>${LOG}
  status_check

  print_head "install mongodb org client file"
  yum install mongodb-org-shell -y &>>${LOG}
  status_check

  print_head "load schema"
  mongo --host mongodb-dev.devopsnew9.online </app/schema/${component}.js &>>${LOG}

  print_head "again enable ${component}"
  systemctl enable ${component} &>>${LOG}
  status_check

  print_head "Restart the mechine"
  systemctl restart ${component} &>>${LOG}
  status_check
}