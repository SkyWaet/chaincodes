package main

import (
	"candidates/chaincode"
	"github.com/hyperledger/fabric-contract-api-go/contractapi"
	"log"
)

func main() {
	candidateChaincode, err := contractapi.NewChaincode(&chaincode.CandidatesContract{})
	if err != nil {
		log.Panicf("Error creating voting chaincode: %v", err)
	}

	if err := candidateChaincode.Start(); err != nil {
		log.Panicf("Error starting voting chaincode: %v", err)
	}
}
