echo -e "\e[33mCopy Mongodb Repo File\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log

echo -e "\e[33mInstalling Mongodb Server\e[0m" &>>/tmp/roboshop.log
yum install mongodb-org -y 

##we need to copy confi file 

echo -e "\e[33mStart Mongodb Service\e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log