FROM registry.access.redhat.com/ubi8/openjdk-11:latest
WORKDIR /app
COPY . /app
RUN javac demo.java
CMD [ "java", "demo" ]
