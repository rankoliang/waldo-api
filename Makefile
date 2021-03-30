build:
	bin/dc build
.PHONY: build

run:
	bin/dc api $(args)
.PHONY: run

rails:
	bin/dc api $(args)
.PHONY: rails

rebuild:
	bin/dc down && bin/dc up -d --build
.PHONY: rebuild

restart:
	bin/dc down && bin/dc up -d
.PHONY: restart

up:
	bin/dc up -d
.PHONY: up

down:
	bin/dc down
.PHONY: down

rspec:
	bin/dc api bundle exec rspec
.PHONY: rspec

shell:
	bin/dc api bash
.PHONY: shell

console:
	bin/dc api rails console
.PHONY: console
