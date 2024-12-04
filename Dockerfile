FROM gradle:8.11.1-jdk21-alpine AS builder

WORKDIR /builder
COPY build.gradle.kts settings.gradle.kts /builder/
RUN gradle build -x test --parallel --continue > /dev/null 2>&1 || true

COPY . /builder
RUN gradle build

FROM eclipse-temurin:21-jre
WORKDIR /app

## *.jar 대신 jar 파일명 입력하거나 bootJar만 생성하도록 함
## 이 예제는 bootJar만 생성하는 예제임 build.gradle.kts 참고
COPY --from=builder /builder/build/libs/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
