
HAS_DOCKER := $(shell command -v docker;)
ifndef HAS_DOCKER
	$(error You MUST install docker)
endif

if [ -d $(pwd)/roles ]; then 
  docker run -v $(pwd):/root/ -it ansible-runner "ansible-galaxy install"
fi

all: install configure
  echo "All OK"
  
install:
  docker run -v $(pwd):/root/ -it ansible-runner "make install-raw"

install-raw:
  ansible-playbook install.yaml

configure:
  docker run -v $(pwd):/root/ -it ansible-runner "make configure-raw"

configure-raw:
  ansible-playbook configure.yaml