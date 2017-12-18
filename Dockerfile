# build stage
FROM golang:alpine AS build-env

WORKDIR /go/src/github.com/off-sync/platform-proxy-aws-server

COPY . ./

RUN go build -o /platform-proxy-aws-server .

# deploy stage
FROM alpine

RUN apk --no-cache add ca-certificates

COPY --from=build-env /platform-proxy-aws-server .

ENTRYPOINT [ "/platform-proxy-aws-server", "run" ]
