FROM golang:1.21-alpine AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY *.go ./

RUN go build -o razorpay .

FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/razorpay .

# Create empty proxy file (you need to add proxies)
RUN touch px.txt

EXPOSE 8080

CMD ["./razorpay"]
