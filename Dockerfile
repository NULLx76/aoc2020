FROM elixir:slim as base

WORKDIR /app

RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
    cargo \
    python-pip; \
    rm -rf /var/lib/apt/lists/*

RUN mix local.hex --force
RUN mix local.rebar --force
