
#HAS_DOCKER := $(shell command -v docker;)
#ifndef HAS_DOCKER
#  $(error You MUST install docker)
#endif


deps: build-quiet
	docker run --name runner -v $(shell pwd):/home/cloud-user/lucy --rm -it --entrypoint /home/cloud-user/runCommand.sh lucy-runner "ansible-galaxy role install -p roles -r requirements.yml"

debug:
	docker run --name runner -v $(shell pwd):/home/cloud-user/lucy --rm -it ansible-runner 

build:
	docker build -t lucy-runner .

build-quiet:
	docker build -q -t lucy-runner .

install: build-quiet
	docker run --name runner --rm -it lucy-runner "make install-raw"

install-raw:
	ansible-playbook install.yaml

configure: build-quiet
	docker run --name runner --rm -it --entrypoint /home/cloud-user/runCommand.sh lucy-runner "make configure-raw"

configure-raw:
	ansible-playbook configure.yaml

lucy: build-quiet
	docker run --name lucy-runner --rm -it lucy-runner 
