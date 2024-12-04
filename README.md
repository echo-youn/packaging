# 실행법
1. `docker desktop`이 설치 되어있어, 실행되고 있어야함 혹은 리눅스인 경우 `docker`만 설치되어 있어도 됨
2. 프로젝트로 디렉토리 이동 후 다음 명령어 실행
```
## -t 옵션은 태그 옵션 .은 현재 디렉토리에 Dockerfile을 찾아서 빌드함
$ docker build -t sample-packaging:0.0.1 .
[+] Building 16.5s (15/15) FINISHED                                                                                                                                                                                                                  docker:default 
 => [internal] load build definition from Dockerfile                                                                                                                                                                                                           0.0s 
 => => transferring dockerfile: 559B                                                                                                                                                                                                                           0.0s 
 => [internal] load metadata for docker.io/library/eclipse-temurin:21-jre                                                                                                                                                                                      1.3s 
 => [internal] load metadata for docker.io/library/gradle:8.11.1-jdk21-alpine                                                                                                                                                                                  1.3s 
 => [internal] load .dockerignore                                                                                                                                                                                                                              0.0s 
 => => transferring context: 2B                                                                                                                                                                                                                                0.0s 
 => [builder 1/6] FROM docker.io/library/gradle:8.11.1-jdk21-alpine@sha256:4596bafca2c2854a94c6017e25922e64151cb788133e07307e7c8c41d02756b0                                                                                                                    0.0s 
 => [stage-1 1/3] FROM docker.io/library/eclipse-temurin:21-jre@sha256:bc0f9639558d84964aada789a151b76409b3c5bc3209e2351d227aa0b3acf5f3                                                                                                                        0.0s 
 => [internal] load build context                                                                                                                                                                                                                              0.4s 
 => => transferring context: 124.70kB                                                                                                                                                                                                                          0.3s 
 => CACHED [builder 2/6] WORKDIR /builder                                                                                                                                                                                                                      0.0s 
 => CACHED [builder 3/6] COPY build.gradle.kts settings.gradle.kts /builder/                                                                                                                                                                                   0.0s 
 => CACHED [builder 4/6] RUN gradle build -x test --parallel --continue > /dev/null 2>&1 || true                                                                                                                                                               0.0s 
 => [builder 5/6] COPY . /builder                                                                                                                                                                                                                              0.1s 
 => [builder 6/6] RUN gradle build                                                                                                                                                                                                                            14.4s
 => CACHED [stage-1 2/3] WORKDIR /app                                                                                                                                                                                                                          0.0s
 => [stage-1 3/3] COPY --from=builder /builder/build/libs/*.jar app.jar                                                                                                                                                                                        0.0s
 => exporting to image                                                                                                                                                                                                                                         0.1s
 => => exporting layers                                                                                                                                                                                                                                        0.0s
 => => writing image sha256:7701f8bac96be0c62802abebf9dc5899187b993792e68035e58b9cd7bcbbd3fb                                                                                                                                                                   0.0s
 => => naming to docker.io/library/sample-packaging:0.0.1                                   
```

3. 이미지 잘 생성됐는지 확인하기
```
$ docker images
REPOSITORY                                 TAG               IMAGE ID       CREATED         SIZE
packaging-sample                           0.0.1             408f7f31b4c5   4 minutes ago   313MB
```

4. 이미지로 컨테이너 실행
```
## -p 옵션은 포트 열어주는것, 보통 스프링 기본 포트가 8080이므로 알아서 열것
## --rm 옵션은 컨테이너 종료시 삭제처리함
## -d 옵션은 데몬으로 실행하여 백그라운드로 실행함, 없으면 콘솔 로그창으로 띄워지고 Ctrl + C 로 프로세스 끝내면 꺼짐
$ docker run --rm -p 8080:8080 packaging-sample:0.0.1
  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/

 :: Spring Boot ::                (v3.4.0)

2024-12-04T06:56:35.785Z  INFO 1 --- [docker-packaging] [           main] c.e.d.DockerPackagingApplicationKt       : Starting DockerPackagingApplicationKt v0.0.1-SNAPSHOT using Java 21.0.5 with PID 1 (/app/app.jar started by root in /app)
2024-12-04T06:56:35.787Z  INFO 1 --- [docker-packaging] [           main] c.e.d.DockerPackagingApplicationKt       : No active profile set, falling back to 1 default profile: "default"
2024-12-04T06:56:36.258Z  INFO 1 --- [docker-packaging] [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port 8080 (http)
2024-12-04T06:56:36.266Z  INFO 1 --- [docker-packaging] [           main] o.apache.catalina.core.StandardService   : Starting service [Tomcat]
2024-12-04T06:56:36.266Z  INFO 1 --- [docker-packaging] [           main] o.apache.catalina.core.StandardEngine    : Starting Servlet engine: [Apache Tomcat/10.1.33]
2024-12-04T06:56:36.280Z  INFO 1 --- [docker-packaging] [           main] o.a.c.c.C.[Tomcat].[localhost].[/]       : Initializing Spring embedded WebApplicationContext
2024-12-04T06:56:36.281Z  INFO 1 --- [docker-packaging] [           main] w.s.c.ServletWebServerApplicationContext : Root WebApplicationContext: initialization completed in 459 ms
2024-12-04T06:56:36.456Z  INFO 1 --- [docker-packaging] [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port 8080 (http) with context path '/'
2024-12-04T06:56:36.465Z  INFO 1 --- [docker-packaging] [           main] c.e.d.DockerPackagingApplicationKt       : Started DockerPackagingApplicationKt in 0.895 seconds (process running for 1.179)


```

5. 테스트
```http
GET http://localhost:8080/world?message=helloWorld

HTTP/1.1 200 
Content-Type: text/plain;charset=UTF-8
Content-Length: 10
Date: Wed, 04 Dec 2024 06:55:06 GMT

helloWorld

Response code: 200; Time: 5ms (5 ms); Content length: 10 bytes (10 B)
```
