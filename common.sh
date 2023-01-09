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