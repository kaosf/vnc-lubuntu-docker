FROM ubuntu:24.04 AS xdotool
RUN apt-get update && apt-get -y install git build-essential libx11-dev libxinerama-dev libxtst-dev
RUN git clone https://github.com/jordansissel/xdotool.git /xdotool
WORKDIR /xdotool
RUN git checkout edbbb7a8f664ceacbb2cffbe8ee4f5a26b5addc8 && make static && make install

FROM ubuntu:24.04
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y install tightvncserver lxde curl
RUN curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg && \
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | tee /etc/apt/sources.list.d/brave-browser-release.list && \
  apt-get update && apt-get -y install brave-browser
COPY --from=xdotool ["/usr/local/bin/xdotool", "/usr/local/bin/xdotool"]
COPY --from=xdotool ["/usr/local/lib/libxdo.so.3", "/usr/local/lib/libxdo.so.3"]
RUN ln -sf /usr/local/lib/libxdo.so.3 /usr/local/lib/libxdo.so
VOLUME /root
WORKDIR /root
CMD ["tail", "-f", "/dev/null"]
