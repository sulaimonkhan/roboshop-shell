source common.sh

echo -e "${color}mCopy Mongodb Repo File${nocolor}"
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log
stat_check $?

echo -e "${color}mInstalling Mongodb Server${nocolor}" 
yum install mongodb-org -y &>>/tmp/roboshop.log
stat_check $?

echo -e "${color}mUpdate Mongodb Listen Address${nocolor}" 
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat_check $?

echo -e "${color}mStart Mongodb Service${nocolor}"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log
stat_check $?