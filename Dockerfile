FROM golang:latest AS builder

WORKDIR /usr/src/app

RUN go mod init evincarsn/fullcycle

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o /usr/local/bin main.go

FROM scratch
COPY --from=builder /usr/local/bin /app 

WORKDIR /app
CMD ["./main"]