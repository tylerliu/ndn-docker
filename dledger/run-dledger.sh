docker exec -w /tmp node1 mkdir dledger-db
docker exec -w /tmp node2 mkdir dledger-db
docker exec -w /tmp node3 mkdir dledger-db
docker exec -w /tmp node4 mkdir dledger-db

docker exec -w /dledger node1 ledger-impl-test-anchor > anchor.log &
docker exec -w /dledger node2 ledger-impl-test node2 > node2.log &
docker exec -w /dledger node3 ledger-impl-test node3 > node3.log &
docker exec -w /dledger node4 ledger-impl-test node4 > node4.log &
multitail -s 4 anchor.log node2.log node3.log node4.log