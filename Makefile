APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=ghcr.io/kozubenko
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux
TARGETARCH=amd64
TELE_TOKEN=111

format:
	gofmt -s -w ./

lint:
	go vet ./...

get:
	go get

test:
	go test -v

build: format get
	@echo "Building for TARGETOS=${TARGETOS} and TARGETARCH=${TARGETARCH} and VERSION=${VERSION}"
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/kozubenko/kbot/cmd.appVersion=${VERSION}

linux: build

macOS:
	$(MAKE) build TARGETOS=darwin TARGETARCH=amd64

macOS_arm64:
	$(MAKE) build TARGETOS=darwin TARGETARCH=arm64

windows:
	$(MAKE) build TARGETOS=windows TARGETARCH=amd64

image: image_linux

image_linux:
	DOCKER_BUILDKIT=1 docker build --no-cache --build-arg TARGETOS=${TARGETOS} --build-arg TARGETARCH=${TARGETARCH} --secret id=tele_token,env=TELE_TOKEN -t ${REGISTRY}/${APP}:${VERSION}-linux-amd64 .

image_macOS:
	DOCKER_BUILDKIT=1 docker build --build-arg TARGETOS=darwin --build-arg TARGETARCH=amd64-t ${REGISTRY}/${APP}:${VERSION}-darwin-amd64 .

image_macOS_arm64:
	DOCKER_BUILDKIT=1 docker build --build-arg TARGETOS=darwin --build-arg TARGETARCH=arm64 -t ${REGISTRY}/${APP}:${VERSION}-darwin-arm64 .

image_windows:
	DOCKER_BUILDKIT=1 docker build --build-arg TARGETOS=windows --build-arg TARGETARCH=amd64 -t ${REGISTRY}/${APP}:${VERSION}-windows-amd64 .

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-linux-amd64

push_linux:
	docker push ${REGISTRY}/${APP}:${VERSION}-linux-amd64

push_macOS:
	docker push ${REGISTRY}/${APP}:${VERSION}-darwin-amd64

push_macOS_arm64:
	docker push ${REGISTRY}/${APP}:${VERSION}-darwin-arm64

push_windows:
	docker push ${REGISTRY}/${APP}:${VERSION}-windows-amd64

clean:
	rm -f kbot
	docker images "${REGISTRY}/${APP}" --format "{{.ID}}" | xargs docker rmi

install_hooks:
	sh scripts/githooks/install-hooks.sh --enable-gitleaks
