BUILD_DATE:=$(shell date +%s)
LAST_DATE:=$(shell [ -f .build_date ] && cat .build_date)
TAG="hildjj/lockbox-build"

latest: .build_date
	docker build -t $(TAG) --build-arg BUILD_DATE=$(BUILD_DATE) .

run:
	docker run -v $(PWD):/tmp/host --rm -it $(TAG)

scratch: .build_date
	docker build -t $(TAG) --no-cache .

last:
	docker build -t $(TAG) --build-arg BUILD_DATE=$(LAST_DATE) .

push:
	docker tag $(TAG) $(TAG):${LAST_DATE}
	docker tag $(TAG) $(TAG):latest
	docker push $(TAG)

clean:
	$(RM) .build_date

.build_date: FORCE
	echo $(BUILD_DATE) > .build_date

FORCE: