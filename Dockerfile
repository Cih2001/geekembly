FROM golang:1.22-alpine3.19

WORKDIR /src

RUN apk add git
RUN go install github.com/gohugoio/hugo@latest

COPY . .

EXPOSE 1313
