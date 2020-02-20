FROM tomcat:8.0

MAINTAINER rajesh

ADD https://srish-technologies.s3.ap-south-1.amazonaws.com/tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml

ADD https://srish-technologies.s3.ap-south-1.amazonaws.com/context.xml /usr/local/tomcat/webapps/manager/META-INF/

COPY /target/mvn-hello-world.war /usr/local/tomcat/webapps/

USER root

WORKDIR /usr/local/tomcat/webapps

EXPOSE 8080

CMD ["catalina.sh", "run"]
