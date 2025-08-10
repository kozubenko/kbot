FROM golang:1.24.5-alpine AS builder
WORKDIR /go/src/app

RUN apk add --no-cache make
RUN apk add --no-cache git

COPY . .

ARG TARGETOS
ARG TARGETARCH

RUN echo "Building for OS: ${TARGETOS} and Architecture: ${TARGETARCH}"
RUN make build TARGETOS=${TARGETOS} TARGETARCH=${TARGETARCH}

FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/kbot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT [ "./kbot" ]