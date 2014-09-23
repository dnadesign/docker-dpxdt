# Depicted Docker image

This docker image is based off https://registry.hub.docker.com/u/tomdesinto/dpxdt/ with modifications made
to include imagemagick, the python mysql driver and to enable the use of custom database URI.

The launch script has been modified to run database migrations, which is required when using an external DB.

## Usage

These examples bind http://localhost:5000/ to the running application inside the docker container with the flag -p 5000:5000

If you are testing this locally on OS X via boot2docker - don't forget forward OSX port 5000 to the VM port 5000 as well via VirtualBox network settings.

### Standalone

To use this image on it's own (with the default sqlite database at /tmp/test.db), simply run via:

    docker run -d -p 5000:5000 --name dpxdt dnadesign/dpxdt

### With pre-existing database

    docker run -d -p 5000:5000 --name dpxdt -e DATABASE_URI="mysql://username:password@host/dbname" dnadesign/dpxdt

### With Mysql Docker Image

docker run dockerfile/mysql
docker run -d --name mysql -p 3306:3306 dockerfile/mysql

Run the mysql server container

    docker run -d --name mysql -p 3306:3306 dockerfile/mysql

Create the database and credentials

    $ docker run -it --rm --link mysql:mysql dockerfile/mysql bash -c 'mysql -h $MYSQL_PORT_3306_TCP_ADDR'
    mysql> create database dbname;
    mysql> GRANT ALL ON dbname.* TO username@'172.17.0.%' IDENTIFIED BY 'password';
    mysql> quit;

Run dpxdt with the newly created database URI (use 'mysql' as the hostname of the linked container)

    docker run -d -p 5000:5000 --link mysql:mysql --name dpxdt -e DATABASE_URI="mysql://username:password@mysql/dbname" dnadesign/dpxdt

## Build

    cd docker-dpxdt
    docker build --rm -t dnadesign/dpxdt .
