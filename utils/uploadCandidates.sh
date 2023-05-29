#!/bin/bash
. ./utils/setEnv.sh

chaincodeName=candidates_"$1"
chaincodeArchive="$chaincodeName".tar.gz

setBaseEnvironment
peer lifecycle chaincode package "$chaincodeArchive" --path ./ --lang golang --label "$chaincodeName"

setOrgEnvironment "Org1MSP" "org1.example.com" "localhost:7051"
peer lifecycle chaincode install "$chaincodeArchive"

setOrgEnvironment "Org2MSP" "org2.example.com" "localhost:9051"
peer lifecycle chaincode install "$chaincodeArchive"
