pb:
	  go get -u github.com/golang/protobuf/protoc-gen-go
		@echo "pb Start"
asset:
	bash gen_assets.sh download
	mkdir assets
	cp -v data/*.dat assets/
	#cd assets;curl https://raw.githubusercontent.com/lasthinker/android-lib-v2ray-lite/master/data/geosite.dat > geosite.dat
	#cd assets;curl https://raw.githubusercontent.com/lasthinker/android lib-v2ray-lite/master/data/geoip.dat > geoip.dat

fetchDep:
	go get -v golang.org/x/mobile/cmd/...
	mkdir -p $(shell go env GOPATH)/src/v2ray.com/core
	git clone https://github.com/v2fly/v2ray-core.git $(shell go env GOPATH)/src/v2ray.com/core
	go get -d github.com/lasthinker/android-lib-v2ray-lite

ANDROID_HOME=$(HOME)/android-sdk-linux
export ANDROID_HOME
PATH:=$(PATH):$(GOPATH)/bin
export PATH
downloadGoMobile:
	cd ~ ;curl -L https://raw.githubusercontent.com/lasthinker/android-lib-v2ray-lite/master/ubuntu-cli-install-android-sdk.sh | sudo bash -
	ls ~
	ls ~/android-sdk-linux/

BuildMobile:
	gomobile init
	gomobile bind -v -ldflags='-s -w' github.com/lasthinker/android-lib-v2ray-lite

all: asset pb fetchDep
	@echo DONE
