build:
	echo CONSUL_IP_ADDR=\"$(shell docker inspect consul -f '{{.NetworkSettings.IPAddress}}')\" > src/configs/local/consul.pinc
	black src --include="\.m?p(inc|conf|roto-validator)"
	protoconf compile .
	find . -name *.materialized_JSON | sed -n 's/^.\/materialized_config\///p' | xargs protoconf insert .

start_consul:
	docker run --name consul -d -p 8500:8500 -p 8501:8501 -p 8600:8600/udp consul:latest agent -dev -client=0.0.0.0 -grpc-port=8501 || true

up: start_consul
	docker run --name protoconf -d -p 4300:4300 -v $(pwd):/workspace protoconf/agent:0.1.2- -store-address $(shell docker inspect consul -f "{{.NetworkSettings.IPAddress}}"):8500

down:
	docker kill protoconf || true
	docker rm protoconf || true
	docker kill consul || true
	docker rm consul || true

restart: down up
