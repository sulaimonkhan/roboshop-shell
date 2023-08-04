echo -e "\e[33m Install Golang\e[0m"
yum install golang -y &>>/tmp/roboshop.log

echo -e "\e[33m Add Application User\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33m Create Application Directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app 

echo -e "\e[33m Add Application Content\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>/tmp/roboshop.log
cd /app 

echo -e "\e[33m Extract Application Content\e[0m"
unzip /tmp/dispatch.zip &>>/tmp/roboshop.log

echo -e "\e[33m Download The Dependencies\e[0m"
cd /app 
go mod init dispatch &>>/tmp/roboshop.log
go get &>>/tmp/roboshop.log
go build &>>/tmp/roboshop.log

echo -e "\e[33m Setup Systend Service\e[0m"
cp /root/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service &>>/tmp/roboshop.log

echo -e "\e[33m Start Dispatch Service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable dispatch &>>/tmp/roboshop.log
systemctl restart dispatch &>>/tmp/roboshop.log