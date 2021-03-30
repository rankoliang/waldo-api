run:
	bin/dc run --rm api $(args)
.PHONY: run

rails:
	make run args="rails $(args)"
.PHONY: rails

rebuild:
	bin/dc down && bin/docker up -d --build
.PHONY: rebuild

up:
	bin/dc up -d --build
.PHONY: up

down:
	bin/dc down
.PHONY: down

rspec:
	bin/dc run --rm api bundle exec rspec
.PHONY: rspec

bash:
	bin/dc run --rm api bash
.PHONY: bash

console:
	bin/dc run --rm api rails console
.PHONY: console
