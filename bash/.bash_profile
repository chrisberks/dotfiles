#!/bin/bash

# Load .bashrc, which loads: ~/.{bash_prompt,aliases,functions,extra,exports}
if [[ -r "$HOME/.bashrc" ]]; then
	# shellcheck source=/dev/null
	. "$HOME/.bashrc"
fi
