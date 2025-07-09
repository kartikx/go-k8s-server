# Stage 1: Build the Go application

## The Golang image provides the runtime for compilation.
FROM golang:latest AS builder

# By convention, we put application content into the /app directory within the image.
# Setting the work directory runs subsequent COPY and RUN commands from /app.
WORKDIR /app

## Copy server code from our machine to the container.
COPY go.mod main.go ./

## Compile our server to run on linux. Disabling CGO creates a static binary.
RUN CGO_ENABLED=0 GOOS=linux go build -o server main.go

# Stage 2: Execute the binary

## Scratch is a minimal image
FROM scratch

## Copy the compiled binary from the builder stage.
COPY --from=builder /app/server /server

## Document the port the server listens on.
EXPOSE 8080

## Launching the container will run the server binary.
ENTRYPOINT ["/server"]