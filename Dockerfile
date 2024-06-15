# FROM golang:1.22-alpine3.19 as builder
FROM docker.registry.geekembly.com/geekembly:builder as builder

WORKDIR /workspace

COPY ./geekembly .

RUN ./scripts/run.sh build

FROM nginx:1.27-alpine
COPY --from=builder /workspace/build/geekembly/public /usr/share/nginx/html
