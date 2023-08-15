# veilid OCI image

![pipeline status](https://github.com/chimbosonic/veilid-container/actions/workflows/main.yml/badge.svg?branch=main)

This is a veilid OCI image built using https://gitlab.com/veilid/veilid.

Base image is `apline:latest`.

The image can be pulled from the following repositories:
- Docker Hub [here](https://hub.docker.com/repository/docker/chimbosonic/veilid)
- Quay.io [here](https://quay.io/repository/chimbosonic/veilid)

Source code and pipeline can be found [here](https://github.com/chimbosonic/veilid-container)

## Image Verification

The image is signed using [cosign](https://github.com/sigstore/cosign) from sigstore.

You can verify the signature with:

```bash
cosign verify --key cosign.pub chimbosonic/veilid:latest
```

## Running it

### plain podman

```bash
podman run -p 5959:5959 -p 5150:5150/udp -p 5150:5150/tcp -it --rm chimbosonic/veilid:latest
```

You can access the `veilid-cli` inside the container with:
```bash
podman exec -it <container-name> veilid-cli
```

port `5959` has the client api exposed and port `5150` has the network listeners.


### How to build

This will build the container.

```bash
make build
```

# Notes
I'm still figuring out how this is used and their docs aren't complete yet but this should be a fully functional server node of veilid.

All credit to [Veilid team](https://veilid.com/about-us/) 