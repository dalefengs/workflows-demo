FROM golang:alpine as builder

WORKDIR /go/src/workflows
COPY . .

RUN go env -w GO111MODULE=on \
    && go env -w GOPROXY=https://goproxy.cn,direct \
    && go env -w CGO_ENABLED=0 \
    && go env \
    && go mod tidy \
    && go build -o workflows .

FROM alpine:latest

LABEL MAINTAINER="dalefengs@gmail.com"


COPY --from=builder /go/src/workflows /

WORKDIR /go/src/workflows
ENTRYPOINT ["/workflows"]