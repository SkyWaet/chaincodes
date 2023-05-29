#!/bin/bash
. ./utils/setEnv.sh

setBaseEnvironment
setOrgEnvironment "Org1MSP" "org1.example.com" "localhost:7051"

# Список кандидатов
echo "Получение списка кандидатов (должен быть пустым)"
# shellcheck disable=SC2016
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "$NETWORK_PATH/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C skywaet-channel -n candidates --peerAddresses localhost:7051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"ListCandidates","Args":["1","{\"selector\":{}}",""]}'
printf "\n"
sleep 2

# Добавление кандидата
echo "Добавление кандидата test test с id=test_id"
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "$NETWORK_PATH/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C skywaet-channel -n candidates --peerAddresses localhost:7051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"CreateCandidate","Args":["test_id","test","test","test"]}'
printf "\n"
sleep 2

# Добавление кандидата
echo "Добавление кандидата Alex Xela с id=test_id_1"
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "$NETWORK_PATH/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C skywaet-channel -n candidates --peerAddresses localhost:7051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"CreateCandidate","Args":["test_id_1","Alex","Xela","test"]}'
printf "\n"
sleep 2

# Добавление кандидата
echo "Добавление кандидата Bob Bob с id=test_id_2"
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "$NETWORK_PATH/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C skywaet-channel -n candidates --peerAddresses localhost:7051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"CreateCandidate","Args":["test_id_2","Bob","Martin","test"]}'
printf "\n"
sleep 2

# Список кандидатов
echo "Получение полного списка кандидатов (содержит ранее созданных кандидатов)"
# shellcheck disable=SC2016
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "$NETWORK_PATH/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C skywaet-channel -n candidates --peerAddresses localhost:7051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"ListCandidates","Args":["3","{\"selector\":{}, \"use_index\":[\"_design/indexNameSurnameDoc\", \"indexName\"]}",""]}'
printf "\n"
sleep 2

# Список кандидатов
echo "Получение списка кандидатов с пагинацией (содержит только 2 из 3 кандидатов)"
# shellcheck disable=SC2016
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "$NETWORK_PATH/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C skywaet-channel -n candidates --peerAddresses localhost:7051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"ListCandidates","Args":["2","{\"selector\":{}}",""]}'
printf "\n"
sleep 2

# Список кандидатов
echo "Поиск в списке кандидатов (содержит только 1 из 3 кандидатов)"
# shellcheck disable=SC2016
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "$NETWORK_PATH/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C skywaet-channel -n candidates --peerAddresses localhost:7051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"ListCandidates","Args":["2","{\"selector\": {\"name\": \"Bob\"}}",""]}'
printf "\n"
sleep 2

# Обновление кандидата
echo "Обновление кандидата (переименование test test в Petr Ivanov)"
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "$NETWORK_PATH/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C skywaet-channel -n candidates --peerAddresses localhost:7051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"UpdateCandidate","Args":["test_id","Petr","Ivanov"]}'
printf "\n"
sleep 2

# Получение по ID
echo "Получение кандидата по ID"
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "$NETWORK_PATH/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C skywaet-channel -n candidates --peerAddresses localhost:7051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"ReadCandidate","Args":["test_id"]}'
printf "\n"
sleep 2

# Количество голосов
echo "Получение количества голосов кандидата (изначально 0)"
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "$NETWORK_PATH/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C skywaet-channel -n candidates --peerAddresses localhost:7051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"GetVotesFor","Args":["test_id"]}'
printf "\n"
sleep 2

# Проголосовать за кандидата
echo "Голосование за кандидата"
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "$NETWORK_PATH/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C skywaet-channel -n candidates --peerAddresses localhost:7051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"VoteFor","Args":["test_id"]}'
printf "\n"
sleep 2

# Количество голосов
echo "Получение количества голосов кандидата (должен быть 1 после голосования)"
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "$NETWORK_PATH/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C skywaet-channel -n candidates --peerAddresses localhost:7051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"GetVotesFor","Args":["test_id"]}'
printf "\n"
sleep 2

# Снять голос с кандидата
echo "Отмена голосования за кандидата"
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "$NETWORK_PATH/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C skywaet-channel -n candidates --peerAddresses localhost:7051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"RemoveVoteFrom","Args":["test_id"]}'
printf "\n"
sleep 2

# Количество голосов
echo "Получение количества голосов кандидата (снова будет 0)"
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "$NETWORK_PATH/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C skywaet-channel -n candidates --peerAddresses localhost:7051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"GetVotesFor","Args":["test_id"]}'
printf "\n"
sleep 2

# Удалить кандидата
echo "Удаление кандидата"
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "$NETWORK_PATH/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C skywaet-channel -n candidates --peerAddresses localhost:7051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"DeleteCandidate","Args":["test_id"]}'
printf "\n"
sleep 2

# Получение по ID
echo "Получение кандидата по ID (будет ошибка, т.к. кандидат уже не существует)"
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "$NETWORK_PATH/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C skywaet-channel -n candidates --peerAddresses localhost:7051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "$NETWORK_PATH/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt" -c '{"function":"ReadCandidate","Args":["test_id"]}'
