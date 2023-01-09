source common.sh

print_head "Copy files"
cp ${script_location}/files/mongo.repo /etc/yum.repos.d/mongo.repo &>>${LOG}

print_head "Install mongodb"
yum install mongodb-org -y &>>${LOG}

sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

print_head "Enable mongodb"
systemctl enable mongod &>>${LOG}

print_head "start mongodb"
systemctl start mongod &>>${LOG}

