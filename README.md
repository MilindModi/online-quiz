# Online Quiz

## Features

* Authentication & Registration
* Create & Host your own Quiz
* Add questions manually
* Add questions from CSV
* Participate in a Live Quiz
* Look at the Live Score as you go
* Live Chat with Presenter and other Participants
* Leaderboards
* Quiz Rating

# Prerequisites

## Step 0 - Create Database

Database: online-exam

Just import [this Database](https://github.com/MilindModi/online-quiz/blob/master/online-quiz.sql)

## Step 1 - Install Java

Tomcat requires Java to be installed on the server so that any Java web application code can be executed.

## Step 2 - Extra Libraries needed

Download all libraries [from here](https://github.com/MilindModi/online-quiz/tree/master/dependencies)

## Step 3 - Download Tomcat & Create Tomcat User

 *  IDE Users
 If you are using IDE like eclipse, netbeans or IntelliJ, you can use this ![jar file](https://repo1.maven.org/maven2/org/apache/tomcat/tomcat-catalina/7.0.109/tomcat-catalina-7.0.109.jar).

**OR**
* Command Line Users

If you are using terminal in **Linux** or **Mac**

```bash
sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat Tomcat
cd /tmp
curl -O https://downloads.apache.org/tomcat/tomcat-9/v9.0.46/bin/apache-tomcat-9.0.46.tar.gz
sudo mkdir /opt/tomcat
sudo tar xzvf apache-tomcat-*tar.gz -C /opt/tomcat --strip-components=1
cd /opt/tomcat
sudo chgrp -R tomcat /opt/tomcat
sudo chmod -R g+r conf
sudo chmod g+x conf
sudo chown -R tomcat webapps/ work/ temp/ logs/
```

Tomcat needs to know where Java is installed. This path is commonly referred to as “JAVA_HOME”. The easiest way to look up that location is by running this command:
```bash
sudo update-java-alternatives -l
```

Output will be something like this
```bash
java-1.13.0-openjdk-amd64       1081       /usr/lib/jvm/java-1.13.0-openjdk-amd64
```

Edit **JAVA_HOME** as per above result in `/etc/systemd/system/tomcat.service`

```bash
Environment=JAVA_HOME=/usr/lib/jvm/java-1.13.0-openjdk-amd64
```

```bash
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl status tomcat
sudo ufw allow 8080
http://server_domain_or_IP:8080
```

If you are using localhost, you can see our app at 127.0.0.1:8080

# Screenshots

![1-register](https://github.com/MilindModi/online-quiz/blob/master/media/1-register.png?raw=true)

![2-welcome-page](https://github.com/MilindModi/online-quiz/blob/master/media/2-welcome-page.png?raw=true)

![3-login](https://github.com/MilindModi/online-quiz/blob/master/media/3-login.png?raw=true)

![4-make-quiz](https://github.com/MilindModi/online-quiz/blob/master/media/4-make-quiz.pn?raw=trueg)


![5-upload-questions](https://github.com/MilindModi/online-quiz/blob/master/media/5-upload-questions-as-csv.png?raw=true)
![6-view-all-ques](https://github.com/MilindModi/online-quiz/blob/master/media/6-view-all-ques.png?raw=true)

![7-start-presentation](https://github.com/MilindModi/online-quiz/blob/master/media/7-start-presentation.png?raw=true)

![8-chat](https://github.com/MilindModi/online-quiz/blob/master/media/8-chat.png?raw=true)

![9-start-quiz](https://github.com/MilindModi/online-quiz/blob/master/media/9-start-quiz.png.png?raw=true)

![10-view-scoreboard](https://github.com/MilindModi/online-quiz/blob/master/media/10-view-scoreboard.png?raw=true)

![11-rate](https://github.com/MilindModi/online-quiz/blob/master/media/11-rate.png?raw=true)

![12-rate2](https://github.com/MilindModi/online-quiz/blob/master/media/12-rate2.png?raw=true)

![13-delete](https://github.com/MilindModi/online-quiz/blob/master/media/13-delete.png?raw=true)

![12-view-review](https://github.com/MilindModi/online-quiz/blob/master/media/14-vew-review.png?raw=true)
