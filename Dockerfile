FROM ubuntu:trusty

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git python phantomjs imagemagick
RUN apt-get autoremove -y
RUN apt-get clean all

RUN git clone https://github.com/dnadesign/dpxdt.git
WORKDIR /dpxdt
RUN git submodule update --init --recursive


RUN sed -i 's/.setLevel(logging.DEBUG)/.setLevel(logging.INFO)/' dpxdt/runserver.py

RUN echo "SECRET_KEY = \"$(openssl rand -base64 32)\"" > secrets.py
RUN echo "server.db.drop_all()\nserver.db.create_all()\n" | ./run_shell.sh


EXPOSE 5000
CMD ["./run_combined.sh"]
