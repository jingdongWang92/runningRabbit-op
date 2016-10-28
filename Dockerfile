# vertion: 0.1

FROM tomcat:7
MAINTAINER Zhang Chuan <zhangchuan@jcble.com>

RUN rm -rf /usr/local/tomcat/webapps && mkdir -p /usr/local/tomcat/webapps/ROOT
ADD ./build /usr/local/tomcat/webapps/ROOT
