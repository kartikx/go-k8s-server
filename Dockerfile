# Stage 1: Build the Go application
FROM golang:latest as builder

WORKDIR /app

COPY main.go .

RUN CGO_ENABLED=0 GOOS=linux go build -o server main.go

# Stage 2: Create a minimal image with the Go binary
FROM scratch

COPY --from=builder /app/server /server

EXPOSE 8080

ENTRYPOINT ["/server"]