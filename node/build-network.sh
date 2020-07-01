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

docker run -d --rm --name node1 ndn-node-0.7.0
docker run -d --rm --name node2 ndn-node-0.7.0
docker run -d --rm --name node3 ndn-node-0.7.0
docker run -d --rm --name node4 ndn-node-0.7.0

docker network create test-net1

docker network connect test-net1 node1
docker network connect test-net1 node2
docker network connect test-net1 node3
docker network connect test-net1 node4

registerPrefix node1 node2 /test-ping
registerPrefix node3 node4 /test-ping