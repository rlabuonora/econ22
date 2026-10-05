# Sitio 2022 para mi curso de Economía

Celeste #5e81ac

## Project R environment

This project uses R **4.5.3** in an isolated Miniforge/Conda environment at
`.conda/`. It does not change the default R interpreter or another project's
packages. Conda manages R, Pandoc, R packages and their native dependencies;
the CRAN-only `xaringanExtra` **0.8.0** is installed into `.r-library/` with a
pinned version and checksum. Both directories are ignored by Git.

Install [Miniforge](https://github.com/conda-forge/miniforge), then run:

```sh
make env-setup
make check
make build
make serve
```

Hugo 0.110.0 and Quarto must be available on `PATH`. The build selects the
project's R interpreter for Quarto as well as blogdown. Changed and new `.Rmd`
posts are rendered during `make build`; the generated HTML is committed.
To force all posts to render, use `make build BUILD_RMD=TRUE`.

Open an interactive project R session with `make r`, or run a single command:

```sh
bash scripts/with-project-env.sh Rscript --version
bash scripts/with-project-env.sh Rscript my-script.R
```

The launcher sets the interpreter, package paths and R startup configuration
only for the launched process. It ignores the global `.Renviron`, and the
project `.Rprofile` does not source the global `.Rprofile`. Plain `R` and
`Rscript` in your normal shell keep using your existing installation.

`environment.yml` lists the direct dependencies. `environment-linux-64.lock`
records exact Conda packages for Linux/WSL; setup uses that lock on Linux x86_64
and solves the YAML on other platforms. To deliberately update dependencies,
edit the YAML, update this project's environment and regenerate the lock:

```sh
mamba env update --prefix "$PWD/.conda" --file environment.yml
conda list --prefix "$PWD/.conda" --explicit --md5 > environment-linux-64.lock
```

An R version upgrade also requires rebuilding the CRAN-only package for the
new R version. Remove its directory from `.r-library/`, then run `make env-setup`.
Netlify still builds the committed content with Hugo; it does not need this R
environment.
