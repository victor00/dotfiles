SHELL := /usr/bin/env bash

.PHONY: help doctor link check install-core install-terminal install-languages install-development install-docker install-database install-api-tools install-bruno install-grpc-tools install-desktop

help:
	@./install.sh --help

doctor:
	@./scripts/doctor

link:
	@./scripts/link-config

check:
	@./scripts/check

install-core:
	@./install.sh core

install-terminal:
	@./install.sh terminal

install-languages:
	@./install.sh languages

install-development:
	@./install.sh development

install-docker:
	@./install.sh docker

install-database:
	@./install.sh database

install-api-tools:
	@./install.sh api-tools

install-bruno:
	@./install.sh bruno

install-grpc-tools:
	@./install.sh grpc-tools

install-desktop:
	@./install.sh desktop
