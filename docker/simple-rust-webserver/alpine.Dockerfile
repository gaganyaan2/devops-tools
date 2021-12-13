FROM rust:slim-buster AS build
WORKDIR /opt
COPY . .
RUN rustup target add x86_64-unknown-linux-musl
RUN cargo build --target x86_64-unknown-linux-musl --release

FROM alpine:3.15.0
WORKDIR /opt
COPY --from=build /opt/target/x86_64-unknown-linux-musl/release .
EXPOSE 7878
CMD ["/opt/simple-rust-webserver"]