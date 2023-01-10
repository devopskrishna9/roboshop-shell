source common.sh

if [ -z "${roboshop_rabbitmq_password}" ]; then
   echo "variable roboshop_rabbitmq_password is missing"
   exit
fi

print_head "configure yum repo"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash &>>{LOG}
status_check

print_head "Install Erlang"
yum install erlang -y &>>{LOG}
status_check

print_head "configure yum repo for rabbitmq"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>{LOG}
status_check

print_head "Install rabbitmq"
yum install rabbitmq-server -y &>>{LOG}
status_check

print_head "Enable rabbitmq"
systemctl enable rabbitmq-server &>>{LOG}
status_check

print_head "Start rabbitmq"
systemctl start rabbitmq-server &>>{LOG}
status_check

print_head "add application user"
rabbitmqctl add_user roboshop ${roboshop_rabbitmq_password} &>>{LOG}
status_check

print_head "add tags to application user"
rabbitmqctl set_user_tags roboshop administrator &>>{LOG}
status_check

print_head "add permissions to application user"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>{LOG}
status_check