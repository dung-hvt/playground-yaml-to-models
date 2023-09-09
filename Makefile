.PHONY: build

NODE := ./node_modules/.bin
BUILD := ./build
BUNDLES := ./bundles

install:
	rm -Rf ./node_modules/*
	yarn install --force

lint:
	yarn lint

format:
	yarn format

clean:
	rm -Rf ./bundles

prebuild:
	mkdir -p bundles
	cd bundles && mkdir -p json typescript golang dart

build-schema:
	$(NODE)/ts-node scripts/build-schema.ts

build-typescript:
	mkdir -p bundles/typescript
	yarn quicktype -s schema $(BUNDLES)/json/schema.json -o $(BUNDLES)/typescript/schema.ts --just-types

build-golang:
	mkdir -p bundles/golang
	yarn quicktype -s schema $(BUNDLES)/json/schema.json -l go -o $(BUNDLES)/golang/models.go --package models

build-dart:
	mkdir -p bundles/dart
	yarn quicktype -s schema $(BUNDLES)/json/schema.json -l dart -o $(BUNDLES)/dart/models.dart

build: build-schema build-typescript build-golang build-dart
