#
#
#
#
#
#
#
#
FROM jlesage/baseimage-gui:debian-8

RUN apt-get update && apt-get install -y \
  libc++1 \
  libappindicator1 \
  gconf2 \
  gconf-service \
  gvfs-bin \
  libatomic1 \
  libasound2 \
  libcap2 \
  libgconf-2-4 \
  libgnome-keyring-dev \
  libgtk2.0-0 \
  libnotify4 \
  libnss3 \
  libxkbfile1 \
  libxss1 \
  libxtst6 \
  libx11-xcb1 \
  xdg-utils \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get autoremove -y \
  && apt-get autoclean

RUN groupadd discord \
  && useradd -g discord --create-home --home-dir /home/discord discord

WORKDIR /home/discord
ENV DISCORD_VER 0.0.5

RUN apt-get update && apt-get install -y \
  curl \
  ca-certificates \
  --no-install-recommends \
  && curl -sSL https://dl.discordapp.net/apps/linux/0.0.5/discord-0.0.5.deb > /home/discord/discord-0.0.5.deb \
  && dpkg -i discord-0.0.5.deb \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get purge -y --auto-remove curl ca-certificates \
  && apt-get autoclean \
  && chown -R discord:discord /home/discord

COPY startapp.sh /startapp.sh
#RUN chmod +x /startapp.sh

ENV APP_NAME="Discord"

VOLUME /home/discord/
#ENTRYPOINT [ "/opt/scripts/start.sh" ]