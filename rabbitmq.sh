source common.sh

echo -e "\e[33m Configure Erlang Repos \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>/tmp/roboshop.log
stat_check $?

echo -e "\e[33m Configure Rabbitmq Repos \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>/tmp/roboshop.log
stat_check $?

echo -e "\e[33m Install RbbitMQ Server \e[0m"
yum install rabbitmq-server -y &>>/tmp/roboshop.log
stat_check $?

echo -e "\e[33m Start RabbitMQ Service \e[0m"
systemctl enable rabbitmq-server &>>/tmp/roboshop.log
systemctl restart rabbitmq-server &>>/tmp/roboshop.log
stat_check $?

echo -e " ${color}  Add RabbitMQ Application User ${nocolor} "
rabbitmqctl add_user roboshop $1 &>>/tmp/roboshop.log
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>/tmp/roboshop.log
stat_check $?