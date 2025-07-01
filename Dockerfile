# Stage 1: Build the Go binary
FROM golang:latest AS builder

# /app is the working directory in the container
WORKDIR /app

COPY main.go .

# Disabling CGO helps in creating a statically linked binary
# GOOS=linux ensures the binary is compatible with Linux containers
RUN CGO_ENABLED=0 GOOS=linux go build -o server main.go

# Stage 2: Create a minimal image with the Go binary
# Scratch is an empty image
FROM scratch

COPY --from=builder /app/server /server

EXPOSE 8080

ENTRYPOINT ["/server"]