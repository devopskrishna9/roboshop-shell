source common.sh

if [ -z "${root_mysql_password}" ]; then
  echo "Variable root_mysql_password is missing"
  exit
fi

print_head "Disable MySQL Default Module"
dnf module disable mysql -y &>>${LOG}
status_check

print_head "Copy MySQL Repo file"
cp ${script_location}/files/mysql.repo /etc/yum.repos.d/mysql.repo &>>${LOG}
status_check

print_head "Install MySQL Server"
yum install mysql-community-server -y  &>>${LOG}
status_check

print_head "Enable MySQL"
systemctl enable mysqld &>>${LOG}
status_check

print_head "Start MySQL"
systemctl start mysqld &>>${LOG}
status_check

print_head "check whether the password is set or not"
if [ -z "${root_mysql_password}" ]; then
   print_head "Reset Default Database Password"
     mysql_secure_installation --set-root-pass ${root_mysql_password} &>>${LOG}
   status_check
else
   echo ROOT PASSWORD is "ROOT password already reset"
fi

print_head "check the new password"
mysql -uroot -p${root_mysql_password} &>>${LOG}
status_check

print_head "Start MySQL"
systemctl restart mysqld &>>${LOG}
status_check
