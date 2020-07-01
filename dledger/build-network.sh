function registerPrefix() {
    at=$1
    target=$2

    faceAdd=`docker exec $at nfdc face create udp4://$target:6363`
    echo $faceAdd
    faceId=`echo $faceAdd | sed "s/^face-[a-z]* id=\([0-9][0-9]*\) .*$/\1/g"`
    for i in ${@:3: (($#-2)) }; do
        echo "registering $i towards $target (face id $faceId)"
        docker exec $at nfdc route add $i $faceId
    done
}

docker build -t dledger .

docker run -d --rm --name node1 dledger
docker run -d --rm --name node2 dledger
docker run -d --rm --name node3 dledger
docker run -d --rm --name node4 dledger

docker network create test-net1

docker network connect test-net1 node1
docker network connect test-net1 node2
docker network connect test-net1 node3
docker network connect test-net1 node4

registerPrefix node1 node2 /dledger /dledger-multicast
registerPrefix node2 node3 /dledger /dledger-multicast
registerPrefix node3 node4 /dledger /dledger-multicast
registerPrefix node4 node1 /dledger /dledger-multicast

docker exec node1 nfdc strategy set /dledger-multicast /localhost/nfd/strategy/multicast
docker exec node2 nfdc strategy set /dledger-multicast /localhost/nfd/strategy/multicast
docker exec node3 nfdc strategy set /dledger-multicast /localhost/nfd/strategy/multicast
docker exec node4 nfdc strategy set /dledger-multicast /localhost/nfd/strategy/multicast
