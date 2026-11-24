# ---- build stage ----
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /build
COPY pom.xml .
RUN mvn -B dependency:go-offline
COPY src ./src
RUN mvn -B package -DskipTests

# ---- runtime stage ----
FROM eclipse-temurin:17-jre
ENV APP_HOME=/usr/src/app
WORKDIR $APP_HOME
COPY --from=build /build/target/*.jar $APP_HOME/app.jar

RUN useradd -r -u 1001 appuser
USER appuser

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]