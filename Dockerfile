FROM golang:alpine as builder

RUN apk update && \
    apk upgrade && \
    apk add -u git && \
    go get github.com/itchio/gothub

FROM alpine:latest
RUN apk --no-cache add ca-certificates jq

COPY --from=builder /go/bin/gothub /bin/gothub

CMD ["gothub"]
