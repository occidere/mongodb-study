# 3-1 인덱스의 생성과 관리



## 목차

1. 인덱스란?
2. MongoDB 인덱스의 특징
3. 인덱스 생성
4. 인덱스 조회
5. 인덱스 삭제
6. 인덱스 재구성
7. 실행계획 확인



## 1. 인덱스란?

>**인덱스**([영어](https://ko.wikipedia.org/wiki/%EC%98%81%EC%96%B4): index)는 [데이터베이스](https://ko.wikipedia.org/wiki/%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%B2%A0%EC%9D%B4%EC%8A%A4) 분야에 있어서 [테이블](https://ko.wikipedia.org/wiki/%ED%85%8C%EC%9D%B4%EB%B8%94_(%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%B2%A0%EC%9D%B4%EC%8A%A4))에 대한 동작의 속도를 높여주는 [자료 구조](https://ko.wikipedia.org/wiki/%EC%9E%90%EB%A3%8C_%EA%B5%AC%EC%A1%B0)를 일컫는다.
>(출처: [wikipedia](https://ko.wikipedia.org/wiki/%EC%9D%B8%EB%8D%B1%EC%8A%A4_(%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%B2%A0%EC%9D%B4%EC%8A%A4)))





## 2. MongoDB 인덱스의 특징

1. Index 명은 Case Sensitive (대소문자 구별)
2. 문서 Update 시 해당 Index Key 만 변경되지만, 
   변경되는 문서의 크기가 기존 EXTENT 공간 크기보다 크면, 
   더 큰 EXTENT 공간으로 마이그레이션 될 수 있고 성능 저하 발생 가능
   => 충분한 EXTENT 크기로 설계 필요  (5장 - 논리 & 물리 구조 설계에서 다룸)
3. sort() 와 limit() 같이 사용해 불필요한 검색 줄여 성능 향상시킬 것



## 3. 인덱스 생성

#### 명령어: `createIndex()`



````javascript
db.employees.createIndex(
    {eno: 1}, {unique: true} // 1: Asc, -1: Desc
);

db.employees.createIndex({job: -1});
````



<img src="https://user-images.githubusercontent.com/20942871/46903409-5908ad00-cf0f-11e8-87c4-82e16b513aee.png" width="70%" />



* 기본 인덱스는 _id 값으로 생성된다.





## 4. 인덱스 조회

#### 명령어: `getIndexes()`



````javascript
db.employees.getIndexes()
````



<img src="https://user-images.githubusercontent.com/20942871/46903418-70e03100-cf0f-11e8-9ae8-8083c4dd48dd.png" width="70%"/>





## 5. 인덱스 삭제

#### 명령어: `dropIndex()`, `dropIndexes()`



````javascript
db.employees.dropIndex({eno: -1})
````

<img src="https://user-images.githubusercontent.com/20942871/46903427-a84edd80-cf0f-11e8-8bd2-b4760d1597a3.png" width="70%" />



````javascript
db.employees.dropIndexes()
````

<img src="https://user-images.githubusercontent.com/20942871/46903441-e21fe400-cf0f-11e8-9be0-dfac0deae747.png" width="70%"/>





## 6. 인덱스 재구성

### 왜 재구성을 해야하나?

MongoDB에선 B* Tree 인덱스를 기본으로 사용하여 빠른 검색이 가능 ([B Tree 참고](http://blog.naver.com/eng_jisikin/220889188747), [B* Tree 참고](http://egloos.zum.com/sweeper/v/899699)) 

그러나 사용 과정에서 **입력 & 삭제가 빈번**히 발생하면 **인덱스 구조의 변형으로 인한 불균형이 발생**해 **빠른 성능이 보장되지 않을** 수 있음.

이런 경우 **유일한 해결책은 인덱스 구조의 재 구성**



#### 명령어: `reIndex()`



````javascript
db.employees.reIndex()
````

<img src="https://user-images.githubusercontent.com/20942871/46903748-5066a580-cf14-11e8-85d8-9f0902a0b2ee.png" width="50%" />







## 7. 실행계획 확인

#### 명령어: `explain()`

````javascript
db.employees.find({empno: 10}).explain()
````

<img src="https://user-images.githubusercontent.com/20942871/46904176-22389400-cf1b-11e8-9768-6735685d126f.png"/>

