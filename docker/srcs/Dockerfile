FROM vault:1.8.1

WORKDIR /root
#RUN apk add --no-cache \
#	curl \
#	vim \

COPY . .

RUN mkdir -p ./vault/data && \
	mkdir -p ./log

RUN chmod +x ./srcs/start_script.sh
RUN sh ./srcs/start_script.sh

CMD ["/bin/sh"]
