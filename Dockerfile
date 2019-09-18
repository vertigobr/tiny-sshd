FROM alpine:latest

LABEL maintainer andre@vertigo.com.br

ADD src/*.sh /opt/

#RUN apk --update add openssh sudo shadow python && \
RUN apk --update add openssh && \
    adduser -D -u 5001 user && \
    addgroup user wheel && \
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    sed -i s/^#PasswordAuthentication.*/PasswordAuthentication\ yes/ /etc/ssh/sshd_config && \
    chmod +x /opt/*.sh && \
    /opt/generatekeys.sh

#RUN sed -i s/^#UsePAM.*/UsePAM\ yes/ /etc/ssh/sshd_config

EXPOSE 22

CMD ["/opt/startsshd.sh"]

