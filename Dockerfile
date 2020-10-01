FROM centos:8

LABEL name="Gareth Williams" \
version="1.0.0"

ENV USER csgo
ENV HOME /home/${USER}
ENV STEAM ${HOME}/Steam
ENV CSGO ${HOME}/csgo

RUN yum install -y glibc.i686 libstdc++.i686 curl \ 
    && yum -y clean all \
    && useradd ${USER} \
    && mkdir ${STEAM}

ADD ./scripts/ ${HOME}/scripts

RUN chown -R ${USER}:${USER} ${STEAM} \
    && chmod +x ${HOME}/scripts/*
USER ${USER}

# RUN ls -all ${HOME}
RUN curl "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar -zxv -C ${STEAM} \
    && ${HOME}/scripts/setup.sh

EXPOSE 27015/udp
WORKDIR /home/${USER}/srcds
ENTRYPOINT ${HOME}/scripts/start.sh
CMD [ "-console" "-usercon" "+game_type" "0" "+game_mode" "1" "+mapgroup" "mg_active" "+map" "de_cache" ]
