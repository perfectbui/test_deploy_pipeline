FROM golang:1.16 AS build-stage

WORKDIR /app
COPY . /app 

RUN CGO_ENABLED=0 && go build -o app-exe ./main.go

# production: 
FROM golang:1.16 as production-stage

COPY --from=build-stage /app/app-exe /bin

EXPOSE 8080

ENTRYPOINT [ "/bin/app-exe" ]
