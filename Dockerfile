FROM alpine:latest as base
ARG VERSION=0.37.0
RUN wget --no-check-certificate https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_linux_amd64.tar.gz && \
    tar -zxf frp_${VERSION}_linux_amd64.tar.gz && \
    mkdir /var/frp && \
    mv frp_${VERSION}_linux_amd64/* /var/frp

FROM alpine:latest
WORKDIR /app
COPY --from=base /var/frp/frps /app/frps
HEALTHCHECK CMD ["pidof", "frps"]
ENTRYPOINT ["./frps"]