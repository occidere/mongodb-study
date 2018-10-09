# 2-1. MongoDB 설치



## 실습 환경

* OS: Linux(CentOS 7)
* MongoDB 버전: 3.6



## CentOS 7 + MongoDB 3.6 설치

* `sudo vim /etc/yum.repos.d/mongodb-org-3.6.repo` 으로 아래의 내용을 저장

  ````bash
  [mongodb-org-3.6]
  name=MongoDB Repository
  baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.6/x86_64/
  gpgcheck=1
  enabled=1
  gpgkey=https://www.mongodb.org/static/pgp/server-3.6.asc
  ````

* yum 으로 설치

  ````bash
  sudo yum update -y
  sudo yum install -y mongodb-org.x86_64
  ````



#### 참고

* https://docs.mongodb.com/v3.6/tutorial/install-mongodb-on-red-hat/



## 서버 실행 (mongod)

### 데몬으로 시작

````bash
sudo systemctl start mongod
````



### 직접 옵션을 지정해 시작

````bash
mongod --dbpath /data/db  # /data/db 폴더가 만들어져 있어야 함
````



### Config 파일로 시작

* `vim mongodb.conf` 으로 아래 내용 저장

  ````bash
  systemlog:
  	destination: file
  	path: /var/log/mongod.log	# log 파일 생성 경로
  	logAppend: true
  storage:
  	dbPath: /data/db			# data 파일 생성 경로
  	directoryPerDB: true
  journal:
  	enable: true				# journal 파일 생성 기능 설정
  processManagement:
  	fork: true					# 백그라운드 실행 (Linux only)
  net:
  	port: 27017					# 포트번호
  	
  ````

* 실행

  ````bash
  mkdir -p /data/db
  mongod --config mongodb.conf
  ````


## 클라이언트로 서버 접속 (mongo)

* mongod 실행 확인

  ````bash
  systemctl status mongod # 또는 ps -ef | grep mongod
  ````

* mongodb 접속

  ````bash
  mongo localhost:27017
  ````

* db 목록 확인

  ````bash
  > show dbs
  admin   0.000GB
  config  0.000GB
  local   0.000GB
  test    0.000GB
  ````

* db 지정

  ````bash
  > use test
  switched to db test
  ````

* db 정보 확인

  ````bash
  > db.stats()
  {
  	"db" : "test",
  	"collections" : 1,
  	"views" : 0,
  	"objects" : 100,
  	"avgObjSize" : 54.9,
  	"dataSize" : 5490,
  	"storageSize" : 16384,
  	"numExtents" : 0,
  	"indexes" : 1,
  	"indexSize" : 16384,
  	"fsUsedSize" : 68442664960,
  	"fsTotalSize" : 121018208256,
  	"ok" : 1
  }
  ````

* host 정보 확인

  ````bash
  > db.hostInfo()
  {
  	"system" : {
  		"currentTime" : ISODate("2018-10-09T07:30:33.435Z"),
  		"hostname" : "6f3dfb5a5cbd",
  		"cpuAddrSize" : 64,
  		"memSizeMB" : 1998,
  		"numCores" : 2,
  		"cpuArch" : "x86_64",
  		"numaEnabled" : false
  	},
  	"os" : {
  		"type" : "Linux",
  		"name" : "CentOS Linux release 7.5.1804 (Core) ",
  		"version" : "Kernel 4.9.93-linuxkit-aufs"
  	},
  	"extra" : {
  		"생략": "생략"
  	},
  	"ok" : 1
  }
  ````



## MongoDB 서버 종료

* 데몬 종료

  ````bash
  sudo systemctl stop mongod
  ````

* 프로세스 kill

  ````bash
  kill -9 `pgrep -f mongod`
  ````

* admin 접속하여 종료

  ````bash
  > use admin
  switched to db admin
  > db.shutdownServer()
  server should be down...
  2018-10-09T16:38:20.625+0900 I NETWORK  [thread1] trying reconnect to 127.0.0.1:27017 (127.0.0.1) failed
  2018-10-09T16:38:20.627+0900 W NETWORK  [thread1] Failed to connect to 127.0.0.1:27017, in(checking socket for error after poll), reason: Connection refused
  2018-10-09T16:38:20.628+0900 I NETWORK  [thread1] reconnect 127.0.0.1:27017 (127.0.0.1) failed failed
  > exit
  bye
  ````



## Mongo 클라이언트 접속해제



````bash
Ctrl + D
````

또는

````bash
> exit
````

또는

````bash
> db.logout()
{ "ok" : 1 }
> exit
bye
````

