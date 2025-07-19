# Stage 1: Build the Go application

## The Golang image provides the runtime for compilation. We name this stage as "builder".
FROM golang:latest AS builder

## Setting the work directory runs subsequent COPY and RUN commands from /app.
## By convention, we put application content into the /app directory within the image.
WORKDIR /app

## Copy server code from our machine to the container.
COPY go.mod main.go ./

## Compile the server. Check note below.
RUN CGO_ENABLED=0 GOOS=linux go build -o server main.go

# Stage 2: Execute the binary

## Scratch is a minimal image with nothing installed.
FROM scratch

## Copy the compiled binary from the builder stage.
COPY --from=builder /app/server /server

## Document the port the server listens on. This does not add any functionality.
EXPOSE 8080

## Setting our compiled server as the entrypoint will launch it when we run this image.
ENTRYPOINT ["/server"]
