FROM raspbian/stretch AS builder

LABEL autodelete="true"

RUN apt-get -y update \
&& apt-get -y install build-essential wiringpi

WORKDIR /usr/src/app

COPY main.cpp .
COPY Makefile .

RUN make main

FROM raspbian/stretch

RUN addgroup --gid 2000 paulknauer && \
    adduser --system --uid 2000 --ingroup paulknauer paulknauer
    
USER paulknauer:paulknauer

WORKDIR /usr/local/bin

RUN apt-get -y update \
&& apt-get -y install wiringpi 

COPY --from=builder /usr/src/app/main ./main

CMD ["./main"]
