FROM golang:1.22-alpine3.19

WORKDIR /workspace

RUN apk add git
RUN go install github.com/gohugoio/hugo@latest
