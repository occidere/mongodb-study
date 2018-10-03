# mongodb-study
MongoDB 스터디 및 실습용 Repository

## 교재
[MongoDB Master가 해설하는 New NoSQL & mongoDB](https://book.naver.com/bookdb/book_detail.nhn?bid=11738053)

## 구성
1. 실습환경 구축
    * Docker를 이용한 MongoDB-3.6 설치
2. 강의 내용
    1. NoSQL 개념
    2. MongoDB 설치 및 데이터 처리
    3. 인덱스 생성과 관리 & 사용자 관리
    4. MongoDB를 위한 Data Modeling
    5. 논리적 구조 & 물리적 구조
    6. Sharding System
    7. Replica &ReplicaSets
    8. MongoDB 성능 튜닝
    9. MongoDB 백업/복구 & 유틸리티

## 1. 실습환경 구축
### Docker 파일 설명
* 로컬에 직접 설치하기 싫으니 Docker로 한다 (물론 로컬엔 Docker가 설치되어 있어야 한다)
* Dockerfile은 CentOS 7 + MongoDB 3.6 + JDK1.8 로 구성되어 있다.

### 실행
````bash
sh docker_script.sh ${실행할 명령어}
````
* 명령어 목록
    * build: 도커 이미지를 centos7:mongodb 태그로 빌드
    * run: centos7:mongodb 도커 이미지로부터 도커 프로세스를 새로 생성 & 실행
        * 다시 터미널로 나오려면 `Ctrl + p + q` 를 누른다
    * attach: **기존에 생성됬던 도커 프로세스를 재 실행**
        * Ctrl + p + q로 나갔던 프로세스를 재 실행시킨다
    * stop: 도커 프로세스 중지
    * rm: 도커 프로세스 삭제
    * clean
        * 도커 프로세스 중지
        * 도커 프로세스 삭제
        * 도커 이미지 삭제
    * status: centos7:mongodb 태그로 생성된 도커 프로세스의 상태 확인
    * -h | --help
        * 도움말 출력

* 실행 예제
````bash
./docker_script.sh run
sh docker_script.sh build run
./docker_script.sh rm
sh docker_script.sh clean build run
````

