FROM java:8
WORKDIR /
ADD target/K8sDemoExample-1.0.0.jar /app/K8sDemoExample-1.0.0.jar
EXPOSE 8080
CMD java -jar /app/K8sDemoExample-1.0.0.jar
