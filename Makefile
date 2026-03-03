.PHONY: all
all: requirements.txt

requirements.txt: uv.lock
	uv export -o $@
