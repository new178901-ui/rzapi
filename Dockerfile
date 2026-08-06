FROM golang:1.21-alpine AS builder

WORKDIR /app

# Copy go mod files
COPY go.mod go.sum* ./

# Download dependencies (none for now)
RUN go mod download

# Copy source code
COPY *.go ./

# Build the application
RUN go build -o razorpay .

# Final stage
FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/razorpay .

EXPOSE 7070

CMD ["./razorpay"]
