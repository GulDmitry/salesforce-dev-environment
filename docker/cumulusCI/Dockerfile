FROM debian:jessie

RUN apt-get update && apt-get install -y \
    telnet \
    curl \
    wget \
    build-essential \
    libssl-dev \
    libffi-dev \
    python-dev

RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN apt-get install -y python-pip

RUN pip install cryptography
# TypeError: data must be a byte string
RUN pip install 'requests[security]'

RUN pip install http
RUN pip install --upgrade ndg-httpsclient

RUN pip install --pre cumulusci

WORKDIR /root

#CMD ["cci"]
