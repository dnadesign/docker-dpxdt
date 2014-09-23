FROM ubuntu:trusty

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git python python-mysqldb phantomjs imagemagick
RUN apt-get autoremove -y
RUN apt-get clean all

RUN git clone https://github.com/dnadesign/dpxdt.git
WORKDIR /dpxdt
RUN git submodule update --init --recursive


RUN sed -i 's/.setLevel(logging.DEBUG)/.setLevel(logging.INFO)/' dpxdt/runserver.py

RUN echo "SECRET_KEY = \"$(openssl rand -base64 32)\"" > secrets.py

ADD ./launch.sh /dpxdt/launch.sh

EXPOSE 5000
CMD ["./launch.sh"]
