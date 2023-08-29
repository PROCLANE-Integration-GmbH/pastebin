FROM rustlang/rust:nightly-bookworm-slim as builder

RUN apt-get update && apt-get install -y apt-utils software-properties-common lsb-release clang lldb lld libclang-dev

WORKDIR /usr/src/pastebin
COPY . .

RUN cargo install --path .

FROM gcr.io/distroless/cc-debian12
COPY --from=builder /usr/local/cargo/bin/pastebin /usr/local/bin/pastebin

ENTRYPOINT ["pastebin"]
CMD ["--help"]
