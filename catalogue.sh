component=catalogue
color="\e[36m"
nocolor="\e[0m"

echo -e "${color} Configuration NodeJS Repos ${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "${color} Install NodeJS ${nocolor}"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "${color}Add Application User ${nocolor}"
useradd roboshop &>>/tmp/roboshop.log

echo -e "${color} Create Application Directory ${nocolor}"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app 

echo -e "${color} Download Application Content ${nocolor}"
curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component.zip &>>/tmp/roboshop.log
cd /app 

echo -e "${color} Extract Applicatin Content ${nocolor}"
unzip /tmp/$component.zip &>>/tmp/roboshop.log
cd /app

echo -e "${color} Install NodeJS Dependencies ${nocolor}"
npm install &>>/tmp/roboshop.log

echo -e "${color} Setup Systend Service ${nocolor}"
cp /root/roboshop-shell/$component.service /etc/systemd/system/$component.service &>>/tmp/roboshop.log

echo -e "${color} Start $component Service ${nocolor}"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable $component &>>/tmp/roboshop.log
systemctl restart $component &>>/tmp/roboshop.log

echo -e "${color} Copy Mongodb Repo File ${nocolor}"
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log

echo -e "${color} Install Mongodb Client ${nocolor}"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "${color} Load Schema ${nocolor}"
mongo --host mongodb-dev.devopsb72.site </app/schema/$component.js &>>/tmp/roboshop.log