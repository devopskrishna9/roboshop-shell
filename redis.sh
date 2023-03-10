source common.sh

print_head "Install redis repo file"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${LOG}
status_check

print_head "dnf module enable new version"
dnf module enable redis:remi-6.2 -y &>>${LOG}
status_check

print_head "Install redis"
yum install redis -y &>>${LOG}
status_check

print_head "Binding ports"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf  &>>${LOG}
status_check

print_head "binding ports inside redis of redis"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf &>>${LOG}
status_check

# use both at a time also just for eloborate i used seperate sed editor
# sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf  &>>${LOG}

print_head "Enable the redis"
systemctl enable redis &>>${LOG}
status_check

print_head "Start the redis"
systemctl start redis &>>${LOG}
status_check

print_head "Restart the redis"
systemctl restart redis &>>${LOG}
status_check
