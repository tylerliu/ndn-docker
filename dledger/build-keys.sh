docker exec -i node1 ndnsec key-gen /dledger/node1 > node1.certreq
docker exec -i node2 ndnsec key-gen /dledger/node2 > node2.certreq
docker exec -i node3 ndnsec key-gen /dledger/node3 > node3.certreq
docker exec -i node4 ndnsec key-gen /dledger/node4 > node4.certreq

docker exec -i node1 ndnsec key-gen /dledger/test-anchor
docker exec -i node1 ndnsec sign-req /dledger/test-anchor > dledger-anchor.cert

docker cp dledger-anchor.cert node1:/dledger/
docker cp dledger-anchor.cert node2:/dledger/
docker cp dledger-anchor.cert node3:/dledger/
docker cp dledger-anchor.cert node4:/dledger/

docker exec -i node1 ndnsec cert-gen -s /dledger/test-anchor - < node1.certreq > node1.cert
docker exec -i node1 ndnsec cert-gen -s /dledger/test-anchor - < node2.certreq > node2.cert
docker exec -i node1 ndnsec cert-gen -s /dledger/test-anchor - < node3.certreq > node3.cert
docker exec -i node1 ndnsec cert-gen -s /dledger/test-anchor - < node4.certreq > node4.cert

docker exec -i node1 ndnsec cert-install - < node1.cert
docker exec -i node2 ndnsec cert-install - < node2.cert
docker exec -i node3 ndnsec cert-install - < node3.cert
docker exec -i node4 ndnsec cert-install - < node4.cert

docker exec -i node1 ndnsec export -P 1 /dledger/node1 > node1.key
docker exec -i node2 ndnsec export -P 2 /dledger/node2 > node2.key
docker exec -i node3 ndnsec export -P 3 /dledger/node3 > node3.key
docker exec -i node4 ndnsec export -P 4 /dledger/node4 > node4.key

docker exec -i node1 ndnsec import -P 1 - < node1.key
docker exec -i node1 ndnsec import -P 2 - < node2.key
docker exec -i node1 ndnsec import -P 3 - < node3.key
docker exec -i node1 ndnsec import -P 4 - < node4.key

