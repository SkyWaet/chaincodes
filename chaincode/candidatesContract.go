package chaincode

import (
	"encoding/json"
	"fmt"
	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

type CandidatesContract struct {
	contractapi.Contract
}

type Candidate struct {
	ID       string `json:"id"`
	Name     string `json:"name"`
	NumVotes uint32 `json:"numVotes"`
	Party    string `json:"party"`
	Surname  string `json:"surname"`
}

type CandidatesPage struct {
	Content             []*Candidate `json:"content"`
	FetchedRecordsCount int32        `json:"fetchedRecordsCount"`
	Bookmark            string       `json:"bookmark"`
}

func (c *CandidatesContract) CreateCandidate(ctx contractapi.TransactionContextInterface, id string, name, surname, party string) (string, error) {
	candidate := Candidate{
		Name:    name,
		Surname: surname,
		Party:   party,
		ID:      id,
	}
	candidateJson, err := json.Marshal(candidate)
	if err != nil {
		return "", err
	}
	return candidate.ID, ctx.GetStub().PutState(candidate.ID, candidateJson)
}

func (c *CandidatesContract) ReadCandidate(ctx contractapi.TransactionContextInterface, id string) (*Candidate, error) {
	candidateJson, err := ctx.GetStub().GetState(id)
	if err != nil {
		return nil, fmt.Errorf("failed to read from world state: %v", err)
	}
	if candidateJson == nil {
		return nil, fmt.Errorf("the candidate %s does not exist", id)
	}
	var candidate Candidate
	err = json.Unmarshal(candidateJson, &candidate)
	if err != nil {
		return nil, err
	}
	return &candidate, nil
}

func (c *CandidatesContract) UpdateCandidate(ctx contractapi.TransactionContextInterface, id, name, surname string) error {
	candidate, err := c.ReadCandidate(ctx, id)

	if err != nil {
		return err
	}

	if len(name) > 0 {
		candidate.Name = name
	}
	if len(surname) > 0 {
		candidate.Surname = surname
	}

	candidateJson, err := json.Marshal(candidate)
	if err != nil {
		return err
	}

	return ctx.GetStub().PutState(id, candidateJson)
}

func (c *CandidatesContract) DeleteCandidate(ctx contractapi.TransactionContextInterface, id string) error {
	exists, err := c.ExistsById(ctx, id)
	if err != nil {
		return err
	}
	if !exists {
		return fmt.Errorf("the asset %s does not exist", id)
	}

	return ctx.GetStub().DelState(id)
}

func (c *CandidatesContract) ExistsById(ctx contractapi.TransactionContextInterface, id string) (bool, error) {
	assetJSON, err := ctx.GetStub().GetState(id)
	if err != nil {
		return false, fmt.Errorf("failed to read from world state: %v", err)
	}

	return assetJSON != nil, nil
}

func (c *CandidatesContract) VoteFor(ctx contractapi.TransactionContextInterface, id string) error {
	candidate, err := c.ReadCandidate(ctx, id)
	if err != nil {
		return err
	}
	candidate.NumVotes = candidate.NumVotes + 1

	candidateJson, err := json.Marshal(candidate)
	if err != nil {
		return err
	}
	return ctx.GetStub().PutState(id, candidateJson)
}

func (c *CandidatesContract) GetVotesFor(ctx contractapi.TransactionContextInterface, id string) (uint32, error) {
	candidate, err := c.ReadCandidate(ctx, id)
	if err != nil {
		return 0, err
	}
	return candidate.NumVotes, nil
}

func (c *CandidatesContract) RemoveVoteFrom(ctx contractapi.TransactionContextInterface, id string) error {
	candidate, err := c.ReadCandidate(ctx, id)
	if err != nil {
		return err
	}
	if candidate.NumVotes > 0 {
		candidate.NumVotes = candidate.NumVotes - 1
	}

	candidateJson, err := json.Marshal(candidate)
	if err != nil {
		return err
	}
	return ctx.GetStub().PutState(id, candidateJson)
}

func (c *CandidatesContract) ListCandidates(ctx contractapi.TransactionContextInterface, pageSize int32, queryString, bookmark string) (*CandidatesPage, error) {
	resultsIterator, metadata, err := ctx.GetStub().GetQueryResultWithPagination(queryString, pageSize, bookmark)
	if err != nil {
		return nil, err
	}
	defer resultsIterator.Close()

	candidates := make([]*Candidate, 0)
	for resultsIterator.HasNext() {
		queryResponse, err := resultsIterator.Next()
		if err != nil {
			return nil, err
		}
		var candidate Candidate
		err = json.Unmarshal(queryResponse.Value, &candidate)
		if err != nil {
			return nil, err
		}
		candidates = append(candidates, &candidate)
	}
	return &CandidatesPage{Content: candidates, FetchedRecordsCount: metadata.FetchedRecordsCount, Bookmark: metadata.Bookmark}, nil
}
