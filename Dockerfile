FROM library/rust:latest as builder

WORKDIR /opt

RUN git clone --branch main --depth 1 --recurse-submodules https://gitlab.com/veilid/veilid.git;
WORKDIR /opt/veilid

RUN apt update -y && apt install -y checkinstall cmake build-essential capnproto protobuf-compiler
RUN cd veilid-server && cargo build --release;
RUN cd veilid-cli && cargo build --release;

FROM library/rust:slim

COPY --from=builder /opt/veilid/target/release/veilid-server /usr/bin/veilid-server
COPY --from=builder /opt/veilid/target/release/veilid-cli /usr/bin/veilid-cli


RUN apt update -y && apt install -y tini && rm -rf /var/lib/apt/lists/*;

EXPOSE 5150/tcp

EXPOSE 5150/udp

EXPOSE 5959/tcp

ENTRYPOINT ["/usr/bin/tini","--","veilid-server"]