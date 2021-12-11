FROM rust:slim-buster AS build
WORKDIR /opt
COPY . /opt
RUN cargo build

FROM debian:stable-slim
WORKDIR /opt
COPY --from=build /opt/target/debug/simple-rust-webserver
EXPOSE 7878
CMD "/opt/target/debug/simple-rust-webserver"
