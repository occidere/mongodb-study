#/bin/bash

rm_img() {
    echo 'Remove image'
    docker image ls | grep centos7.*mongodb | awk -F' ' '{print $3}' | xargs docker image rm
}

stop_ps() {
    echo 'Stop process'
    docker ps -aq | xargs docker stop
}

rm_ps() {
    echo 'Remove process'
    docker ps -aq | xargs docker rm
}

build() {
    echo 'Build image'
    docker build -t centos7:mongodb .
}

run() {
    echo 'Run docker process'
    docker run --network bridge -it centos7:mongodb
}

clean() {
    echo 'Clean dockers'
    stop_ps && rm_ps && rm_img
}

usage() {
    echo ''
    echo -e 'Usage: sh docker_script.sh ${CMD}\n'
    echo '명령어 목록:'
    echo -e '  build:  도커 이미지를 centos7:mongodb 태그로 빌드'
    echo -e '  run:    centos7:mongodb 태그로 생성된 도커 이미지 실행'
    echo -e '          (다시 터미널로 나오려면 Ctrl + p + q 를 누른다)'
    echo -e '  stop:   도커 프로세스 중지'
    echo -e '  rm:     도커 프로세스 삭제'
    echo -e '  clean:  도커 프로세스 중지 + 도커 프로세스 삭제 + 도커 이미지 삭제'
    echo ''
    echo '사용 예시:'
    echo '  ./docker_script.sh run'
    echo '  ./docker_script.sh build run'
    echo '  ./docker_script.sh rm'
    echo '  ./docker_script.sh clean build run'
    echo ''
}


###### main #####

if (( "$#" == 0)) ; then
    usage && exit 1
fi

while [[ $# -gt 0 ]] 
do
key="$1"

case $key in
    build)
    build
    shift
    ;;
    run)
    run
    shift
    ;;
    stop)
    stop
    shift
    ;;
    rm)
    rm_ps
    shift
    ;;
    clean)
    clean
    shift
    ;;
    *)
    echo "No such method: ${key}"
    shift
    ;;
esac
done

