PROJECT := veilid
NAME   := $(PROJECT)
TAG    := dev-$$(git rev-parse --short HEAD)
IMG    := $(NAME):$(TAG)
LATEST := $(NAME):latest-dev

.PHONY: build force-build run push

ARGS= -t $(IMG)
BUILD=@podman build
TAGS=@podman tag $(IMG) $(LATEST)

build:
	$(BUILD) $(ARGS) .
	$(TAGS)

force-build:
	$(BUILD) --no-cache $(ARGS) .
	$(TAGS)

build-arm64:
	$(BUILD) --no-cache $(ARGS) . --platform linux/arm64
	$(TAGS)

run:
	@podman run -p 5959:5959 -p 5150:5150/udp -p 5150:5150/tcp -it --rm --name $(PROJECT) -t $(LATEST)

exec:
	@podman exec -it $(PROJECT) /bin/bash

run-bash:
	@podman run --entrypoint /bin/bash -it --rm --name $(PROJECT) -t $(LATEST)