FROM erlang:21

# elixir expects utf8.
ENV ELIXIR_VERSION="v1.7.3" \
    LANG=C.UTF-8

RUN set -xe \
    && ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/archive/${ELIXIR_VERSION}.tar.gz" \
    && ELIXIR_DOWNLOAD_SHA512="f8b0ac405531d46f4b65f459970c4b82892f8db51028f172072748269a922db65cb58e36239cd26dc39e5bdebd08a0e630ecbc267b6ff55a15d188483d78a0e5" \
    && curl -fSL -o elixir-src.tar.gz $ELIXIR_DOWNLOAD_URL \
    && echo "$ELIXIR_DOWNLOAD_SHA512  elixir-src.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/local/src/elixir \
    && tar -xzC /usr/local/src/elixir --strip-components=1 -f elixir-src.tar.gz \
    && rm elixir-src.tar.gz \
    && cd /usr/local/src/elixir \
    && make install clean

CMD ["iex"]

