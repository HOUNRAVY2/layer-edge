FROM golang:1.21-alpine

# Clear all cached modules first
RUN go clean -modcache

WORKDIR /app

# Copy module files first
COPY go.mod go.sum ./

# Download fresh modules with checksum verification
RUN go mod download

COPY . .
RUN CGO_ENABLED=1 go build -o out

CMD ["./out"]