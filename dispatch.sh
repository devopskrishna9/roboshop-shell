source common.sh

component=dispatch

if [ -z "${roboshop_rabbitmq_password}" ]; then
  echo "variable is missing"
  exit
fi

GOLANG

