# STAGE 1

FROM ubuntu:18.04 AS build 

RUN apt-get update && apt-get install -y golang-go

ENV GO111MODULE=off

COPY . .

RUN CGO_ENABLED=0 go build -o /app .

# STAGE 2

FROM scratch

COPY --from=build /app /app

ENTRYPOINT ["/app"]
