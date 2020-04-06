FROM bitsler/wallet-base:latest

ENV HOME /qtum

ENV USER_ID 1000
ENV GROUP_ID 1000

RUN groupadd -g ${GROUP_ID} qtum \
  && useradd -u ${USER_ID} -g qtum -s /bin/bash -m -d /qtum qtum \
  && set -x \
  && apt-get update -y \
  && apt-get install -y curl gosu wget \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG version=0.19.0.1
ENV QTUM_VERSION=$version

RUN curl -sL https://s.qtum.site/wallet/desktop/qtum-$QTUM_VERSION-x86_64-linux-gnu.tar.gz | tar xz --strip=2 -C /usr/local/bin

ADD ./bin /usr/local/bin
RUN chmod +x /usr/local/bin/qtum_oneshot

VOLUME ["/qtum"]

EXPOSE 3888 3889

WORKDIR /qtum

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["qtum_oneshot"]
