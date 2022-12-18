FROM vault:1.6.1

WORKDIR /root

RUN mkdir -p vault/data
RUN mkdir log

COPY . .

EXPOSE 8200

CMD ["vault", "server -config=config.hcl"]