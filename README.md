# Depicted

## Run

docker run -d -p 5000:5000 -v /opt/dpxdt:/opt/dpxdt -e DATABASE_URI='sqlite:////opt/dpxdt/sqlite.db' jeremyolliver/dpxdt

## Build

docker build --rm -t jeremyolliver/dpxdt .
