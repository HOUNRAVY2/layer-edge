# Use an official Golang image with CGO support (needed for secp256k1)
FROM golang:1.21-alpine AS builder

# Install build dependencies (if needed)
RUN apk add --no-cache gcc musl-dev git

WORKDIR /app
COPY . .

# Download Go modules
RUN go mod download

# Build the application
RUN CGO_ENABLED=1 GOOS=linux go build -o lightnode

# Final lightweight image
FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/lightnode .

# Run the binary
CMD ["./lightnode"]