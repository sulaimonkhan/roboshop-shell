cp user.service /etc/systemd/system/user.service

dnf module disable nodejs -y
dnf module enable nidejs:20 -y

dnf install nodejs -y

useradd roboshop

mkdir /app

curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user-v3.zip 
cd /app 
unzip /tmp/user.zip

cd /app
npm insatll

systemctl daemon-reload
systemctl enable user
systemctl restart user
