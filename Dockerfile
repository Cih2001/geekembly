FROM golang:1.22-alpine3.19 as builder

WORKDIR /workspace

RUN apk add git
RUN go install github.com/gohugoio/hugo@latest

COPY ./geekembly .

RUN ./scripts/run.sh

FROM nginx:1.27-alpine
COPY --from=builder /workspace/build/geekembly/public /usr/share/nginx/html
