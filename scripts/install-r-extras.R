# Conda supplies all dependencies; keep the CRAN-only package in .r-library.
package <- "xaringanExtra"
version <- "0.8.0"
checksum <- "457dd97a653add14845040006a052014"
library_dir <- Sys.getenv("R_LIBS_USER")

if (requireNamespace(package, quietly = TRUE) &&
    as.character(packageVersion(package)) == version) {
  message(package, " ", version, " is already installed.")
} else {
  archive <- tempfile(fileext = ".tar.gz")
  urls <- c(
    sprintf("https://cloud.r-project.org/src/contrib/%s_%s.tar.gz", package, version),
    sprintf("https://cloud.r-project.org/src/contrib/Archive/%s/%s_%s.tar.gz", package, package, version)
  )
  downloaded <- FALSE
  for (url in urls) {
    result <- try(download.file(url, archive, mode = "wb", quiet = TRUE), silent = TRUE)
    if (!inherits(result, "try-error") && identical(result, 0L)) {
      downloaded <- TRUE
      break
    }
  }
  if (!downloaded) stop("Could not download ", package, " ", version)
  if (unname(tools::md5sum(archive)) != checksum) stop("Package checksum mismatch")
  install.packages(archive, lib = library_dir, repos = NULL, type = "source")
  unlink(archive)
  stopifnot(requireNamespace(package, quietly = TRUE),
            as.character(packageVersion(package)) == version)
}
