FROM haskell:8 AS build
WORKDIR /opt
#RUN cabal update
RUN cabal install --lib scotty
COPY hola.hs .
#RUN ghc --make -threaded hola.hs  -o hola
RUN ghc --make -threaded -optl-static -optl-pthread hola.hs -o hola

FROM alpine:3.15.0
RUN addgroup -S group1 && adduser -S user1 -G group1
USER user1
WORKDIR /opt
COPY --from=build /opt/hola .
EXPOSE 3000
CMD ["/opt/hola"]