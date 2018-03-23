FROM openjdk:8-jre-alpine

# set home directory for image commands
WORKDIR /home/app

# Add the service itself
ARG APP_JAR_FILE
ENV APP_JAR_FILE ${APP_JAR_FILE}
ARG APP_NAME
ARG APP_DESC
ARG APP_VERSION

# copy application jar and config files
COPY target/$APP_JAR_FILE application.jar
COPY pom.xml pom.xml

# define image label for tracking image build
LABEL name=$APP_NAME desc="$APP_DESC" version=$APP_VERSION

EXPOSE 9989

# command to run on container start up, note use EXEC form ENTRYPOINT + CMD will be executed.
# This allows options to be added to the java command if required
# for example to add -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:MaxRAMFraction=2
#    docker run --rm service -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -jar <rest of command>
ENTRYPOINT ["java"]
CMD ["-jar", "application.jar"]
