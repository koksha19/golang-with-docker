FROM golang:1.24.3-alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod tidy

COPY . .
RUN go build -o fizzbuzz

FROM scratch

WORKDIR /app

COPY --from=builder /app/fizzbuzz .
COPY --from=builder /app/templates/index.html templates/

EXPOSE 8080

CMD ["./fizzbuzz", "serve"]

