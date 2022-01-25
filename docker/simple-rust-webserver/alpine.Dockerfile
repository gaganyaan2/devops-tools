FROM rust:slim-buster AS build
WORKDIR /opt
RUN rustup target add x86_64-unknown-linux-musl
COPY . .
RUN cargo build --target x86_64-unknown-linux-musl --release

FROM alpine:3.15.0
WORKDIR /opt
COPY --from=build /opt/target/x86_64-unknown-linux-musl/release/simple-rust-webserver .
EXPOSE 7878
CMD ["/opt/simple-rust-webserver"]
