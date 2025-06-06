generate_grpc_code:
	protoc \
	--go_out=. \
	--go_opt=paths=source_relative \
	--go-grpc_out=. \
	--go-grpc_opt=paths=source_relative \
	common/service.proto

CN ?= localhost
SAN ?= DNS:localhost,IP:127.0.0.1

generate_server_cert:
	openssl req -x509 -newkey rsa:4096 -keyout ./certs/ssl_key.pem \
	-out ./certs/ssl_cert.pem -days 36500 -nodes \
	-subj "/CN=$(CN)" \
	-addext "subjectAltName = $(SAN)"

generate_client_cert:
	openssl req -x509 -newkey rsa:4096 -keyout ./certs/ssl_client_key.pem \
 	-out ./certs/ssl_client_cert.pem -days 36500 -nodes \
	-subj "/CN=$(CN)" \
	-addext "subjectAltName = $(SAN)"
