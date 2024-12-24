FROM ubuntu AS st1
RUN apt update && apt install git -y && apt-get clean
RUN git clone https://github.com/HariGangiah/java-example.git
WORKDIR /java-example

FROM maven:amazoncorretto AS st2
WORKDIR /app
COPY --from=st1 /java-example .
RUN mvn clean install

FROM artisantek/tomcat:1
COPY --from=st2 /app/target/*.war /usr/local/tomcat/webapps/
EXPOSE 9050
CMD ["catalina.sh", "run"]
