# Shared course palette and ggplot theme; fonts remain text in SVG exports.
course_palette <- c(private = "#5e82ae", social = "#b36b35",
                    ink = "#23313d", guide = "#8b969f", grid = "#e8edf2")
course_chart_theme <- function() {
  ggplot2::theme_minimal(base_size = 24, base_family = "sans") +
    ggplot2::theme(
      panel.grid.minor = ggplot2::element_blank(),
      panel.grid.major = ggplot2::element_line(color = course_palette[["grid"]]),
      axis.line = ggplot2::element_line(color = course_palette[["ink"]], linewidth = 0.6),
      axis.text = ggplot2::element_text(color = course_palette[["ink"]], size = 20),
      axis.title = ggplot2::element_text(color = course_palette[["ink"]], size = 24),
      axis.title.x = ggplot2::element_text(margin = ggplot2::margin(t = 12)),
      axis.title.y = ggplot2::element_text(margin = ggplot2::margin(r = 12)),
      plot.margin = ggplot2::margin(15, 20, 10, 12),
      legend.position = "none"
    )
}
