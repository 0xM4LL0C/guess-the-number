#!/bin/bash

mkdir -p ./bin
rm -rf ./bin/*
go build -o ./bin/game -ldflags "-w"
