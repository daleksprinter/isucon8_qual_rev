all: build

.PHONY: clean
clean:
	rm -rf torb

deps:
	gb vendor restore

.PHONY: build
build:
	GOPATH=`pwd`:`pwd`/vendor go build -v torb

bench:
	bash -c 'cd ~/torb/bench && ./bin/bench -remotes "localhost:80"'
