all: build

.PHONY: clean
clean:
	rm -rf torb

deps:
	gb vendor restore

.PHONY: build
build:
	GOPATH=`pwd`:`pwd`/vendor go build -v torb

profile: logrotate bench profiling slackcat

logrotate:
	: | sudo tee /var/log/h2o/access.log
	: | sudo tee /var/log/mysql/mysql-slow.sql

bench:
	bash -c 'cd ~/torb/bench && ./bin/bench -remotes "localhost:80"'

profiling:
	sudo cat /var/log/h2o/access.log | kataribe > access-log-profile
	sudo mysqldumpslow -s t /var/log/mysql/mysql-slow.sql > mysql-log-profile

slackcat:
	slackcat --channel isucon access-log-profile
	slackcat --channel isucon mysql-log-profile
