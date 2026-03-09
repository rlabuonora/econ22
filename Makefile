.PHONY: help check build serve change-date slides-check slides-render

HUGO_FLAGS ?= -D -F

help:
	@printf '%s\n' \
		'make build  - Render .Rmd content with blogdown' \
		'make serve  - Serve the site with Hugo at http://localhost:1313' \
		'make check  - Verify required tools are available' \
		'make change-date OLD=YYYY-MM-DD NEW=YYYY-MM-DD SLUG=post-slug' \
		'make slides-check  - Verify Quarto is available for slide rendering' \
		'make slides-render - Render Quarto slide decks into static/slides/'

check:
	@command -v Rscript >/dev/null || { echo 'Rscript not found. Install R so the Rscript command is available.'; exit 1; }
	@command -v pandoc >/dev/null || { echo 'pandoc not found. On macOS: brew install pandoc. On Debian/Ubuntu: sudo apt install pandoc.'; exit 1; }
	@command -v hugo >/dev/null || { echo 'hugo not found. On macOS: brew install hugo. On this WSL setup, ensure ~/.bashrc exports the blogdown Hugo path.'; exit 1; }

build: check slides-render
	Rscript -e "blogdown::build_site()"

serve: check
	hugo server $(HUGO_FLAGS)

change-date:
	@test -n "$(OLD)" || { echo 'OLD is required, e.g. make change-date OLD=2025-06-01 NEW=2026-03-05 SLUG=introduccion'; exit 1; }
	@test -n "$(NEW)" || { echo 'NEW is required, e.g. make change-date OLD=2025-06-01 NEW=2026-03-05 SLUG=introduccion'; exit 1; }
	@test -n "$(SLUG)" || { echo 'SLUG is required, e.g. make change-date OLD=2025-06-01 NEW=2026-03-05 SLUG=introduccion'; exit 1; }
	bash scripts/change-post-date.sh "$(OLD)" "$(NEW)" "$(SLUG)"

slides-check:
	@command -v quarto >/dev/null || { echo 'quarto not found. On macOS: brew install --cask quarto. On Debian/Ubuntu, install Quarto from the official package.'; exit 1; }

slides-render: slides-check
	bash scripts/render-slides.sh
