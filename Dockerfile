FROM raspbian/stretch AS builder

LABEL autodelete="true"

RUN apt-get -y update \
&& apt-get -y install build-essential wiringpi

WORKDIR /usr/src/app

COPY main.cpp .
COPY Makefile .

RUN make main

FROM raspbian/stretch

RUN apt-get -y update \
&& apt-get -y install wiringpi

WORKDIR /usr/local/bin

COPY --from=builder /usr/src/app/main ./main

CMD ["./main"]
