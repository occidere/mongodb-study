# 3-3. 사용자 생성과 관리

### 목차

1. OS 인증방식
2. DB 인증방식
3. 사용자 권한 룰



## 1. OS 인증방식

MongoDB 인스턴스 실행 시 `--bind_ip` 옵션을 추가하여 접속가능한 클라이언트 IP 를 지정



#### Example

````bash
mongod --bind_ip=127.0.0.1  # localhost 로만 접근 가능
````





## 2. DB 인증방식

Role 기능을 통해 사용자 계정이 DB에서 어떤 권한으로 어느 범위의 작업들을 수행할 수 있는지 제어

참고: [built-in-roles](https://docs.mongodb.com/manual/reference/built-in-roles/)



#### 1. admin DB 선택 & 유저 확인

````javascript
use admin	// admin 데이터베이스 선택
show users	// user 확인 -> 처음엔 아무런 유저도 없다.
````

<img src="https://user-images.githubusercontent.com/20942871/46949012-e76d6200-d0ba-11e8-9118-b948648d71e0.png" width="30%"/>



#### 2. 유저 & 권한 생성

````javascript
db.createUser({
	user: "system", // ID: system
    pwd: "1234", // PWD: 1234
    roles: [
        "dbAdminAnyDatabase"
    ]
})
````

<img src="https://user-images.githubusercontent.com/20942871/46949347-16d09e80-d0bc-11e8-8509-08028fb9ad3b.png" width="70%" />



````javascript
db.dropUser("system")
db = db.getSiblingDB('admin')
````

<img src="https://user-images.githubusercontent.com/20942871/46949421-5a2b0d00-d0bc-11e8-87ab-1772459424dc.png" width="50%" />



````javascript
db.createUser({
    user: "system",
    pwd: "manager",
    roles: [
        {role: "readWrite", db: "admin"},
        {role: "userAdmin", db: "admin"},
        {role: "dbAdmin", db: "admin"},
        {role: "clusterAdmin", db: "admin"},
        {role: "dbAdminAnyDatabase", db: "admin"},
        {role: "readWrite", db: "test"} // Test DB R/W 도 추가
    ]
})
````

<img src="https://user-images.githubusercontent.com/20942871/46949538-afffb500-d0bc-11e8-87e5-1ef7f87e14b4.png" width="50%" />



#### 3. 인증 적용 및 재시작

* mongod 실행 시 반드시 `--auth`를 붙여야 한다!

````javascript
/* 종료 후 재접속 */
mongod --bind_ip=0.0.0.0 --dbpath=/data/db --auth // 반드시 --auth 를 붙여야 함
use test
show collections
````

<img src="https://user-images.githubusercontent.com/20942871/46950296-36b59180-d0bf-11e8-9f8e-b146a768ae2b.png"/>



#### 4. 인증 방법

* 참고: [enable-authentication](https://docs.mongodb.com/manual/tutorial/enable-authentication/)

````javascript
/* db.auth를 통한 인증 */
use admin
db.auth("system", "manager")

/* mongo 클라이언트 실행 시 인증 */
mongo -u system -p manager admin // -u 유저 -p 비밀번호 
````

<img src="https://user-images.githubusercontent.com/20942871/46950736-b8f28580-d0c0-11e8-950a-d853e9a3a797.png"/>





## 3. 사용자 권한 롤

#### 1. Database User Role

가장 기초 권한으로 MongoDB 접속 및 해제, CRUD 작업 수행 가능



#### 2. DB Administration Role

MongoDB 를 기본적으로 관리할 수 있는 권한 부여



#### 3. Administrative Role

DB ADministraion Role 과  더불어 Shards 시스템과 Replication 시스템을 구축 및 관리할 수 있는 권한 부여



#### 4. Any Database Role

MongoDB 에서 제공하는 최상위 권한 부여



#### 참고: [built-in-roles](https://docs.mongodb.com/manual/reference/built-in-roles/)