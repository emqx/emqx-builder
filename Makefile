IMAGES = alpine3.15 amzn2 amzn2023 debian10 debian11 debian12 el7 el8 el9 ubuntu18.04 ubuntu20.04 ubuntu22.04

.PHONY: all
all: $(IMAGES)

.PHONY: $(IMAGES)
define gen-build-image-target
$1:
	@docker build -t ghcr.io/emqx/emqx-builder:$1-base $1
	@docker build --build-arg BUILD_FROM=ghcr.io/emqx/emqx-builder:$1-base -t ghcr.io/emqx/emqx-builder:$1 .
endef
$(foreach img,$(IMAGES),$(eval $(call gen-build-image-target,$(img))))

.PHONY: $(IMAGES:%=%-push)
define gen-push-image-target
$1-push:
	@docker push ghcr.io/emqx/emqx-builder:$1-base
	@docker push ghcr.io/emqx/emqx-builder:$1
endef
$(foreach img,$(IMAGES),$(eval $(call gen-push-image-target,$(img))))
