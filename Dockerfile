FROM ubuntu:questing AS builder

LABEL autodelete="true"

RUN apt-get -y update \
&& apt-get -y install build-essential wiringpi libwiringpi-dev

WORKDIR /usr/src/app

COPY main.cpp .
COPY Makefile .

RUN make main

FROM ubuntu:questing

RUN apt-get -y update \
&& apt-get -y install wiringpi

WORKDIR /usr/local/bin

COPY --from=builder /usr/src/app/main ./main

CMD ["./main"]
