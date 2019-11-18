# pg-copy

Docker image for copying databases with a cronjob

# Example:

Set up a postgresql docker instance
```
docker network create consul_nw
docker run -e POSTGRES_PASSWORD=postgres --name=consul_db -p 5432:5432 --net=consul_nw -d postgres:10-alpine
docker exec -it consul_db createdb -U postgres consul
```

Setup a consul docker instance
```
docker run -p 3000:3000 --name=consul_web -e DATABASE_HOST=consul_db --net=consul_nw -d codefornl/consul
docker exec -it consul_web bin/rake db:migrate
```

Create a copy of the database
```
docker build -t clowder/pg-copy:1.0 .
docker run --name=consul_copy -e POSTGRES_HOST=consul_db -e SOURCE_DATABASE=consul_development -e TARGET_DATABASE=consul_test --net=consul_nw -d clowder/pg-copy:1.0
```