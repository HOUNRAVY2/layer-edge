FROM golang:1.21-alpine

# Clear any cached modules first
RUN go clean -modcache

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=1 go build -o out

CMD ["./out"]