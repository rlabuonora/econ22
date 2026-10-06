.PHONY: help check build serve change-date slides-check slides-render slides-charts env-setup r

HUGO_FLAGS ?= -D -F
ENV_RUN = bash scripts/with-project-env.sh
# Render changed posts as well as new posts; blogdown defaults to no Rmd rendering.
BUILD_RMD ?= timestamp

help:
	@printf '%s\n' \
		'make build  - Render .Rmd content with blogdown' \
		'make serve  - Serve the site with Hugo at http://localhost:1313' \
		'make check  - Verify required tools are available' \
		'make change-date OLD=YYYY-MM-DD NEW=YYYY-MM-DD SLUG=post-slug' \
		'make slides-check  - Verify Quarto is available for slide rendering' \
		'make slides-charts - Regenerate course charts with project R' \
		'make slides-render - Render Quarto slide decks into static/slides/'
	@printf '%s\n' 'make env-setup - Create the isolated R 4.5.3 environment' 'make r - Open R in the project environment'

env-setup:
	bash scripts/setup-r-env.sh

r:
	$(ENV_RUN) R

check:
	@$(ENV_RUN) bash -c 'command -v Rscript >/dev/null || { echo "Rscript not found in project environment."; exit 1; }'
	@$(ENV_RUN) bash -c 'command -v pandoc >/dev/null || { echo "pandoc not found in project environment."; exit 1; }'
	@$(ENV_RUN) bash -c 'command -v hugo >/dev/null || { echo "hugo not found. Install Hugo 0.110.0 and add it to PATH."; exit 1; }'

build: check slides-render
	$(ENV_RUN) Rscript -e 'mode <- "$(BUILD_RMD)"; blogdown::build_site(build_rmd=switch(mode, "TRUE"=TRUE, "FALSE"=FALSE, mode))'

serve: check
	$(ENV_RUN) hugo server $(HUGO_FLAGS)

change-date:
	@test -n "$(OLD)" || { echo 'OLD is required, e.g. make change-date OLD=2025-06-01 NEW=2026-03-05 SLUG=introduccion'; exit 1; }
	@test -n "$(NEW)" || { echo 'NEW is required, e.g. make change-date OLD=2025-06-01 NEW=2026-03-05 SLUG=introduccion'; exit 1; }
	@test -n "$(SLUG)" || { echo 'SLUG is required, e.g. make change-date OLD=2025-06-01 NEW=2026-03-05 SLUG=introduccion'; exit 1; }
	bash scripts/change-post-date.sh "$(OLD)" "$(NEW)" "$(SLUG)"

slides-check:
	@$(ENV_RUN) bash -c 'command -v quarto >/dev/null || { echo "quarto not found. Install Quarto and add it to PATH."; exit 1; }'

slides-charts:
	$(ENV_RUN) Rscript scripts/render-externalities-charts.R
	$(ENV_RUN) Rscript scripts/render-textbook-diagrams.R

slides-render: slides-check slides-charts
	$(ENV_RUN) bash scripts/render-slides.sh
