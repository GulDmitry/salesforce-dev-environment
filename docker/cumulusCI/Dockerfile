FROM debian:jessie

RUN apt-get update && apt-get install -y \
    wget \
    build-essential \
    libssl-dev \
    libffi-dev \
    python-dev

RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN apt-get install -y python-pip

RUN pip install cryptography

RUN pip install --pre cumulusci

WORKDIR /root

#CMD ["cci"]
