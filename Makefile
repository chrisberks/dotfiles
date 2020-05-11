.PHONY: list-plugins
list-plugins:
	@git submodule foreach \
		--quiet 'echo $$toplevel/$$displaypath' \
		| grep pack \
		| xargs -I{} git -C {} config --get remote.origin.url
