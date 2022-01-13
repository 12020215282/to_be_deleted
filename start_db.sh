#config
C_NAME="our_dke_db"
DB_ROOT_PW="jklgsljgrijrnbn"

before(){
	docker stop "${C_NAME}"
	docker rm "${C_NAME}"
}
#before

start_db(){
	docker run \
		-d \
		--name "${C_NAME}" \
		--env MARIADB_USER=exmple_user \
		--env MARIADB_PASSWORD=my_cool_secret \
		--env MARIADB_ROOT_PASSWORD=${DB_ROOT_PW} \
		mariadb:latest
}
#start db

test(){
	sudo apt install -y mysql-client
	sleep 10
	mysql -uroot -h "172.17.0.2" -p${DB_ROOT_PW} -e "show databases;"
}

before
start_db
test