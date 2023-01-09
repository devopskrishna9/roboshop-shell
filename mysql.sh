source common.sh

if [ -z "${root_mysql_password}" ]; then
  echo "variable root_mysql_password is missing"
  exit
fi

print_head " dnf module disable mysql"
dnf module disable mysql -y &>>{LOG}
status_check

print_head "copy mysql repo files"
cp ${script_location}/files/mysql.repo  /etc/yum.repos.d/mysql.repo &>>${LOG}
status_check

print_head "Install mysql"
yum install mysql-community-server -y &>>${LOG}
status_check

print_head "Enable mysql"
systemctl enable mysqld &>>${LOG}
status_check

print_head "Start mysql"
systemctl start mysqld &>>${LOG}
status_check

print_head "change the root password"
mysql_secure_installation --set-root-pass ${root_mysql_password} &>>${LOG}
status_check

print_head "check the password"
mysql -uroot -p${root_mysql_password} &>>${LOG}
status_check

print_head "reStart mysql"
systemctl restart mysqld &>>${LOG}
status_check
