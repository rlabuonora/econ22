.PHONY: help check build serve

HUGO_FLAGS ?= -D -F

help:
	@printf '%s\n' \
		'make build  - Render .Rmd content with blogdown' \
		'make serve  - Serve the site with Hugo at http://localhost:1313' \
		'make check  - Verify required tools are available'

check:
	@command -v Rscript >/dev/null || { echo 'Rscript not found'; exit 1; }
	@command -v pandoc >/dev/null || { echo 'pandoc not found'; exit 1; }
	@command -v hugo >/dev/null || { echo 'hugo not found'; exit 1; }

build: check
	Rscript -e "blogdown::build_site()"

serve: check
	hugo server $(HUGO_FLAGS)
