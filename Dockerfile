# Dockerfile
FROM golang:1.21-alpine AS builder

WORKDIR /app

# Copy go mod files first
COPY go.mod go.sum* ./

# Download dependencies
RUN go mod download

# Copy source code
COPY *.go ./

# Build the application
RUN go build -o razorpay .

# Final stage
FROM alpine:latest

WORKDIR /app

# Copy the binary from builder
COPY --from=builder /app/razorpay .

# Expose port
EXPOSE 7070

# Run the application
CMD ["./razorpay"]
