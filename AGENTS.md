# AGENTS.md

## Project

This repository is a Hugo/blogdown course website that deploys to Netlify from the `main` branch.

## Key Commands

- `make check`
  Verifies that `Rscript`, `pandoc`, and `hugo` are available on `PATH`.

- `make build`
  Re-renders `.Rmd` content via `blogdown::build_site()`.

- `make serve`
  Serves the site locally with `hugo server -D -F`.

- `make change-date OLD=YYYY-MM-DD NEW=YYYY-MM-DD SLUG=post-slug`
  Renames a post bundle from the old date prefix to the new date prefix and updates the front matter `date:` in `index.Rmd` and committed `index.html`.

- `make slides-check`
  Verifies that `quarto` is available for slide rendering.

- `make slides-render`
  Renders Quarto slide decks from `slides/` into `static/slides/`.

## Content Conventions

- Posts live in bundle directories under `content/post/`.
- Bundle names are date-prefixed: `YYYY-MM-DD-slug`.
- Keep the bundle directory name and the front matter `date:` aligned.
- This repo commits generated post HTML, so after changing `.Rmd` content or dates, run `make build`.

## Local Workflow

- Preferred local workflow in WSL/macOS:
  1. `make build`
  2. `make serve`
- Open the local site at `http://localhost:1313`.
- If a site was started from R with `blogdown::serve_site()`, stop it with `blogdown::stop_server()`.
- For Quarto slides, render with `make slides-render` before previewing the site.

## Deploy

- Preferred deploy path is `git push origin main`.
- Netlify builds the site from GitHub; do not rely on Netlify CLI for routine deploys.

## Notes

- Netlify is pinned to Hugo `0.110.0` and Node `22` in `netlify.toml`.
- A local shell may need Hugo on `PATH`; in WSL this is provided via the user `~/.bashrc`, not the repo.
- Quarto slide sources live under `slides/`; rendered slide artifacts live under `static/slides/`.
