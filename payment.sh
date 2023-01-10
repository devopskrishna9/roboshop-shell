source common.sh
component=payment
Schema_load=false

if [ -z "${roboshop_rabbitmq_password}" ]; then
  echo "variable is missing"
  exit
fi

PYTHON



