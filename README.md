# 실행법
1. `docker desktop`이 설치 되어있어, 실행되고 있어야함 혹은 리눅스인 경우 `docker`만 설치되어 있어도 됨
2. 프로젝트로 디렉토리 이동 후 다음 명령어 실행
```
## -t 옵션은 태그 옵션 .은 현재 디렉토리에 Dockerfile을 찾아서 빌드함
docker build -t sample-packaging:0.0.1 .
```

3. 이미지 잘 생성됐는지 확인하기
```
$ docker images
REPOSITORY                                 TAG               IMAGE ID       CREATED         SIZE
packaging-sample                           0.0.1             408f7f31b4c5   4 minutes ago   313MB
```

4. 이미지로 컨테이너 만들어보기
```
## -p 옵션은 포트 열어주는것, 보통 스프링 기본 포트가 8080이므로 알아서 열것
## --rm 옵션은 컨테이너 종료시 삭제처리함
## -d 옵션은 데몬으로 실행하여 백그라운드로 실행함, 없으면 콘솔 로그창으로 띄워지고 Ctrl + C 로 프로세스 끝내면 꺼짐
$ docker run --rm -p 8080:8080 packaging-sample:0.0.1
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
